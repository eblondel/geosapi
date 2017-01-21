#' Geoserver REST API Workspace Manager
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
#' \donttest{
#'    GSWorkspaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, user, pwd)}}{
#'    This method is used to instantiate a GSWorkspaceManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd})
#'  }
#'  \item{\code{getWorkspaces()}}{
#'    Get the list of available workspace. Returns an object of class \code{list}
#'    containing items of class \code{\link{GSWorkspace}}
#'  }
#'  \item{\code{getWorkspaceNames()}}{
#'    Get the list of available workspace names. Returns an vector of class 
#'    \code{character}
#'  }
#'  \item{\code{getWorkspace(ws)}}{
#'    Get a \code{\link{GSWorkspace}} object given a workspace name.
#'  }
#'  \item{\code{createWorkspace(name, uri)}}{
#'    Creates a GeoServer workspace given a name, and an optional URI. If the URI
#'    is not specified, GeoServer will automatically create an associated Namespace 
#'    with the URI being "http://{workspaceName}. If the URI is specified, the method
#'    invokes the method \code{createNamespace(ns, uri)} of the \code{\link{GSNamespaceManager}}.
#'    Returns \code{TRUE} if the workspace has been successfully created, \code{FALSE} otherwise
#'  }
#'  \item{\code{updateWorkspace(name, uri)}}{
#'    Updates a GeoServer workspace given a name, and an optional URI. If the URI
#'    is not specified, GeoServer will automatically update the associated Namespace 
#'    with the URI being "http://{workspaceName}. If the URI is specified, the method
#'    invokes the method \code{updateNamespace(ns, uri)} of the \code{\link{GSNamespaceManager}}.
#'    Returns \code{TRUE} if the workspace has been successfully updated, \code{FALSE} otherwise
#'  }
#'  \item{\code{deleteWorkspace(ws)}}{
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
    
    #getWorkspaces
    #---------------------------------------------------------------------------
    getWorkspaces = function(){
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd,
                         "/workspaces.xml", self$verbose)
      wsList <- NULL
      if(status_code(req) == 200){
        wsXML <- GSUtils$parseResponseXML(req)
        wsXMLList <- getNodeSet(wsXML, "//workspace")
        wsList <- lapply(wsXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSWorkspace$new(xml = xml))
        })
      }
      return(wsList)
    },
    
    #getWorkspaceNames
    #---------------------------------------------------------------------------
    getWorkspaceNames = function(){
      wsList <- sapply(self$getWorkspaces(), function(x){x$name})
      return(wsList)
    },
    
    #getWorkspace
    #---------------------------------------------------------------------------
    getWorkspace = function(ws){
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd,
                      sprintf("/workspaces/%s.xml", ws), self$verbose)
      workspace <- NULL
      if(status_code(req) == 200){
        wsXML <- GSUtils$parseResponseXML(req)
        workspace <- GSWorkspace$new(xml = wsXML)
      }
      return(workspace)
    },
    
    #createWorkspace
    #---------------------------------------------------------------------------
    createWorkspace = function(name, uri){
      created <- FALSE
      if(missing(uri)){
        
        ws <- GSWorkspace$new(name = name)
        
        req <- GSUtils$POST(
          url = self$getUrl(),
          user = private$user,
          pwd = private$pwd,
          path = "/workspaces",
          content = GSUtils$getPayloadXML(ws),
          contentType = "text/xml",
          verbose = self$verbose
        )
        if(status_code(req) == 201){
          created = TRUE
        }
      }else{
        nsman <- GSNamespaceManager$new(self$getUrl(), private$user, private$pwd)
        created <- nsman$createNamespace(name, uri)
      }
      return(created)
    },
    
    #updateWorkspace
    #---------------------------------------------------------------------------
    updateWorkspace = function(name, uri){
      
      updated <- FALSE
      if(missing(uri)){
        workspace <- GSWorkspace$new(name = name)
        req <- GSUtils$PUT(
          url = self$getUrl(), user = private$user, pwd = private$pwd,
          path = sprintf("/workspaces/%s.xml", name),
          content = GSUtils$getPayloadXML(workspace),
          contentType = "application/xml",
          self$verbose
        )
        if(status_code(req) == 200){
          udpated = TRUE
        }
      }else{
        nsman <- GSNamespaceManager$new(self$getUrl(), private$user, private$pwd)
        updated <- nsman$updateNamespace(name, uri)
      }
      return(updated)
    },
    
    #deleteWorkspace
    #---------------------------------------------------------------------------
    deleteWorkspace = function(name, recurse = FALSE){
      deleted <- FALSE
      path <- sprintf("/workspaces/%s", name)
      if(recurse) path <- paste0(path, "?recurse=true")
      #TODO hack for style removing (not managed by REST API)
      
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
                         path = path, self$verbose)
      if(status_code(req) == 200){
        deleted = TRUE
      }
      return(deleted)
    }   
    
  )
  
)