#' Geoserver REST API Service Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api service
#' @return Object of \code{\link{R6Class}} with methods for managing GeoServer services
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSServiceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'  }
#'
#' @section Constructor:
#' \describe{
#'  \item{\code{new(url, user, pwd, logger)}}{
#'    This method is used to instantiate a GSManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd}). By default,
#'    the \code{logger} argument will be set to \code{NULL} (no logger). This argument
#'    accepts two possible values: \code{INFO}: to print only geosapi logs,
#'    \code{DEBUG}: to print geosapi and CURL logs
#'  }
#'  \item{\code{getServiceSettings(service, ws)}}{
#'    Get the service settings. To get the service settings for a specific workspace,
#'    specify the workspace name as \code{ws} parameter, otherwise global settings are
#'    retrieved.
#'  }
#'  \item{\code{getWmsSettings(ws)}}{
#'    Get WMS settings. To get the WMS settings for a specific workspace,
#'    specify the workspace name as \code{ws} parameter, otherwise global settings are
#'    retrieved.
#'  }
#'  \item{\code{getWfsSettings(ws)}}{
#'    Get WFS settings. To get the WFS settings for a specific workspace,
#'    specify the workspace name as \code{ws} parameter, otherwise global settings are
#'    retrieved.
#'  }
#'  \item{\code{getWcsSettings(ws)}}{
#'    Get WCS settings. To get the WCS settings for a specific workspace,
#'    specify the workspace name as \code{ws} parameter, otherwise global settings are
#'    retrieved.
#'  }
#'  \item{\code{updateServiceSettings(serviceSettings, service, ws)}}{
#'    Updates the service settings with an object of class \code{GSServiceSetting}.
#'    An optional workspace name \code{ws} can be specified to update service settings
#'    applying to a workspace.
#'  }
#'  \item{\code{updateWmsSettings(serviceSettings, ws)}}{
#'    Updates the WMS settings with an object of class \code{GSServiceSetting}.
#'    An optional workspace name \code{ws} can be specified to update WMS settings
#'    applying to a workspace.
#'  }
#'  \item{\code{updateWfsSettings(serviceSettings, ws)}}{
#'    Updates the WFS settings with an object of class \code{GSServiceSetting}.
#'    An optional workspace name \code{ws} can be specified to update WFS settings
#'    applying to a workspace.
#'  }
#'  \item{\code{updateWcsSettings(serviceSettings, ws)}}{
#'    Updates the WCS settings with an object of class \code{GSServiceSettings}.
#'    An optional workspace name \code{ws} can be specified to update WCS settings
#'    applying to a workspace.
#'  }
#'  \item{\code{enableWMS(ws)}}{
#'    Enables the WMS, either globally, or for a given workspace (optional)
#'  }
#'  \item{\code{enableWFS(ws)}}{
#'    Enables the WFS, either globally, or for a given workspace (optional)
#'  }
#'  \item{\code{enableWCS(ws)}}{
#'    Enables the WCS, either globally, or for a given workspace (optional)
#'  }
#'  \item{\code{disableWMS(ws)}}{
#'    Disables the WMS, either globally, or for a given workspace (optional)
#'  }
#'  \item{\code{disableWFS(ws)}}{
#'    Disables the WFS, either globally, or for a given workspace (optional)
#'  }
#'  \item{\code{disableWCS(ws)}}{
#'    Disables the WCS, either globally, or for a given workspace (optional)
#'  }
#' }
#' 
#' @section \code{Settings} methods:
#' \describe{ 
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSServiceManager <- R6Class("GSServiceManager",
  inherit = GSManager,
  
  public = list(   
    
    #Settings generic CRUD methods
    #===========================================================================
    #getServiceSettings
    #---------------------------------------------------------------------------
    getServiceSettings = function(service, ws = NULL){
      if(self$version$lowerThan("2.12")){
        stop("This feature is available starting from GeoServer 2.12")
      }
      restPath <- NULL
      service <- tolower(service)
      if(!is.null(ws)){
        ws <- tolower(ws)
        self$INFO(sprintf("Fetching %s service settings in workspace '%s'", service, ws))
        restPath <- sprintf("/services/%s/workspaces/%s/settings.xml", service, ws)
      }else{
        self$INFO(sprintf("Fetching %s service global settings", service))
        restPath <- sprintf("/services/%s/settings.xml", service)
      }
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd, restPath, verbose = self$verbose.debug)
      serviceSettings <- NULL
      if(status_code(req) == 200){
        settingsXML <- GSUtils$parseResponseXML(req)
        serviceSettings <- GSServiceSettings$new(xml = settingsXML, service = tolower(xmlName(xmlRoot(settingsXML))))
        self$INFO("Successfully fetched service settings!")
      }else{
        self$ERROR("Error while fetching service settings")
      }
      return(serviceSettings)
    },
    getWmsSettings = function(ws = NULL){
      return(self$getServiceSettings(service = "WMS", ws = ws))
    },
    getWfsSettings = function(ws = NULL){
      return(self$getServiceSettings(service = "WFS", ws = ws))
    },
    getWcsSettings = function(ws = NULL){
      return(self$getServiceSettings(service = "WCS", ws = ws))
    },
    
    #updatServiceSettings
    #---------------------------------------------------------------------------
    updateServiceSettings = function(serviceSettings, service, ws = NULL){
      if(self$version$lowerThan("2.12")){
        stop("This feature is available starting from GeoServer 2.12")
      }
      updated <- FALSE
      restPath <- NULL
      service <- tolower(service)
      if(!is.null(ws)){
        ws <- tolower(ws)
        self$INFO(sprintf("Fetching %s service settings in workspace '%s'", service, ws))
        restPath <- sprintf("/services/%s/workspaces/%s/settings.xml", service, ws)
      }else{
        self$INFO(sprintf("Fetching %s service global settings", service))
        restPath <- sprintf("/services/%s/settings.xml", service)
      }
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
        path = restPath,
        content = GSUtils$getPayloadXML(serviceSettings),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully updated service settings!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating service settings")
      }
      return(updated)
    },
    updateWmsSettings = function(serviceSettings, ws = NULL){
      return(self$updateServiceSettings(serviceSettings, service = "WMS", ws = ws))
    },
    updateWfsSettings = function(serviceSettings, ws = NULL){
      return(self$updateServiceSettings(serviceSettings, service = "WFS", ws = ws))
    },
    updateWcsSettings = function(serviceSettings, ws = NULL){
      return(self$updateServiceSettings(serviceSettings, service = "WCS", ws = ws))
    },
    enableWMS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WMS")
      return(self$updateWmsSettings(serviceSettings, ws = ws))
    },
    enableWFS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WFS")
      return(self$updateWfsSettings(serviceSettings, ws = ws))
    },
    enableWCS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WCS")
      return(self$updateWcsSettings(serviceSettings, ws = ws))
    },
    disableWMS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WMS")
      serviceSettings$setEnabled(FALSE)
      return(self$updateWmsSettings(serviceSettings, ws = ws))
    },
    disableWFS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WFS")
      serviceSettings$setEnabled(FALSE)
      return(self$updateWfsSettings(serviceSettings, ws = ws))
    },
    disableWCS = function(ws = NULL){
      serviceSettings <- GSServiceSettings$new(service = "WCS")
      serviceSettings$setEnabled(FALSE)
      return(self$updateWcsSettings(serviceSettings, ws = ws))
    }
    
  )
)
