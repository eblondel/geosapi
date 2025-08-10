#' Geoserver REST API Service Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api service
#' @return Object of \code{\link[R6]{R6Class}} with methods for managing GeoServer services
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSServiceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'  }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSServiceManager <- R6Class("GSServiceManager",
  inherit = GSManager,
  
  public = list(   
    
    #Settings generic CRUD methods
    #===========================================================================
    #'@description Get the service settings. To get the service settings for a specific workspace,
    #'    specify the workspace name as \code{ws} parameter, otherwise global settings are
    #'    retrieved.
    #'@param service service
    #'@param ws workspace name
    #'@return an object of class \link{GSServiceSettings}
    getServiceSettings = function(service, ws = NULL){
      if(self$version$lowerThan("2.12")){
        err = "This feature is available starting from GeoServer 2.12"
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      restPath <- NULL
      service <- tolower(service)
      if(!is.null(ws)){
        self$INFO(sprintf("Fetching %s service settings in workspace '%s'", service, ws))
        restPath <- sprintf("/services/%s/workspaces/%s/settings.xml", service, ws)
      }else{
        self$INFO(sprintf("Fetching %s service global settings", service))
        restPath <- sprintf("/services/%s/settings.xml", service)
      }
      req <- GSUtils$GET(self$getUrl(), private$user,
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         restPath, verbose = self$verbose.debug)
      serviceSettings <- NULL
      if(status_code(req) == 200){
        settingsXML <- GSUtils$parseResponseXML(req)
        serviceSettings <- GSServiceSettings$new(xml = settingsXML, service = tolower(xml2::xml_name(xml2::as_xml_document(settingsXML))))
        msg = "Successfully fetched service settings!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching service settings"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(serviceSettings)
    },
    
    #'@description Get WMS settings. To get the WMS settings for a specific workspace,
    #'    specify the workspace name as \code{ws} parameter, otherwise global settings are
    #'    retrieved.
    #'@param ws workspace name
    #'@return an object of class \link{GSServiceSettings}
    getWmsSettings = function(ws = NULL){
      return(self$getServiceSettings(service = "WMS", ws = ws))
    },
    
    #'@description Get WFS settings. To get the WFS settings for a specific workspace,
    #'    specify the workspace name as \code{ws} parameter, otherwise global settings are
    #'    retrieved.
    #'@param ws workspace name
    #'@return an object of class \link{GSServiceSettings}
    getWfsSettings = function(ws = NULL){
      return(self$getServiceSettings(service = "WFS", ws = ws))
    },
    
    #'@description Get WCS settings. To get the WCS settings for a specific workspace,
    #'    specify the workspace name as \code{ws} parameter, otherwise global settings are
    #'    retrieved.
    #'@param ws workspace name
    #'@return an object of class \link{GSServiceSettings}
    getWcsSettings = function(ws = NULL){
      return(self$getServiceSettings(service = "WCS", ws = ws))
    },
    
    #'@description Updates the service settings with an object of class \code{GSServiceSettings}.
    #'    An optional workspace name \code{ws} can be specified to update service settings
    #'    applying to a workspace.
    #'@param serviceSettings serviceSettings object of class \link{GSServiceSettings}
    #'@param service service
    #'@param ws workspace name
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateServiceSettings = function(serviceSettings, service, ws = NULL){
      if(self$version$lowerThan("2.12")){
        err = "This feature is available starting from GeoServer 2.12"
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      updated <- FALSE
      restPath <- NULL
      service <- tolower(service)
      if(!is.null(ws)){
        self$INFO(sprintf("Fetching %s service settings in workspace '%s'", service, ws))
        restPath <- sprintf("/services/%s/workspaces/%s/settings.xml", service, ws)
      }else{
        self$INFO(sprintf("Fetching %s service global settings", service))
        restPath <- sprintf("/services/%s/settings.xml", service)
      }
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, 
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = restPath,
        content = GSUtils$getPayloadXML(serviceSettings),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfully updated service settings!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating service settings"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(updated)
    },
    
    #'@description Deletes the service settings. This method is used internally by \pkg{geosapi} 
    #'    for disabling a service setting at workspace level.
    #'@param service service
    #'@param ws workspace name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteServiceSettings = function(service, ws = NULL){
      if(self$version$lowerThan("2.12")){
        err = "This feature is available starting from GeoServer 2.12"
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      deleted <- FALSE
      restPath <- NULL
      service <- tolower(service)
      if(!is.null(ws)){
        self$INFO(sprintf("Deleting %s service settings in workspace '%s'", service, ws))
        restPath <- sprintf("/services/%s/workspaces/%s/settings.xml", service, ws)
      }else{
        #normally this delete operation is not available
        self$INFO(sprintf("Deleting %s service global settings", service))
        restPath <- sprintf("/services/%s/settings.xml", service)
      }
      req <- GSUtils$DELETE(
        url = self$getUrl(), user = private$user, 
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = restPath, verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfully deleted service settings!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleted service settings"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)
    },
    
    #'@description Updates the WMS settings with an object of class \code{GSServiceSettings}.
    #'    An optional workspace name \code{ws} can be specified to update WMS settings
    #'    applying to a workspace.
    #'@param serviceSettings service settings object of class \link{GSServiceSettings}
    #'@param ws workspace name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    updateWmsSettings = function(serviceSettings, ws = NULL){
      return(self$updateServiceSettings(serviceSettings, service = "WMS", ws = ws))
    },
    
    #'@description Updates the WFS settings with an object of class \code{GSServiceSettings}.
    #'    An optional workspace name \code{ws} can be specified to update WFS settings
    #'    applying to a workspace.
    #'@param serviceSettings service settings object of class \link{GSServiceSettings}
    #'@param ws workspace name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    updateWfsSettings = function(serviceSettings, ws = NULL){
      return(self$updateServiceSettings(serviceSettings, service = "WFS", ws = ws))
    },
    
    #'@description Updates the WCS settings with an object of class \code{GSServiceSettings}.
    #'    An optional workspace name \code{ws} can be specified to update WCS settings
    #'    applying to a workspace.
    #'@param serviceSettings service settings object of class \link{GSServiceSettings}
    #'@param ws workspace name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    updateWcsSettings = function(serviceSettings, ws = NULL){
      return(self$updateServiceSettings(serviceSettings, service = "WCS", ws = ws))
    },
    
    #'@description Enables WMS service settings
    #'@param ws workspace name
    #'@return \code{TRUE} if enabled, \code{FALSE} otherwise
    enableWMS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WMS")
      return(self$updateWmsSettings(serviceSettings, ws = ws))
    },
    
    #'@description Enables WFS service settings
    #'@param ws workspace name
    #'@return \code{TRUE} if enabled, \code{FALSE} otherwise
    enableWFS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WFS")
      return(self$updateWfsSettings(serviceSettings, ws = ws))
    },
    
    #'@description Enables WCS service settings
    #'@param ws workspace name
    #'@return \code{TRUE} if enabled, \code{FALSE} otherwise
    enableWCS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WCS")
      return(self$updateWcsSettings(serviceSettings, ws = ws))
    },
    
    #'@description Disables service settings
    #'@param service service
    #'@param ws workspace name
    #'@return \code{TRUE} if disabled, \code{FALSE} otherwise
    disableServiceSettings = function(service, ws = NULL){
      disabled <- FALSE
      if(is.null(ws)){
        #use update op for global service setting
        serviceSettings <- GSServiceSettings$new(service = service)
        serviceSettings$setEnabled(FALSE)
        disabled <- self$updateWmsSettings(serviceSettings, ws = ws)
      }else{
        #use delete op for workspace service setting
        disabled <- self$deleteServiceSettings(service = service, ws = ws)
      }
      return(disabled)
    },
    
    #'@description Disables WMS service settings
    #'@param ws workspace name
    #'@return \code{TRUE} if disabled, \code{FALSE} otherwise
    disableWMS = function(ws = NULL){
      return(self$disableServiceSettings(service = "WMS", ws = ws))
    },
    
    #'@description Disables WFS service settings
    #'@param ws workspace name
    #'@return \code{TRUE} if disabled, \code{FALSE} otherwise
    disableWFS = function(ws = NULL){
      return(self$disableServiceSettings(service = "WFS", ws = ws))
    },
    
    #'@description Disables WCS service settings
    #'@param ws workspace name
    #'@return \code{TRUE} if disabled, \code{FALSE} otherwise
    disableWCS = function(ws = NULL){
      return(self$disableServiceSettings(service = "WCS", ws = ws))
    }
    
  )
)
