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
#' \dontrun{
#'    GSNamespaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
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
#'  \item{\code{getNamespaces()}}{
#'    Get the list of available namespace. Returns an object of class \code{list}
#'    containing items of class \code{\link{GSNamespace}}
#'  }
#'  \item{\code{getNamespaceNames()}}{
#'    Get the list of available namespace names. Returns an vector of class 
#'    \code{character}
#'  }
#'  \item{\code{getNamespace(ns)}}{
#'    Get a \code{\link{GSNamespace}} object given a namespace name.
#'  }
#'  \item{\code{createNamespace(prefix, uri)}}{
#'    Creates a GeoServer namespace given a prefix, and an optional URI. Returns
#'    \code{TRUE} if the namespace has been successfully created, \code{FALSE}
#'    otherwise
#'  }
#'  \item{\code{updateNamespace(ns, uri)}}{
#'    Updates a GeoServer namespace given a name, and an optional URI. Returns
#'    \code{TRUE} if the namespace has been successfully updated, \code{FALSE}
#'    otherwise
#'  }
#'  \item{\code{deleteNamespace(ns)}}{
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
    
    #getNamespaces
    #---------------------------------------------------------------------------
    getNamespaces = function(){
      self$INFO("Fetching list of namespaces")
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd,
                         "/namespaces.xml", self$verbose.debug)
      nsList <- NULL
      if(status_code(req) == 200){
        nsXML <- GSUtils$parseResponseXML(req)
        nsXMLList <- getNodeSet(nsXML, "//namespace")
        nsList <- lapply(nsXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSNamespace$new(xml = xml))
        })
        self$INFO(sprintf("Successfully fetched %s namespaces", length(nsList)))
      }else{
        self$ERROR("Error while fetching list of namespaces")
      }
      return(nsList)
    },
    
    #getNamespaceNames
    #---------------------------------------------------------------------------
    getNamespaceNames = function(){
      nsList <- sapply(self$getNamespaces(), function(x){x$name})
      return(nsList)
    },
    
    #getNamespace
    #---------------------------------------------------------------------------
    getNamespace = function(ns){
      self$INFO(sprintf("Fetching workspace '%s'", ns))
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd,
                         sprintf("/namespaces/%s.xml", ns), self$verbose.debug)
      namespace <- NULL
      if(status_code(req) == 200){
        nsXML <- GSUtils$parseResponseXML(req)
        namespace <- GSNamespace$new(xml = nsXML)
        self$INFO("Successfully fetched namespace!")
      }else{
        self$ERROR("Error while fetching namespace")
      }
      return(namespace)
    },
    
    #createNamespace
    #---------------------------------------------------------------------------
    createNamespace = function(prefix, uri){
      
      self$INFO(sprintf("Creating namespace '%s'", prefix))
      created <- FALSE
      namespace <- GSNamespace$new(prefix = prefix, uri = uri)

      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$pwd,
        path = "/namespaces",
        content = GSUtils$getPayloadXML(namespace),
        contentType = "text/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        self$INFO("Successfully created namespace!")
        created = TRUE
      }else{
        self$ERROR("Error while creating namespace")
      }
      return(created)
    },
    
    #updateNamespace
    #---------------------------------------------------------------------------
    updateNamespace = function(prefix, uri){
      
      self$INFO(sprintf("Updating namespace '%s'", prefix))
      updated <- FALSE
      namespace <- GSNamespace$new(prefix = prefix, uri = uri)
      
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
        path = sprintf("/namespaces/%s.xml", prefix),
        content = GSUtils$getPayloadXML(namespace),
        contentType = "application/xml",
        self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully updated namespace!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating namespace")
      }
      return(updated)
    },
    
    #deleteNamespace
    #---------------------------------------------------------------------------
    deleteNamespace = function(name, recurse = FALSE){
      self$INFO(sprintf("Deleting namespace '%s'", name))
      deleted <- FALSE
      path <- sprintf("/namespaces/%s", name)
      if(recurse) path <- paste0(path, "?recurse=true")
      #TODO hack for style removing (not managed by REST API)
      
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
                            path = path, self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully deleted namespace!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting namespace")
      }
      return(deleted)
    }   
    
  )
  
)