#' Geoserver REST API Layer Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api Layer
#' @return Object of \code{\link{R6Class}} with methods for managing GeoServer
#' Layers as results of published feature types or coverages
#' @format \code{\link{R6Class}} object.
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
      self$INFO("Fetching layers")
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        "/layers.xml", verbose = self$verbose.debug)
      lyrList <- NULL
      if(status_code(req) == 200){
        lyrXML <- GSUtils$parseResponseXML(req)
        lyrXMLList <- as(xml2::xml_find_all(lyrXML, "//layers/layer"), "list")
        lyrList <- lapply(lyrXMLList, GSLayer$new)
        self$INFO(sprintf("Successfuly fetched %s layers!", length(lyrList)))
      }else{
        self$ERROR("Error while fetching layers")
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
      self$INFO(sprintf("Fetching layer '%s'", lyr))
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/layers/%s.xml", lyr),
        verbose = self$verbose.debug)
      layer <- NULL
      if(status_code(req) == 200){
        lyrXML <- GSUtils$parseResponseXML(req)
        layer <- GSLayer$new(xml = lyrXML)
        self$INFO("Successfuly fetched layer!")
      }else{
        self$ERROR("Error while fetching layer")
      }
      return(layer)
    },
    
    #'@description Creates a new layer given an object of class \code{\link{GSLayer}}
    #'@param  layer object of class \link{GSLayer}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createLayer = function(layer){
      self$INFO(sprintf("Creating layer '%s'", layer$name))
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
        self$INFO("Successfuly created layer!")
        created = TRUE
      }else{
        self$ERROR("Error while creating layer")
      }
      return(created)
    },
    
    #'@description Updates a layer given an object of class \code{\link{GSLayer}}
    #'@param  layer object of class \link{GSLayer}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateLayer = function(layer){
      self$INFO(sprintf("Updating layer '%s'", layer$name))
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
        self$INFO("Successfuly updated layer!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating layer")
      }
      return(updated)
    },
    
    #'@description Deletes layer given an object of class \code{\link{GSLayer}}
    #'@param  lyr layer name
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteLayer = function(lyr){
      self$INFO(sprintf("Deleting layer '%s'", lyr))
      deleted <- FALSE
      path <- sprintf("/layers/%s.xml", lyr)
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfuly deleted layer!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting layer")
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
        self$INFO("Fetching layer groups")
      }else{
        self$INFO(sprintf("Fetching layer groups for workspace '%s'", ws))
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
        self$INFO(sprintf("Successfuly fetched %s layer groups!", length(lyrList)))
      }else{
        self$ERROR("Error while fetching layer groups")
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
        self$INFO(sprintf("Fetching layer group '%s'", lyr))
      }else{
        self$INFO(sprintf("Fetching layer group '%s' in workspace '%s'", lyr, ws))
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
        self$INFO("Successfuly fetched layer group!")
      }else{
        self$ERROR("Error while fetching layer group")
      }
      return(layer)
    },
    
    #'@description Creates a layer group
    #'@param layerGroup object of class \link{GSLayerGroup}
    #'@param ws workspace name. Optional
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createLayerGroup = function(layerGroup, ws = NULL){
      if(is.null(ws)){
        self$INFO(sprintf("Creating layer group '%s'", layerGroup$name))
      }else{
        self$INFO(sprintf("Creating layer group '%s' in workspace '%s'", layerGroup$name, ws))
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
        self$INFO("Successfuly created layer group!")
        created = TRUE
      }else{
        self$ERROR("Error while creating layer group")
      }
      return(created)
    },
    
    #'@description Updates a layer group
    #'@param layerGroup object of class \link{GSLayerGroup}
    #'@param ws workspace name. Optional
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateLayerGroup = function(layerGroup, ws = NULL){
      if(is.null(ws)){
        self$INFO(sprintf("Updating layer '%s'", layerGroup$name))
      }else{
        self$INFO(sprintf("Updating layer '%s' in workspace '%s'", layerGroup$name, ws))
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
        self$INFO("Successfuly updated layer group!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating layer group")
      }
      return(updated)
    },
    
    #'@description Deletes a layer group
    #'@param lyr layer group name
    #'@param ws workspace name. Optional
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteLayerGroup = function(lyr, ws = NULL){
      if(is.null(ws)){
        self$INFO(sprintf("Deleting layer group '%s'", lyr))
      }else{
        self$INFO(sprintf("Deleting layer group '%s' in workspace '%s'", lyr, ws))
      }
      deleted <- FALSE
      path <- ifelse(is.null(ws),
                     sprintf("/layergroups/%s.xml", lyr),
                     sprintf("/workspaces/%s/layergroups/%s.xml", ws, lyr))
      req <- GSUtils$DELETE(self$getUrl(), private$user, 
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfuly deleted layer group!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting layer group")
      }
      return(deleted)
    }
  )
)