#' Geoserver REST API Style Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api style
#' @return Object of \code{\link{R6Class}} with methods for managing the styles
#' of a GeoServer instance.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSStyleManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, user, pwd, logger)}}{
#'    This method is used to instantiate a GSManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd}). By default,
#'    the \code{logger} argument will be set to \code{NULL} (no logger). This argument
#'    accepts two possible values: \code{INFO}: to print only geosapi logs,
#'    \code{DEBUG}: to print geosapi and CURL logs
#'  }
#'  \item{\code{getStyles()}}{
#'    Get the list of available styles. Returns an object of class \code{list}
#'    containing items of class \code{\link{GSStyle}}
#'  }
#'  \item{\code{getStyleNames()}}{
#'    Get the list of available style names. Returns an vector of class 
#'    \code{character}
#'  }
#'  \item{\code{getStyle(style)}}{
#'    Get a \code{\link{GSStyle}} object given a style name.
#'  }
#'  \item{\code{createStyle(file, sldBody, name, raw, ws)}}{
#'    Creates a GeoServer style given a name. Returns \code{TRUE} if the style 
#'    has been successfully created, \code{FALSE} otherwise
#'  }
#'  \item{\code{updateStyle(file, sldBody, name, raw, ws)}}{
#'    Updates a GeoServer style. Returns \code{TRUE} if the style has been 
#'    successfully updated, \code{FALSE} otherwise
#'  }
#'  \item{\code{deleteStyle(style, recurse, purge, ws)}}{
#'    Deletes a GeoServer style given a name. Returns \code{TRUE} if the style 
#'    has been successfully deleted, \code{FALSE} otherwise
#'  }
#'  \item{\code{getSLDVersion(sldBody)}}{
#'    Get the SLD version from the XML object (of class \code{XMLInternalDocument})
#'  }
#'  \item{\code{getSLDBody(style, ws = NULL)}}{
#'    Get the SLD Body given a style name. This method is only supported for
#'    Geoserver >= 2.2.
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSStyleManager <- R6Class("GSStyleManager",
  inherit = GSManager,
  
  public = list(
    
    #getStyles
    #---------------------------------------------------------------------------
    getStyles = function(){
      self$INFO("Fetching list of styles")
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         "/styles.xml", self$verbose.debug)
      styleList <- NULL
      if(status_code(req) == 200){
        styleXML <- GSUtils$parseResponseXML(req)
        styleXMLList <- getNodeSet(styleXML, "//style")
        styleList <- lapply(styleXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSStyle$new(xml = xml))
        })
        self$INFO(sprintf("Successfully fetched %s styles", length(styleList)))
      }else{
        self$ERROR("Error while fetching list of styles")
      }
      return(styleList)
    },
    
    #getStyleNames
    #---------------------------------------------------------------------------
    getStyleNames = function(){
      styleList <- sapply(self$getStyles(), function(x){x$name})
      return(styleList)
    },
    
    #getStyle
    #---------------------------------------------------------------------------
    getStyle = function(style, ws = NULL){
      self$INFO(sprintf("Fetching style '%s'", style))
      reqUrl <- ""
      if(!missing(ws) & !is.null(ws)){
        reqUrl <- sprintf("/workspaces/%s", ws)
      }
      reqUrl <- paste0(reqUrl, sprintf("/styles/%s.xml", style))
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         reqUrl, self$verbose.debug)
      style <- NULL
      if(status_code(req) == 200){
        styleXML <- GSUtils$parseResponseXML(req)
        style <- GSStyle$new(xml = styleXML)
        self$INFO("Successfully fetched style!")
      }else{
        self$ERROR("Error while fetching style")
      }
      return(style)
    },
    
    #createStyle
    #---------------------------------------------------------------------------
    createStyle = function(file, sldBody = NULL, name, raw = FALSE, ws = NULL){
      self$INFO(sprintf("Creating style '%s'", name))
      created <- FALSE
      
      if(!missing(file)){
        content <- readChar(file, file.info(file)$size)
        if(!isXMLString(content)){
          stop("SLD style is not recognized XML")
        }
        sldBody <- XML::xmlParse(content)
      }
    
      if(!is(sldBody, "XMLInternalDocument")){
        stop("SLD body is not an XML document object")
      }
      
      contentType <- switch(self$getSLDVersion(sldBody),
                            "1.0.0" = "application/vnd.ogc.sld+xml",
                            "1.1.0" = "application/vnd.ogc.se+xml",
                            NULL
                     )
      if(is.null(contentType)){
        stop("Not contentType specified for style creation")
      }
      
      reqUrl <- ""
      if(!missing(ws) & is.null(ws)){
        reqUrl <- sprintf("/workspaces/%s", ws)
      }
      reqUrl <- paste0(reqUrl, "/styles?name=", name)
      if(raw) reqUrl <- paste0(reqUrl, "&raw=", tolower(as.character(raw)))
      
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = reqUrl,
        content = as(sldBody, "character"),
        contentType = contentType,
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        self$INFO("Successfully created style!")
        created = TRUE
      }else{
        self$ERROR("Error while creating style")
      }
      return(created)
    },
    
    #updateStyle
    #---------------------------------------------------------------------------
    updateStyle = function(file, sldBody = NULL, name, raw = FALSE, ws = NULL){
      self$INFO(sprintf("Updating style '%s'", name))
      
      if(!missing(file)){
        content <- readChar(file, file.info(file)$size)
        if(!isXMLString(content)){
          stop("SLD style is not recognized XML")
        }
        sldBody <- XML::xmlParse(content)
      }
      
      if(!is(sldBody, "XMLInternalDocument")){
        stop("SLD body is not an XML document object")
      }
      
      contentType <- switch(self$getSLDVersion(sldBody),
                            "1.0.0" = "application/vnd.ogc.sld+xml",
                            "1.1.0" = "application/vnd.ogc.se+xml",
                            NULL
      )
      if(is.null(contentType)){
        stop("Not contentType specified for style creation")
      }
      
      reqUrl <- ""
      if(!missing(ws) & is.null(ws)){
        reqUrl <- sprintf("/workspaces/%s", ws)
      }
      reqUrl <- paste0(reqUrl, sprintf("/styles/%s.xml", name))
      if(raw) reqUrl <- paste0(reqUrl, "&raw=", tolower(as.character(raw)))
      
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = reqUrl,
        content = as(sldBody, "character"),
        contentType = contentType,
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully updated style!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating style")
      }
      return(updated)
    },
    
    #deleteStyle
    #---------------------------------------------------------------------------
    deleteStyle = function(name, recurse = FALSE, purge = FALSE, ws = NULL){
      self$INFO(sprintf("Deleting style '%s'", name))
      deleted <- FALSE
      
      path <- ""
      if(!missing(ws) & is.null(ws)){
        path <- sprintf("/workspaces/%s", ws)
      }
      path <- paste0(path, sprintf("/styles/%s", name))
      path <- paste0(path, "?recurse=", tolower(as.character(recurse)))
      path <- paste0(path, "&purge=", tolower(as.character(recurse)))
      #TODO hack for style removing (not managed by REST API) - check version
      
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully deleted style!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting style")
      }
      return(deleted)
    },
    
    #getSLDVersion
    #---------------------------------------------------------------------------
    getSLDVersion = function(sldBody){
      return(xmlGetAttr(xmlChildren(sldBody)[[1]], "version"))
    },
    
    #getSLDBody
    #---------------------------------------------------------------------------
    getSLDBody = function(style, ws = NULL){
      
      if(self$version$lowerThan("2.2")){
        err <- sprintf("Unsupported method for GeoServer %s", self$version$version)
        self$ERROR(err)
        stop(err)
      }
      
      self$INFO(sprintf("Fetching SLD body for style '%s'", style))
      reqUrl <- ""
      if(!missing(ws) & !is.null(ws)){
        reqUrl <- sprintf("/workspaces/%s", ws)
      }
      reqUrl <- paste0(reqUrl, sprintf("/styles/%s.sld", style))
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         reqUrl, self$verbose.debug)
      style <- NULL
      if(status_code(req) == 200){
        style <- GSUtils$parseResponseXML(req)
        self$INFO("Successfully fetched SLD body!")
      }else{
        self$ERROR("Error while fetching SLD body")
      }
      return(style)
    }
    
  )
                              
)