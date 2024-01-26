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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSNamespaceManager <- R6Class("GSNamespaceManager",
  inherit = GSManager,
  
  public = list(
    
    #'@description Get the list of available namespace. Re
    #'@return an object of class \code{list} containing items of class \code{\link{GSNamespace}}
    getNamespaces = function(){
      self$INFO("Fetching list of namespaces")
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         "/namespaces.xml", self$verbose.debug)
      nsList <- NULL
      if(status_code(req) == 200){
        nsXML <- GSUtils$parseResponseXML(req)
        nsXMLList <- as(xml2::xml_find_all(nsXML, "//namespace"), "list")
        nsList <- lapply(wsXMLList, GSNamespace$new)
        self$INFO(sprintf("Successfully fetched %s namespaces", length(nsList)))
      }else{
        self$ERROR("Error while fetching list of namespaces")
      }
      return(nsList)
    },
    
    #'@description Get the list of available namespace names.
    #'@return a vector of class \code{character}
    getNamespaceNames = function(){
      nsList <- sapply(self$getNamespaces(), function(x){x$name})
      return(nsList)
    },
    
    #'@description Get a \code{\link{GSNamespace}} object given a namespace name.
    #'@param ns namespace
    #'@return an object of class \link{GSNamespace}
    getNamespace = function(ns){
      self$INFO(sprintf("Fetching workspace '%s'", ns))
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
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
    
    #'@description  Creates a GeoServer namespace given a prefix, and an optional URI. 
    #'@param prefix prefix
    #'@param uri uri
    #'@return \code{TRUE} if the namespace has been successfully created, \code{FALSE} otherwise
    createNamespace = function(prefix, uri){
      
      self$INFO(sprintf("Creating namespace '%s'", prefix))
      created <- FALSE
      namespace <- GSNamespace$new(prefix = prefix, uri = uri)

      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
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
    
    #'@description  Updates a GeoServer namespace given a prefix, and an optional URI. 
    #'@param prefix prefix
    #'@param uri uri
    #'@return \code{TRUE} if the namespace has been successfully updated, \code{FALSE} otherwise
    updateNamespace = function(prefix, uri){
      
      self$INFO(sprintf("Updating namespace '%s'", prefix))
      updated <- FALSE
      namespace <- GSNamespace$new(prefix = prefix, uri = uri)
      
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
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
    
    #'@description Deletes a GeoServer namespace given a name. 
    #'@param name name
    #'@param recurse recurse
    #'@return \code{TRUE} if the namespace has been successfully deleted, \code{FALSE} otherwise
    deleteNamespace = function(name, recurse = FALSE){
      self$INFO(sprintf("Deleting namespace '%s'", name))
      deleted <- FALSE
      path <- sprintf("/namespaces/%s", name)
      if(recurse) path <- paste0(path, "?recurse=true")
      #TODO hack for style removing (not managed by REST API)
      
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
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