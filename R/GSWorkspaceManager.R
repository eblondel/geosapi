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
#' \dontrun{
#'    GSWorkspaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorkspaceManager <- R6Class("GSWorkspaceManager",
  inherit = GSManager,

  public = list(
    
    #'@description Get the list of available workspace. Returns an object of class \code{list}
    #'    containing items of class \code{\link{GSWorkspace}}
    #'@param a list of \link{GSWorkspace}
    getWorkspaces = function(){
      self$INFO("Fetching list of workspaces")
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         "/workspaces.xml", self$verbose.debug)
      wsList <- NULL
      if(status_code(req) == 200){
        wsXML <- GSUtils$parseResponseXML(req)
        wsXMLList <- getNodeSet(wsXML, "//workspace")
        wsList <- lapply(wsXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSWorkspace$new(xml = xml))
        })
        self$INFO(sprintf("Successfully fetched %s workspaces", length(wsList)))
      }else{
        self$ERROR("Error while fetching list of workspaces")
      }
      return(wsList)
    },
    
    #'@description Get the list of available workspace names. Returns an vector of class \code{character}
    #'@return a list of workspace names
    getWorkspaceNames = function(){
      wsList <- sapply(self$getWorkspaces(), function(x){x$name})
      return(wsList)
    },
    
    #'@description Get a \code{\link{GSWorkspace}} object given a workspace name.
    #'@param ws workspace name
    #'@return an object of class \link{GSWorkspace}
    getWorkspace = function(ws){
      self$INFO(sprintf("Fetching workspace '%s'", ws))
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                      sprintf("/workspaces/%s.xml", ws), self$verbose.debug)
      workspace <- NULL
      if(status_code(req) == 200){
        wsXML <- GSUtils$parseResponseXML(req)
        workspace <- GSWorkspace$new(xml = wsXML)
        self$INFO("Successfully fetched workspace!")
      }else{
        self$ERROR("Error while fetching workspace")
      }
      return(workspace)
    },
    
    #'@description Creates a GeoServer workspace given a name, and an optional URI. If the URI
    #'    is not specified, GeoServer will automatically create an associated Namespace 
    #'    with the URI being "http://{workspaceName}. If the URI is specified, the method
    #'    invokes the method \code{createNamespace(ns, uri)} of the \code{\link{GSNamespaceManager}}.
    #'    Returns \code{TRUE} if the workspace has been successfully created, \code{FALSE} otherwise
    #'@param name name
    #'@param uri uri
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createWorkspace = function(name, uri){
      self$INFO(sprintf("Creating workspace '%s'", name))
      created <- FALSE
      if(missing(uri)){
        
        ws <- GSWorkspace$new(name = name)
        
        req <- GSUtils$POST(
          url = self$getUrl(),
          user = private$user,
          pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
          path = "/workspaces",
          content = GSUtils$getPayloadXML(ws),
          contentType = "text/xml",
          verbose = self$verbose.debug
        )
        if(status_code(req) == 201){
          self$INFO("Successfully created workspace!")
          created = TRUE
        }else{
          self$ERROR("Error while creating workspace")
        }
      }else{
        self$INFO("Delegating workspace creation to namespace manager")
        nsman <- GSNamespaceManager$new(self$getUrl(), private$user,
                                        private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                        self$loggerType)
        created <- nsman$createNamespace(name, uri)
      }
      return(created)
    },
    
    #'@description Updates a GeoServer workspace given a name, and an optional URI. If the URI
    #'    is not specified, GeoServer will automatically update the associated Namespace 
    #'    with the URI being "http://{workspaceName}. If the URI is specified, the method
    #'    invokes the method \code{updateNamespace(ns, uri)} of the \code{\link{GSNamespaceManager}}.
    #'    Returns \code{TRUE} if the workspace has been successfully updated, \code{FALSE} otherwise
    #'@param name name
    #'@param uri uri
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    updateWorkspace = function(name, uri){
      self$INFO(sprintf("Updating workspace '%s'", name))
      updated <- FALSE
      if(missing(uri)){
        workspace <- GSWorkspace$new(name = name)
        req <- GSUtils$PUT(
          url = self$getUrl(), user = private$user,
          pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
          path = sprintf("/workspaces/%s.xml", name),
          content = GSUtils$getPayloadXML(workspace),
          contentType = "application/xml",
          verbose = self$verbose.debug
        )
        if(status_code(req) == 200){
          self$INFO("Successfully updated workspace!")
          updated = TRUE
        }else{
          self$ERROR("Error while updating workspace")
        }
      }else{
        self$INFO("Delegating workspace update to namespace manager")
        nsman <- GSNamespaceManager$new(self$getUrl(), private$user, 
                                        private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                        self$loggerType)
        updated <- nsman$updateNamespace(name, uri)
      }
      return(updated)
    },
    
    #'@description Deletes a GeoServer workspace given a name. 
    #'@param name name
    #'@param recurse recurse
    #'@return \code{TRUE} if the workspace has been successfully deleted, \code{FALSE} otherwise
    deleteWorkspace = function(name, recurse = FALSE){
      self$INFO(sprintf("Deleting workspace '%s'", name))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s", name)
      if(recurse) path <- paste0(path, "?recurse=true")
      #TODO hack for style removing (not managed by REST API)
      
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         path = path, self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully deleted workspace!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting workspace")
      }
      return(deleted)
    },
    
    #'@description Updates workspace settings
    #'@param ws workspace name
    #'@return an object of class \link{GSWorkspaceSettings}
    getWorkspaceSettings = function(ws){
      if(self$version$lowerThan("2.12")){
        stop("This feature is available starting from GeoServer 2.12")
      }
      self$INFO(sprintf("Fetching settings for workspace '%s'", ws))
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         sprintf("/workspaces/%s/settings.xml", ws), self$verbose.debug)
      workspaceSettings <- NULL
      if(status_code(req) == 200){
        wsSettingXML <- GSUtils$parseResponseXML(req)
        workspaceSettings <- GSWorkspaceSettings$new(xml = wsSettingXML)
        self$INFO("Successfully fetched workspace settings!")
      }else{
        self$ERROR("Error while fetching workspace settings")
      }
      return(workspaceSettings)
    },
    
    #'@description Creates workspace settings
    #'@param ws workspace name
    #'@param workspaceSettings object of class \link{GSWorkspaceSettings}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createWorkspaceSettings = function(ws, workspaceSettings){
      if(self$version$lowerThan("2.12")){
        stop("This feature is available starting from GeoServer 2.12")
      }
      self$INFO(sprintf("Creating settings for workspace '%s'", ws))
      created <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(),
        user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/settings.xml", ws),
        content = GSUtils$getPayloadXML(workspaceSettings),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully created workspace settings!")
        created = TRUE
      }else{
        self$ERROR("Error while creating workspace settings")
      }
      return(created)
    },
    
    #'@description Updates workspace settings
    #'@param ws workspace name
    #'@param workspaceSettings object of class \link{GSWorkspaceSettings}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateWorkspaceSettings = function(ws, workspaceSettings){
      if(self$version$lowerThan("2.12")){
        stop("This feature is available starting from GeoServer 2.12")
      }
      self$INFO(sprintf("Updating settings for workspace '%s'", ws))
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/settings.xml", ws),
        content = GSUtils$getPayloadXML(workspaceSettings),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully updated workspace settings!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating workspace settings")
      }
      return(updated)
    },
    
    #'@description Deletes workspace settings
    #'@param ws workspace name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteWorkspaceSettings = function(ws){
      if(self$version$lowerThan("2.12")){
        stop("This feature is available starting from GeoServer 2.12")
      }
      self$INFO(sprintf("Deleting settings for workspace '%s'", ws))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/settings", ws)
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully deleted workspace settings!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting workspace settings")
      }
      return(deleted)
    }
    
  )
  
)