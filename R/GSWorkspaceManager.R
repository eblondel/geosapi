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
#'    Get the list of available workspaces.
#'  }
#'  \item{\code{getWorkspaceNames()}}{
#'    Get the list of available workspace names. Returns an object of class
#'    \code{xml_nodeset}
#'  }
#'  \item{\code{getWorkspace(name)}}{
#'    Get a \code{\link{GSWorkspace}} object given a workspace name. Returns an
#'    vector of class \code{character}
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
      wsXML <- content(req)
      wsList <- xml_find_all(wsxml, "//workspace")
      return(wsList)
    },
    
    getWorkspaceNames = function(){
      wsList <- sapply(self$getWorkspaces(), function(x){trimws(xml_text(x))})
      return(wsList)
    },
    
    getWorkspace = function(name){
      req <- self$GET(sprintf("/workspaces/%s.xml", name))
      return(req)
    },
    
    createWorkspace = function(name){
      stop("Unsupported 'createWorkspace' method")
    },
    
    deleteWorkspace = function(name){
      stop("Unsupported 'createWorkspace' method")
    }
    
    
  )
  
)