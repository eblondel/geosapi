#' Geoserver REST API Namespace Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api namespace
#' @return Object of \code{\link{R6Class}} with methods for managing the namespaces
#'  of a GeoServer instance.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSNamespaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(}}{
#'    This method is used to instantiate a GSNamespaceManager
#'  }
#'  \item{\code{getNamespaces()}}{
#'    Get the list of available namespace. Returns an object of class \code{list}
#'    containing items of class \code{\link{GSNamespace}}
#'  }
#'  \item{\code{getNamespaceNames()}}{
#'    Get the list of available namespace names. Returns an vector of class 
#'    \code{character}
#'  }
#'  \item{\code{getNamespace(name)}}{
#'    Get a \code{\link{GSNamespace}} object given a namespace name.
#'  }
#'  \item{\code{createNamespace(name, uri)}}{
#'    Creates a GeoServer namespace given a name, and an optional URI. Returns
#'    \code{TRUE} if the namespace has been successfully created, \code{FALSE}
#'    otherwise
#'  }
#'  \item{\code{deleteNamespace(name)}}{
#'    Deletes a GeoServer namespace given a name. Returns \code{TRUE} if the 
#'    namespace has been successfully deleted, \code{FALSE} otherwise
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSNamespaceManager <- R6Class("GSNamespaceManager",
  inherit = GSManager,
  
  public = list(
    
    getNamespaces = function(){
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd,
                         "/namespaces.xml", self$verbose)
      wsXml <- content(req)
      wsXmlList <- xml_find_all(wsXml, "//namespace")
      wsList <- lapply(as_list(wsXmlList), function(x){
        xml <- xml_add_child(xml_new_document(), x)
        return(GSNamespace$new(xml))
      })
      return(wsList)
    },
    
    getNamespaceNames = function(){
      wsList <- sapply(self$getNamespaces(), function(x){x$name})
      return(wsList)
    },
    
    getNamespace = function(prefix){
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd,
                         sprintf("/namespaces/%s.xml", prefix), self$verbose)
      ws <- NULL
      if(status_code(req) == 200){
        wsXML <- content(req)
        ws <- GSNamespace$new(wsXML)
      }
      return(ws)
    },
    
    createNamespace = function(prefix, uri){
      created <- FALSE
      xml <- sprintf("<namespace><prefix>%s</prefix><uri>%s</uri></namespace>",
                     prefix, uri)
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$pwd,
        path = "/namespaces",
        content = xml,
        contentType = "text/xml",
        verbose = self$verbose
      )
      if(status_code(req) == 201){
        created = TRUE
      }
      return(created)
    },
    
    deleteNamespace = function(name, recurse = FALSE){
      deleted <- FALSE
      path <- sprintf("/namespaces/%s", name)
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