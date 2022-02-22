#' Geoserver REST API DataStore Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore
#' @return Object of \code{\link{R6Class}} with methods for managing GeoServer
#' DataStores (i.e. stores of vector data)
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSDataStoreManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'  }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDataStoreManager <- R6Class("GSDataStoreManager",
  inherit = GSManager,
  
  public = list(   
     
    #DataStore generic CRUD methods
    #===========================================================================
    
    #'@description Get the list of available dataStores. 
    #'@param ws workspace name
    #'@return an object of class \code{list} giving items of class \code{\link{GSAbstractDataStore}}
    getDataStores = function(ws){
      self$INFO(sprintf("Fetching list of datastores in workspace '%s'", ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores.xml", ws),
        verbose = self$verbose.debug)
      dsList <- NULL
      if(status_code(req) == 200){
        dsXML <- GSUtils$parseResponseXML(req)
        dsXMLList <- getNodeSet(dsXML, "//dataStore")
        dsList <- lapply(dsXMLList, function(x){
          xml <- xmlDoc(x)
          dsType <-  xmlValue(xmlChildren(xmlRoot(xml))$type)
          dataStore <- switch(dsType,
              "Shapefile" = GSShapefileDataStore$new(xml = xml),
              "Directory of spatial files (shapefiles)" = GSShapefileDirectoryDataStore$new(xml = xml),
              "GeoPackage" = GSGeoPackageDataStore$new(xml = xml),
              "PostGIS" = GSPostGISDataStore$new(xml = xml),
              "Oracle NG" = GSOracleNGDataStore$new(xml = xml),
              GSAbstractDataStore$new(xml = dsXML)
          )
          return(dataStore)
        })
        self$INFO(sprintf("Successfully fetched %s datastores!", length(dsList)))
      }else{
        self$ERROR("Error while fetching list of datastores")
      }
      return(dsList)
    },
    
    #'@description Get the list of available dataStore names.
    #'@param ws workspace name
    #'@return a vector of class \code{character}
    getDataStoreNames = function(ws){
      dsList <- sapply(self$getDataStores(ws), function(x){x$name})
      return(dsList)
    },
    
    #'@description Get an object of class \code{\link{GSAbstractDataStore}} given a workspace and datastore names.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@return the datastore
    getDataStore = function(ws, ds){
      self$INFO(sprintf("Fetching datastore '%s' in workspace '%s'", ds, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores/%s.xml", ws, ds),
        verbose = self$verbose.debug)
      dataStore <- NULL
      if(status_code(req) == 200){
        dsXML <- GSUtils$parseResponseXML(req)
        dsType <-  xmlValue(xmlChildren(xmlRoot(dsXML))$type)
        dataStore <- switch(dsType,
          "Shapefile" = GSShapefileDataStore$new(xml = dsXML),
          "Directory of spatial files (shapefiles)" = GSShapefileDirectoryDataStore$new(xml = dsXML),
          "GeoPackage" = GSGeoPackageDataStore$new(xml = dsXML),
          "PostGIS" = GSPostGISDataStore$new(xml = xml),
          "Oracle NG" = GSOracleNGDataStore$new(xml = xml),
          GSAbstractDataStore$new(xml = dsXML)
        )
        self$INFO("Successfully fetched datastore!")
      }else{
        self$ERROR("Error while fetching datastore")
      }
      return(dataStore)
    },
    
    #'@description Creates a datastore given a workspace and an object of class \code{\link{GSAbstractDataStore}}.
    #'@param ws workspace name
    #'@param dataStore datastore object of class \link{GSAbstractDataStore}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createDataStore = function(ws, dataStore){
      self$INFO(sprintf("Creating datastore '%s' in workspace '%s'", dataStore$name, ws))
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/datastores.xml", ws),
        content = GSUtils$getPayloadXML(dataStore),
        contentType = "text/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        self$INFO("Successfully created datastore!")
        created = TRUE
      }else{
        self$ERROR("Error while creating datastore")
      }
    },
    
    
    #'@description Updates a datastore given a workspace and an object of class \code{\link{GSAbstractDataStore}}.
    #'@param ws workspace name
    #'@param dataStore datastore object of class \link{GSAbstractDataStore}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateDataStore = function(ws, dataStore){
      updated <- FALSE
      self$INFO(sprintf("Updating datastore '%s' in workspace '%s'", dataStore$name, ws))
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, 
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/datastores/%s.xml", ws, dataStore$name),
        content = GSUtils$getPayloadXML(dataStore),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully updated datastore!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating datastore")
      }
      return(updated)
    },
    
    #'@description Deletes a datastore given workspace and datastore names.
    #'    By defaut, the option \code{recurse} is set to FALSE, ie datastore layers are not removed.
    #'    To remove all datastore layers, set this option to TRUE.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param recurse recurse 
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteDataStore = function(ws, ds, recurse = FALSE){
      self$INFO(sprintf("Deleting datastore '%s' in workspace '%s'", ds, ws))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s.xml", ws, ds)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user, 
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully deleted datastore!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting datastore")
      }
      return(deleted)  
    },
  
    #DataStore featureType CRUD methods
    #===========================================================================
    
    #'@description Get the list of available feature types for given workspace and datastore.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param list list type value, among "configured", "available", "available_with_geom", "all"
    #'@return an object of class \code{list} giving items of class \code{\link{GSFeatureType}}
    getFeatureTypes = function(ws, ds, list = "configured"){
      self$INFO(sprintf("Fetching featureTypes for datastore '%s' in workspace '%s'", ds, ws))
      supportedListValues <- c("configured", "available", "available_with_geom", "all")
      if(!(list %in% supportedListValues)){
        stop(sprintf("Unsupported 'list' parameter value '%s'. Possible values: [%s]",
                     list, paste0(supportedListValues, collapse=",")))
      }
      
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores/%s/featuretypes.xml?list=%s", ws, ds, list),
        verbose = self$verbose.debug)
      ftList <- NULL
      if(status_code(req) == 200){
        ftXML <- GSUtils$parseResponseXML(req)
        ftXMLList <- getNodeSet(ftXML, "//featureTypes/featureType")
        ftList <- lapply(ftXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSFeatureType$new(xml = xml))
        })
        self$INFO(sprintf("Successfully fetched %s featureTypes!", length(ftList)))
      }else{
        self$ERROR("Error while fetching list of featureTypes")
      }
      return(ftList)
    },
    
    #'@description Get the list of available feature type names for given workspace and datastore.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@return a vector of class\code{character}
    getFeatureTypeNames = function(ws, ds){
      ftList <- sapply(self$getFeatureTypes(ws, ds), function(x){x$name})
      return(ftList)
    },
    
    #'@description Get an object of class \code{\link{GSFeatureType}} given a workspace, datastore and feature type names.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param ft feature type name
    #'@return an object of class \link{GSFeatureType}
    getFeatureType = function(ws, ds, ft){
      self$INFO(sprintf("Fetching featureType '%s' in datastore '%s' (workspace '%s')", ft, ds, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml", ws, ds, ft),
        verbose = self$verbose.debug)
      featureType <- NULL
      if(status_code(req) == 200){
        ftXML <- GSUtils$parseResponseXML(req)
        featureType <- GSFeatureType$new(xml = ftXML)
        self$INFO("Successfully fetched featureType!")
      }else{
        self$ERROR("Error while fetching featureType")
      }
      return(featureType)
    },
    
    #'@description Creates a new featureType given a workspace, datastore names and an object of class \code{\link{GSFeatureType}}
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param featureType feature type
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createFeatureType = function(ws, ds, featureType){
      self$INFO(sprintf("Creating featureType '%s' in datastore '%s' (workspace '%s')", featureType$name, ds, ws))
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/datastores/%s/featuretypes.xml", ws, ds),
        content = GSUtils$getPayloadXML(featureType),
        contentType = "text/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        self$INFO("Successfully created featureType!")
        created = TRUE
      }else{
        self$ERROR("Error while creating featureType")
      }
      return(created)
    },
    
    #'@description Updates a featureType given a workspace, datastore names and an object of class \code{\link{GSFeatureType}}
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param featureType feature type
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateFeatureType = function(ws, ds, featureType){
      self$INFO(sprintf("Updating featureType '%s' in datastore '%s' (workspace '%s')", featureType$name, ds, ws))
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, 
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml",
                       ws, ds, featureType$name),
        content = GSUtils$getPayloadXML(featureType),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully updated featureType!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating featureType")
      }
      return(updated)
    },
    
    #'@description Deletes a featureType given a workspace, datastore names, and an object of 
    #'    class \code{\link{GSFeatureType}}. By defaut, the option \code{recurse} is 
    #'    set to FALSE, ie datastore layers are not removed.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param ft feature type name
    #'@param recurse recurse
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteFeatureType = function(ws, ds, ft, recurse = FALSE){
      self$INFO(sprintf("Deleting featureType '%s' in datastore '%s' (workspace '%s')", ft, ds, ws))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml", ws, ds, ft)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfuly deleted featureType!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting featureType")
      }
      return(deleted)  
    },
    
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
        lyrXMLList <- getNodeSet(lyrXML, "//layers/layer")
        lyrList <- lapply(lyrXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSLayer$new(xml = xml))
        })
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
        lyrXMLList <- getNodeSet(lyrXML, "//layerGroups/layerGroup")
        lyrList <- lapply(lyrXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSLayerGroup$new(xml = xml))
        })
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
    },
    
    #Layer publication methods
    #===========================================================================    
    #'@description Publish a feature type/layer pair given a workspace and datastore. The name 'layer' here 
    #'encompasses both \link{GSFeatureType} and \link{GSLayer} resources.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param featureType object of class \link{GSFeatureType}
    #'@param layer object of class \link{GSLayer}
    #'@return \code{TRUE} if published, \code{FALSE} otherwise
    publishLayer = function(ws, ds, featureType, layer){
      self$INFO(sprintf("Publishing layer '%s'", layer$name))
      published <- FALSE
      if(featureType$name != layer$name){
        stop("FeatureType and Layer names differ!")
      }
      ftCreated <- self$createFeatureType(ws, ds, featureType)
      if(ftCreated){
        lyrCreated <- self$createLayer(layer)
        if(lyrCreated){
          published <- TRUE
          self$INFO("Successfully published layer!")
        }else{
          #rolling back
          published <- FALSE
          self$INFO("Rolling back - deleting previously created FeatureType!")
          ftDeleted <- self$deleteFeatureType(ws, ds, featureType$name)
        }
      }
      if(!published) self$ERROR("Error while publishing layer")
      return(published)
    },
    
    #'@description Unpublish a feature type/layer pair given a workspace and datastore. The name 'layer' here 
    #'encompasses both \link{GSFeatureType} and \link{GSLayer} resources.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param lyr layer name
    #'@return \code{TRUE} if published, \code{FALSE} otherwise
    unpublishLayer = function(ws, ds, lyr){
      self$INFO(sprintf("Unpublishing layer '%s'", lyr))
      unpublished <- FALSE
      layer <- self$getLayer(lyr)
      if(is(layer, "GSLayer")){
        lyrDeleted <- self$deleteLayer(lyr)
      }
      featureType <- self$getFeatureType(ws, ds, lyr)
      if(is(featureType, "GSFeatureType")){
        ftDeleted <- self$deleteFeatureType(ws, ds, lyr)
        if(ftDeleted){
            unpublished <- TRUE
            self$INFO("Successfully unpublished layer!")
        }
      }
      return(unpublished)
    },
    
    #Upload methods
    #===========================================================================
    #'@description Uploads features data. The \code{extension} corresponds to the format/type of features to be uploaded among "shp", "spatialite", "h2", "gpkg". 
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param endpoint endpoint
    #'@param extension extension
    #'@param configure configure strategy among values: "first" or "none"
    #'@param update update strategy, among values: "append", "overwrite"
    #'@param filename file name of the resource to upload
    #'@param charset charset
    #'@param contentType content type
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadData = function(ws, ds, endpoint = "file", extension,
                          configure = "first", update = "append", filename,
                          charset, contentType){
      self$INFO(sprintf("Uploading %s data in datastore '%s' (workspace '%s')",
                        toupper(extension), ds, ws))
      
      uploaded <- FALSE
      
      supportedEndpoints <- c("file","url","external")
      if(!(endpoint %in% supportedEndpoints)){
        stop(sprintf("Unsupported endpoint '%s'. Possible values: [%s]",
                     endpoint, paste0(supportedEndpoints, collapse=",")))
      }
      
      supportedExtensions <- c("shp", "spatialite", "h2", "gpkg")
      if(!(extension %in% supportedExtensions)){
        stop(sprintf("Unsupported extension '%s'. Possible values: [%s]",
                     extension, paste0(supportedExtensions, collapse=",")))
      }
      
      supportedConfigurations <- c("first", "none", "all")
      if(!(configure %in% supportedConfigurations)){
        stop(sprintf("Unsupported configure parameter '%s'. Possible values: [%s]",
                     configure, paste0(supportedConfigurations, collapse=",")))
      }
      
      supportedUpdates <- c("append","overwrite")
      if(!(update %in% supportedUpdates)){
        stop(sprintf("Unsupported update parameter '%s'. Possible values: [%s]",
                     update, paste0(supportedUpdates, collapse=",")))
      }
      
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/datastores/%s/%s.%s?configure=%s&update=%s",
                       ws, ds, endpoint, extension, configure, update),
        content = NULL,
        filename = filename,
        contentType = contentType,
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        self$INFO("Successfull data upload!")
        uploaded = TRUE
      }
      if(!uploaded){
        self$ERROR("Error while uploading data")
        self$ERROR(http_status(req)$message)
      }
      return(uploaded)
    },
    
    #'@description Uploads zipped shapefile.
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param endpoint endpoint
    #'@param configure configure strategy among values: "first" or "none"
    #'@param update update strategy, among values: "append", "overwrite"
    #'@param filename file name of the resource to upload
    #'@param charset charset
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadShapefile = function(ws, ds, endpoint = "file",
                                configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "shp",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #'@description Uploads properties.
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param endpoint endpoint
    #'@param configure configure strategy among values: "first" or "none"
    #'@param update update strategy, among values: "append", "overwrite"
    #'@param filename file name of the resource to upload
    #'@param charset charset
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadProperties = function(ws, ds, endpoint = "file",
                               configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "properties",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #'@description Uploads H2 database.
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param endpoint endpoint
    #'@param configure configure strategy among values: "first" or "none"
    #'@param update update strategy, among values: "append", "overwrite"
    #'@param filename file name of the resource to upload
    #'@param charset charset
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadH2 = function(ws, ds, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "h2",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #'@description Uploads spatialite file.
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param endpoint endpoint
    #'@param configure configure strategy among values: "first" or "none"
    #'@param update update strategy, among values: "append", "overwrite"
    #'@param filename file name of the resource to upload
    #'@param charset charset
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadSpatialite = function(ws, ds, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "spatialite",
                        configure, update, filename, charset,
                        contentType = "application/x-sqlite3")
      )
    },
    
    #'@description Uploads App schema.
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param endpoint endpoint
    #'@param configure configure strategy among values: "first" or "none"
    #'@param update update strategy, among values: "append", "overwrite"
    #'@param filename file name of the resource to upload
    #'@param charset charset
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadAppschema = function(ws, ds, endpoint = "file",
                                configure = "first", update = "append",
                                filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "appschema",
                        configure, update, filename, charset,
                        contentType = "application/appschema")
      )
    },
    
    #'@description Uploads GeoPackage.
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param endpoint endpoint
    #'@param configure configure strategy among values: "first" or "none"
    #'@param update update strategy, among values: "append", "overwrite"
    #'@param filename file name of the resource to upload
    #'@param charset charset
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadGeoPackage = function(ws, ds, endpoint = "file",
                               configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "gpkg",
                        configure, update, filename, charset,
                        contentType = "")
      )
    }
    
  )
                                                        
)
