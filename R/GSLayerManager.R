#' Geoserver REST API Layer Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api Layer
#' @return Object of \code{\link[R6]{R6Class}} with methods for managing GeoServer
#' Layers as results of published feature types or coverages
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSLayerManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'  }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSLayerManager <- R6Class("GSLayerManager",
  inherit = GSManager,
  
  public = list(
    
    #Layer CRUD methods
    #===========================================================================
    
    #'@description Get the list of layers.
    #'@return an object of class \code{list} giving items of class \code{\link{GSLayer}}
    getLayers = function(){
      msg = "Fetching layers"
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        "/layers.xml", verbose = self$verbose.debug)
      lyrList <- NULL
      if(status_code(req) == 200){
        lyrXML <- GSUtils$parseResponseXML(req)
        lyrXMLList <- as(xml2::xml_find_all(lyrXML, "//layers/layer"), "list")
        lyrList <- lapply(lyrXMLList, GSLayer$new)
        msg = sprintf("Successfuly fetched %s layers!", length(lyrList))
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching layers"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(lyrList)
    },
    
    #'@description Get the list of layer names.
    #'@return a vector of class \code{character}
    getLayerNames = function(){
      lyrList <- sapply(self$getLayers(), function(x){x$name})
      return(lyrList)
    },
    
    #'@description Get layer by name
    #'@param lyr layer name
    #'@return an object of class \link{GSLayer}
    getLayer = function(lyr){
      msg = sprintf("Fetching layer '%s'", lyr)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/layers/%s.xml", lyr),
        verbose = self$verbose.debug)
      layer <- NULL
      if(status_code(req) == 200){
        lyrXML <- GSUtils$parseResponseXML(req)
        layer <- GSLayer$new(xml = lyrXML)
        msg = "Successfuly fetched layer!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching layer"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(layer)
    },
    
    #'@description Creates a new layer given an object of class \code{\link{GSLayer}}
    #'@param  layer object of class \link{GSLayer}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createLayer = function(layer){
      msg = sprintf("Creating layer '%s'", layer$name)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      created <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/layers/%s.xml", layer$name),
        content = GSUtils$getPayloadXML(layer),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfuly created layer!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while creating layer"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(created)
    },
    
    #'@description Updates a layer given an object of class \code{\link{GSLayer}}
    #'@param  layer object of class \link{GSLayer}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateLayer = function(layer){
      msg = sprintf("Updating layer '%s'", layer$name)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/layers/%s.xml", layer$name),
        content = GSUtils$getPayloadXML(layer),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfuly updated layer!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating layer"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(updated)
    },
    
    #'@description Deletes layer given an object of class \code{\link{GSLayer}}
    #'@param  lyr layer name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteLayer = function(lyr){
      msg = sprintf("Deleting layer '%s'", lyr)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      deleted <- FALSE
      path <- sprintf("/layers/%s.xml", lyr)
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfuly deleted layer!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting layer"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)
    },
    
    #LayerGroup CRUD methods
    #===========================================================================
    
    #'@description Get layer groups
    #'@param ws workspace name. Optional
    #'@return a list of objects of class \link{GSLayerGroup}
    getLayerGroups = function(ws = NULL){
      if(missing(ws)){
        msg = "Fetching layer groups"
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }else{
        msg = sprintf("Fetching layer groups for workspace '%s'", ws)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        ifelse(missing(ws),"/layergroups.xml", sprintf("/workspaces/%s/layergroups.xml", ws)), 
        verbose = self$verbose.debug)
      lyrList <- NULL
      if(status_code(req) == 200){
        lyrXML <- GSUtils$parseResponseXML(req)
        lyrXMLList <- as(xml2::xml_find_all(lyrXML, "//layerGroups/layerGroup"), "list")
        lyrList <- lapply(lyrXMLList, GSLayerGroup$new)
        msg = sprintf("Successfuly fetched %s layer groups!", length(lyrList))
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching layer groups"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(lyrList)
    },
    
    #'@description Get layer group names
    #'@param ws workspace name
    #'@return a list of layer group names, as vector of class \code{character}
    getLayerGroupNames = function(ws = NULL){
      lyrList <- sapply(self$getLayerGroups(ws), function(x){x$name})
      return(lyrList)
    },
    
    #'@description Get layer group
    #'@param lyr lyr
    #'@param ws workspace name
    #'@return an object of class \link{GSLayerGroup}
    getLayerGroup = function(lyr, ws = NULL){
      if(is.null(ws)){
        msg = sprintf("Fetching layer group '%s'", lyr)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }else{
        msg = sprintf("Fetching layer group '%s' in workspace '%s'", lyr, ws)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        ifelse(is.null(ws),
               sprintf("/layergroups/%s.xml", lyr),
               sprintf("/workspaces/%s/layergroups/%s.xml", ws, lyr)),
        verbose = self$verbose.debug)
      layer <- NULL
      if(status_code(req) == 200){
        lyrXML <- GSUtils$parseResponseXML(req)
        layer <- GSLayerGroup$new(xml = lyrXML)
        msg = "Successfuly fetched layer group!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching layer group"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(layer)
    },
    
    #'@description Creates a layer group
    #'@param layerGroup object of class \link{GSLayerGroup}
    #'@param ws workspace name. Optional
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createLayerGroup = function(layerGroup, ws = NULL){
      if(is.null(ws)){
        msg = sprintf("Creating layer group '%s'", layerGroup$name)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }else{
        msg = sprintf("Creating layer group '%s' in workspace '%s'", layerGroup$name, ws)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = ifelse(is.null(ws),"/layergroups.xml",
                      sprintf("/workspaces/%s/layergroups.xml", ws)),
        content = GSUtils$getPayloadXML(layerGroup),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        msg = "Successfuly created layer group!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while creating layer group"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(created)
    },
    
    #'@description Updates a layer group
    #'@param layerGroup object of class \link{GSLayerGroup}
    #'@param ws workspace name. Optional
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateLayerGroup = function(layerGroup, ws = NULL){
      if(is.null(ws)){
        msg = sprintf("Updating layer '%s'", layerGroup$name)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }else{
        msg = sprintf("Updating layer '%s' in workspace '%s'", layerGroup$name, ws)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = ifelse(is.null(ws),
                      sprintf("/layergroups/%s.xml", layerGroup$name),
                      sprintf("/workspaces/%s/layergroups/%s.xml", ws, layerGroup$name)),
        content = GSUtils$getPayloadXML(layerGroup),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfuly updated layer group!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating layer group"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(updated)
    },
    
    #'@description Deletes a layer group
    #'@param lyr layer group name
    #'@param ws workspace name. Optional
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteLayerGroup = function(lyr, ws = NULL){
      if(is.null(ws)){
        msg = sprintf("Deleting layer group '%s'", lyr)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }else{
        msg = sprintf("Deleting layer group '%s' in workspace '%s'", lyr, ws)
        cli::cli_alert_info(msg)
        self$INFO(msg)
      }
      deleted <- FALSE
      path <- ifelse(is.null(ws),
                     sprintf("/layergroups/%s.xml", lyr),
                     sprintf("/workspaces/%s/layergroups/%s.xml", ws, lyr))
      req <- GSUtils$DELETE(self$getUrl(), private$user, 
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfuly deleted layer group!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting layer group"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)
    }
  )
)
