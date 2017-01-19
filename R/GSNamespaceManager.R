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
#' \donttest{
#'    GSNamespaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, user, pwd)}}{
#'    This method is used to instantiate a GSNamespaceManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd})
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
      nsList <- NULL
      if(status_code(req) == 200){
        nsXML <- GSUtils$parseResponseXML(req)
        nsXMLList <- getNodeSet(nsXML, "//namespace")
        nsList <- lapply(nsXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSNamespace$new(xml = xml))
        })
      }
      return(nsList)
    },
    
    getNamespaceNames = function(){
      nsList <- sapply(self$getNamespaces(), function(x){x$name})
      return(nsList)
    },
    
    getNamespace = function(prefix){
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd,
                         sprintf("/namespaces/%s.xml", prefix), self$verbose)
      ns <- NULL
      if(status_code(req) == 200){
        nsXML <- GSUtils$parseResponseXML(req)
        ns <- GSNamespace$new(xml = nsXML)
      }
      return(ns)
    },
    
    createNamespace = function(prefix, uri){
      created <- FALSE
      
      ns <- GSNamespace$new(prefix = prefix, uri = uri)

      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$pwd,
        path = "/namespaces",
        content = GSUtils$getPayloadXML(ns),
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