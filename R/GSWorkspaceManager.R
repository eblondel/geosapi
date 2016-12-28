#' Geoserver REST API Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api workspace
#' @return Object of \code{\link{R6Class}} with methods for managing the workspaces
#'  of a GeoServer instance.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSWorkspaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(}}{
#'    This method is used to instantiate a GSWorkspaceManager
#'  }
#'  \item{\code{getWorkspaces()}}{
#'    Get the list of available workspace. Returns an object of class \code{list}
#'    containing items of class \code{\link{GSWorkspace}}
#'  }
#'  \item{\code{getWorkspaceNames()}}{
#'    Get the list of available workspace names. Returns an vector of class 
#'    \code{character}
#'  }
#'  \item{\code{getWorkspace(name)}}{
#'    Get a \code{\link{GSWorkspace}} object given a workspace name.
#'  }
#'  \item{\code{createWorkspace(name, uri)}}{
#'    Creates a GeoServer workspace given a name, and an optional URI. Returns
#'    \code{TRUE} if the workspace has been successfully created, \code{FALSE}
#'    otherwise
#'  }
#'  \item{\code{deleteWorkspace(name)}}{
#'    Deletes a GeoServer workspace given a name. Returns \code{TRUE} if the 
#'    workspace has been successfully deleted, \code{FALSE} otherwise
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorkspaceManager <- R6Class("GSWorkspaceManager",
  inherit = GSManager,

  public = list(
    
    getWorkspaces = function(){
      req <- self$GET("/workspaces.xml")
      wsXml <- content(req)
      wsXmlList <- xml_find_all(wsXml, "//workspace")
      wsList <- lapply(as_list(wsXmlList), function(x){
        xml <- xml_add_child(xml_new_document(), x)
        return(GSWorkspace$new(xml))
      })
      return(wsList)
    },
    
    getWorkspaceNames = function(){
      wsList <- sapply(self$getWorkspaces(), function(x){x$name})
      return(wsList)
    },
    
    getWorkspace = function(name){
      req <- self$GET(sprintf("/workspaces/%s.xml", name))
      ws <- NULL
      if(status_code(req) == 200){
        wsXML <- content(req)
        ws <- GSWorkspace$new(wsXML)
      }
      return(ws)
    },
    
    createWorkspace = function(name, uri){
      created <- FALSE
      if(missing(uri)){
        xml <- sprintf("<workspace><name>%s</name></workspace>", name)
        req <- self$POST(
          path = "/workspaces",
          content = xml,
          contentType = "text/xml"
        )
        if(status_code(req) == 201){
          created = TRUE
        }
      }else{
        #TODO alias to createNamespace
      }
      return(created)
    },
    
    deleteWorkspace = function(name, recurse = FALSE){
      deleted <- FALSE
      path <- sprintf("/workspaces/%s", name)
      if(recurse) path <- paste0(path, "?recurse=true")
      #TODO hack for style removing (not managed by REST API)
      
      req <- self$DELETE(path = path)
      if(status_code(req) == 200){
        deleted = TRUE
      }
      return(deleted)
    }   
    
  )
  
)