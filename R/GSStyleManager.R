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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSStyleManager <- R6Class("GSStyleManager",
  inherit = GSManager,
  public = list(
    
    #'@description Get the list of available styles. 
    #'@param ws an optional workspace name
    #'@return an object of class \code{list} containing items of class \code{\link{GSStyle}}
    getStyles = function(ws = NULL){
      self$INFO("Fetching list of styles")
      req_url <- "/styles.xml"
      if(!is.null(ws)) req_url <- sprintf("/workspaces/%s/styles.xml", ws)
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         req_url, self$verbose.debug)
      styleList <- NULL
      if(status_code(req) == 200){
        styleXML <- GSUtils$parseResponseXML(req)
        styleXMLList <- as(xml2::xml_find_all(styleXML, "//style"), "list")
        styleList <- lapply(styleXMLList, GSStyle$new)
        self$INFO(sprintf("Successfully fetched %s styles", length(styleList)))
      }else{
        self$ERROR("Error while fetching list of styles")
      }
      return(styleList)
    },
    
    #'@description Get the list of available style names
    #'@param ws an optional workspace name
    #'@return a vector of class \code{character}
    getStyleNames = function(ws = NULL){
      styleList <- sapply(self$getStyles(ws = ws), function(x){x$name})
      return(styleList)
    },
    
    #'@description Get a \code{\link{GSStyle}} object given a style name.
    #'@param style style name
    #'@param ws workspace name. Optional
    #'@return object of class \link{GSStyle}
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
    
    #'@description Creates a GeoServer style given a name.
    #'@param file file
    #'@param sldBody SLD body
    #'@param name name
    #'@param raw raw
    #'@param ws workspace name
    #'@return \code{TRUE} if the style has been successfully created, \code{FALSE} otherwise
    createStyle = function(file, sldBody = NULL, name, raw = FALSE, ws = NULL){
      self$INFO(sprintf("Creating style '%s'", name))
      created <- FALSE
      
      if(!missing(file)){
        content <- readChar(file, file.info(file)$size)
        if(!GSUtils$isXMLString(content)){
          stop("SLD style is not recognized XML")
        }
        sldBody <- xml2::read_xml(content)
      }
    
      if(!is(sldBody, "xml_document")){
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
      if(!missing(ws) & !is.null(ws)){
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
    
    #'@description Updates a GeoServer style given a name.
    #'@param file file
    #'@param sldBody SLD body
    #'@param name name
    #'@param raw raw
    #'@param ws workspace name
    #'@return \code{TRUE} if the style has been successfully updated, \code{FALSE} otherwise
    updateStyle = function(file, sldBody = NULL, name, raw = FALSE, ws = NULL){
      self$INFO(sprintf("Updating style '%s'", name))
      
      if(!missing(file)){
        content <- readChar(file, file.info(file)$size)
        if(!GSUtils$isXMLString(content)){
          stop("SLD style is not recognized XML")
        }
        sldBody <- xml2::read_xml(content)
      }
      
      if(!is(sldBody, "xml_document")){
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
      if(!missing(ws) & !is.null(ws)){
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
    
    #'@description Deletes a style given a name.
    #'    By defaut, the option \code{recurse} is set to FALSE, ie datastore layers are not removed.
    #'    To remove all coverage store layers, set this option to TRUE. The \code{purge} parameter is used 
    #'    to customize the delete of files on disk (in case the underlying reader implements a delete method).
    #'@param name name
    #'@param recurse recurse
    #'@param purge purge
    #'@param ws workspace name
    #'@return \code{TRUE} if the style has been successfully deleted, \code{FALSE} otherwise
    deleteStyle = function(name, recurse = FALSE, purge = FALSE, ws = NULL){
      self$INFO(sprintf("Deleting style '%s'", name))
      deleted <- FALSE
      
      path <- ""
      if(!missing(ws) & !is.null(ws)){
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
    
    #'@description Get SLD version
    #'@param sldBody SLD body
    getSLDVersion = function(sldBody){
      return(xml2::xml_attr(sldBody, "version"))
    },
    
    #'@description Get SLD body
    #'@param style style name
    #'@param ws workspace name
    #'@return an object of class \link{xml_node-class}
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