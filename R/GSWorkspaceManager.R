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
      msg = "Fetching list of workspaces"
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         "/workspaces.xml", self$verbose.debug)
      wsList <- NULL
      if(status_code(req) == 200){
        wsXML <- GSUtils$parseResponseXML(req)
        wsXMLList <- as(xml2::xml_find_all(wsXML, "//workspace"), "list")
        wsList <- lapply(wsXMLList, GSWorkspace$new)
        msg = sprintf("Successfully fetched %s workspaces", length(wsList))
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching list of workspaces"
        cli::cli_alert_danger(err)
        self$ERROR(err)
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
      msg = sprintf("Fetching workspace '%s'", ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                      sprintf("/workspaces/%s.xml", ws), self$verbose.debug)
      workspace <- NULL
      if(status_code(req) == 200){
        wsXML <- GSUtils$parseResponseXML(req)
        workspace <- GSWorkspace$new(xml = wsXML)
        msg = "Successfully fetched workspace!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching workspace"
        cli::cli_alert_danger(err)
        self$ERROR(err)
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
      msg = sprintf("Creating workspace '%s'", name)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
          msg = "Successfully created workspace!"
          cli::cli_alert_info(msg)
          self$INFO(msg)
          created = TRUE
        }else{
          err = "Error while creating workspace"
          cli::cli_alert_danger(err)
          self$ERROR(err)
        }
      }else{
        msg = "Delegating workspace creation to namespace manager"
        cli::cli_alert_info(msg)
        self$INFO(msg)
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
      msg = sprintf("Updating workspace '%s'", name)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
          msg = "Successfully updated workspace!"
          cli::cli_alert_success(msg)
          self$INFO(msg)
          updated = TRUE
        }else{
          err = "Error while updating workspace"
          cli::cli_alert_danger(err)
          self$ERROR(err)
        }
      }else{
        msg = "Delegating workspace update to namespace manager"
        cli::cli_alert_info(msg)
        self$INFO(msg)
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
      msg = sprintf("Deleting workspace '%s'", name)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      deleted <- FALSE
      path <- sprintf("/workspaces/%s", name)
      if(recurse) path <- paste0(path, "?recurse=true")
      #TODO hack for style removing (not managed by REST API)
      
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         path = path, self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfully deleted workspace!"
        cli::cli_alert_info(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting workspace"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)
    },
    
    #'@description Updates workspace settings
    #'@param ws workspace name
    #'@return an object of class \link{GSWorkspaceSettings}
    getWorkspaceSettings = function(ws){
      if(self$version$lowerThan("2.12")){
        err = "This feature is available starting from GeoServer 2.12"
        cli::cli_alert_danger(err)
        stop(err)
      }
      msg = sprintf("Fetching settings for workspace '%s'", ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         sprintf("/workspaces/%s/settings.xml", ws), self$verbose.debug)
      workspaceSettings <- NULL
      if(status_code(req) == 200){
        wsSettingXML <- GSUtils$parseResponseXML(req)
        workspaceSettings <- GSWorkspaceSettings$new(xml = wsSettingXML)
        msg = "Successfully fetched workspace settings!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching workspace settings"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(workspaceSettings)
    },
    
    #'@description Creates workspace settings
    #'@param ws workspace name
    #'@param workspaceSettings object of class \link{GSWorkspaceSettings}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createWorkspaceSettings = function(ws, workspaceSettings){
      if(self$version$lowerThan("2.12")){
        err = "This feature is available starting from GeoServer 2.12"
        cli::cli_alert_danger(err)
        stop(err)
      }
      msg = sprintf("Creating settings for workspace '%s'", ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
        msg = "Successfully created workspace settings!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while creating workspace settings"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(created)
    },
    
    #'@description Updates workspace settings
    #'@param ws workspace name
    #'@param workspaceSettings object of class \link{GSWorkspaceSettings}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateWorkspaceSettings = function(ws, workspaceSettings){
      if(self$version$lowerThan("2.12")){
        err = "This feature is available starting from GeoServer 2.12"
        cli::cli_alert_danger(err)
        stop(err)
      }
      msg = sprintf("Updating settings for workspace '%s'", ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
        msg = "Successfully updated workspace settings!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating workspace settings"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(updated)
    },
    
    #'@description Deletes workspace settings
    #'@param ws workspace name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteWorkspaceSettings = function(ws){
      if(self$version$lowerThan("2.12")){
        err = "This feature is available starting from GeoServer 2.12"
        cli::cli_alert_danger(err)
        stop(err)
      }
      msg = sprintf("Deleting settings for workspace '%s'", ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/settings", ws)
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfully deleted workspace settings!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting workspace settings"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)
    }
    
  )
  
)