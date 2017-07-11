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
#' @section Constructor:
#' \describe{
#'  \item{\code{new(url, user, pwd, logger)}}{
#'    This method is used to instantiate a GSManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd}). By default,
#'    the \code{logger} argument will be set to \code{NULL} (no logger). This argument
#'    accepts two possible values: \code{INFO}: to print only geosapi logs,
#'    \code{DEBUG}: to print geosapi and CURL logs
#'  }
#' }
#' 
#' @section \code{DataStore} methods:
#' \describe{ 
#'  \item{\code{getDataStores(ws)}}{
#'    Get the list of available dataStores. Returns an object of class \code{list}
#'    giving items of class \code{\link{GSDataStore}}
#'  }
#'  \item{\code{getDataStoreNames(ws)}}{
#'    Get the list of available dataStore names. Returns an vector of class \code{character}
#'  }
#'  \item{\code{getDataStore(ws, ds)}}{
#'    Get an object of class \code{\link{GSDataStore}} given a workspace and datastore
#'    names.
#'  }
#'  \item{\code{createDataStore(ws, dataStore)}}{
#'    Creates a new datastore given a workspace and an object of class \code{\link{GSDataStore}}
#'  }
#'  \item{\code{updateDataStore(ws, dataStore)}}{
#'    Updates an existing dataStore given a workspace and an object of class \code{\link{GSDataStore}}
#'  }
#'  \item{\code{deleteDataStore(ws, ds, recurse)}}{
#'    Deletes a datastore given a workspace and an object of class \code{\link{GSDataStore}}.
#'    By defaut, the option \code{recurse} is set to FALSE, ie datastore layers are not removed.
#'    To remove all datastore layers, set this option to TRUE.
#'  }
#' }
#' 
#' @section \code{FeatureType} methods:
#' \describe{ 
#'  \item{\code{getFeatureTypes(ws, ds)}}{
#'    Get the list of available feature types for given workspace and datastore.
#'    Returns an object of class \code{list} giving items of class \code{\link{GSFeatureType}}
#'  }
#'  \item{\code{getFeatureTypeNames(ws, ds)}}{
#'    Get the list of available feature type names for given workspace and datastore.
#'    Returns an vector of class\code{character}
#'  }
#'  \item{\code{getFeatureType(ws, ds, ft)}}{
#'    Get an object of class \code{\link{GSFeatureType}} given a workspace, datastore
#'    and feature type names.
#'  }
#'  \item{\code{createFeatureType(ws, ds, featureType)}}{
#'    Creates a new featureType given a workspace, datastore names and an object of
#'    class \code{\link{GSFeatureType}}
#'  }
#'  \item{\code{updateFeatureType(ws, ds, FeatureType)}}{
#'    Updates a featureType given a workspace, datastore names and an object of
#'    class \code{\link{GSFeatureType}}
#'  }
#'  \item{\code{deleteFeatureType(ws, ds, featureType, recurse)}}{
#'    Deletes a featureType given a workspace, datastore names, and an object of 
#'    class \code{\link{GSFeatureType}}. By defaut, the option \code{recurse} is 
#'    set to FALSE, ie datastore layers are not removed.
#'  }
#' }
#' 
#' @section \code{Layer} methods:
#' \describe{ 
#'  \item{\code{getLayers()}}{
#'    Get the list of layers. Returns an object of class \code{list} giving items 
#'    of class \code{\link{GSLayer}}
#'  }
#'  \item{\code{getLayerNames()}}{
#'    Get the list of layer names.
#'  }
#'  \item{\code{getLayer(lyr)}}{
#'    Get an object of class \code{\link{GSLayer}} if existing
#'  }
#'  \item{\code{createLayer(layer)}}{
#'    Creates a new layer given an object of class \code{\link{GSLayer}}
#'  }
#'  \item{\code{updateLayer(layer)}}{
#'    Creates a layer given an object of class \code{\link{GSLayer}}
#'  }
#'  \item{\code{deleteLayer(layer)}}{
#'    Deletes a layer given an object of class \code{\link{GSLayer}}
#'  }
#' }
#' 
#' @section \code{LayerGroup} methods:
#' \describe{ 
#'  \item{\code{getLayerGroups()}}{
#'    Get the list of layers. Returns an object of class \code{list} giving items 
#'    of class \code{\link{GSLayer}}
#'  }
#'  \item{\code{getLayerGroupNames()}}{
#'    Get the list of layer names.
#'  }
#'  \item{\code{getLayerGroup(lyr, ws)}}{
#'    Get an object of class \code{\link{GSLayerGroup}} if existing. Can be restrained
#'    to a workspace.
#'  }
#'  \item{\code{createLayerGroup(layerGroup, ws)}}{
#'    Creates a new layer given an object of class \code{\link{GSLayerGroup}}. Can be
#'    restrained to a particular workspace.
#'  }
#'  \item{\code{updateLayerGroup(layerGroup, ws)}}{
#'    Creates a layer given an object of class \code{\link{GSLayerGroup}}. Can be
#'    restrained to a particular workspace.
#'  }
#'  \item{\code{deleteLayerGroup(layerGroup, ws)}}{
#'    Deletes a layer given an object of class \code{\link{GSLayerGroup}}. Can be
#'    restrained to a particular workspace.
#'  }
#' }
#' 
#' @section Main \code{Layer} user publication methods:
#' \describe{ 
#'  \item{\code{publishLayer(ws, ds, featureType, layer)}}{
#'    Publish a web-layer (including the featureType and 'layer' resources), given
#'    a workspace, a datastore, providing an object of class \code{GSFeatureType},
#'    and \code{GSLayer}
#'  }
#'  \item{\code{unpublishLayer(ws, ds, featureType, layer)}}{
#'    Unpublish a web-layer (including the featureType and 'layer' resources), given
#'    a workspace, a datastore, and a layer name
#'  }
#' }
#' 
#' @section Data upload methods:
#' \describe{ 
#'  \item{\code{uploadData(ws, ds, endpoint, extension,
#'                         configure, update, filename, charset, contentType)}}{
#'    Uploads data to a target dataStore
#'  }
#'  \item{\code{uploadShapefile(ws, ds, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a zipped ESRIshapefile to a target dataStore
#'  }
#'  \item{\code{uploadProperties(ws, ds, endpoint,
#'                               configure, update, filename, charset)}}{
#'    Uploads a properties file to a target dataStore
#'  }
#'  \item{\code{uploadH2(ws, ds, endpoint,
#'                       configure, update, filename, charset)}}{
#'    Uploads a H2 database to a target dataStore
#'  }
#'  \item{\code{uploadSpatialite(ws, ds, endpoint,
#'                               configure, update, filename, charset)}}{
#'    Uploads a Spatialite database to a target dataStore
#'  }
##'  \item{\code{uploadAppschema(ws, ds, endpoint,
#'                               configure, update, filename, charset)}}{
#'    Uploads a appschema file to a target dataStore
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDataStoreManager <- R6Class("GSDataStoreManager",
  inherit = GSManager,
  
  public = list(   
     
    #DataStore generic CRUD methods
    #===========================================================================
    
    #getDataStores
    #---------------------------------------------------------------------------
    getDataStores = function(ws){
      self$INFO(sprintf("Fetching list of datastores in workspace '%s'", ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
              GSDataStore$new(xml = dsXML)
          )
          return(dataStore)
        })
        self$INFO(sprintf("Successfully fetched %s datastores!", length(dsList)))
      }else{
        self$ERROR("Error while fetching list of datastores")
      }
      return(dsList)
    },
    
    #getDataStoreNames
    #---------------------------------------------------------------------------
    getDataStoreNames = function(ws){
      dsList <- sapply(self$getDataStores(ws), function(x){x$name})
      return(dsList)
    },
    
    #getDataStore
    #---------------------------------------------------------------------------
    getDataStore = function(ws, ds){
      self$INFO(sprintf("Fetching datastore '%s' in workspace '%s'", ds, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
        sprintf("/workspaces/%s/datastores/%s.xml", ws, ds),
        verbose = self$verbose.debug)
      dataStore <- NULL
      if(status_code(req) == 200){
        dsXML <- GSUtils$parseResponseXML(req)
        dsType <-  xmlValue(xmlChildren(xmlRoot(dsXML))$type)
        dataStore <- switch(dsType,
          "Shapefile" = GSShapefileDataStore$new(xml = dsXML),
          "Directory of spatial files (shapefiles)" = GSShapefileDirectoryDataStore$new(xml = dsXML),
          GSDataStore$new(xml = dsXML)
        )
        self$INFO("Successfully fetched datastore!")
      }else{
        self$ERROR("Error while fetching datastore")
      }
      return(dataStore)
    },
    
    #createDataStore
    #---------------------------------------------------------------------------
    createDataStore = function(ws, dataStore){
      self$INFO(sprintf("Creating datastore '%s' in workspace '%s'", dataStore$name, ws))
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$pwd,
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
    
    #updatDataStore
    #---------------------------------------------------------------------------
    updateDataStore = function(ws, dataStore){
      updated <- FALSE
      self$INFO(sprintf("Updating datastore '%s' in workspace '%s'", dataStore$name, ws))
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #deleteDataStore
    #---------------------------------------------------------------------------
    deleteDataStore = function(ws, ds, recurse = FALSE){
      self$INFO(sprintf("Deleting datastore '%s' in workspace '%s'", ds, ws))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s.xml", ws, ds)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
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
    
    #getFeatureTypes
    #---------------------------------------------------------------------------
    getFeatureTypes = function(ws, ds, list = "configured"){
      self$INFO(sprintf("Fetching featureTypes for datastore '%s' in workspace '%s'", ds, ws))
      supportedListValues <- c("configured", "available", "available_with_geom", "all")
      if(!(list %in% supportedListValues)){
        stop(sprintf("Unsupported 'list' parameter value '%s'. Possible values: [%s]",
                     list, paste0(supportedListValues, collapse=",")))
      }
      
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
    
    #getFeatureTypeNames
    #---------------------------------------------------------------------------
    getFeatureTypeNames = function(ws, ds){
      ftList <- sapply(self$getFeatureTypes(ws, ds), function(x){x$name})
      return(ftList)
    },
    
    #getFeatureType
    #---------------------------------------------------------------------------
    getFeatureType = function(ws, ds, ft){
      self$INFO(sprintf("Fetching featureType '%s' in datastore '%s' (workspace '%s')", ft, ds, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
    
    #createFeatureType
    #---------------------------------------------------------------------------
    createFeatureType = function(ws, ds, featureType){
      self$INFO(sprintf("Creating featureType '%s' in datastore '%s' (workspace '%s')", featureType$name, ds, ws))
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$pwd,
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
    
    #updateFeatureType
    #---------------------------------------------------------------------------
    updateFeatureType = function(ws, ds, featureType){
      self$INFO(sprintf("Updating featureType '%s' in datastore '%s' (workspace '%s')", featureType$name, ds, ws))
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #deleteFeatureType
    #---------------------------------------------------------------------------
    deleteFeatureType = function(ws, ds, ft, recurse = FALSE){
      self$INFO(sprintf("Deleting featureType '%s' in datastore '%s' (workspace '%s')", ft, ds, ws))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml", ws, ds, ft)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
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

    #getLayers
    #---------------------------------------------------------------------------
    getLayers = function(){
      self$INFO("Fetching layers")
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
    
    #getLayerNames
    #---------------------------------------------------------------------------
    getLayerNames = function(){
      lyrList <- sapply(self$getLayers(), function(x){x$name})
      return(lyrList)
    },
    
    #getLayer
    #---------------------------------------------------------------------------
    getLayer = function(lyr){
      self$INFO(sprintf("Fetching layer '%s'", lyr))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
    
    #createLayer
    #---------------------------------------------------------------------------
    createLayer = function(layer){
      self$INFO(sprintf("Creating layer '%s'", layer$name))
      created <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #updateLayer
    #---------------------------------------------------------------------------
    updateLayer = function(layer){
      self$INFO(sprintf("Updating layer '%s'", layer$name))
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #deleteLayer
    #---------------------------------------------------------------------------
    deleteLayer = function(lyr){
      self$INFO(sprintf("Deleting layer '%s'", lyr))
      deleted <- FALSE
      path <- sprintf("/layers/%s.xml", lyr)
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
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
    
    #getLayerGroups
    #---------------------------------------------------------------------------
    getLayerGroups = function(ws = NULL){
      if(missing(ws)){
        self$INFO("Fetching layer groups")
      }else{
        self$INFO(sprintf("Fetching layer groups for workspace '%s'", ws))
      }
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
    
    #getLayerGroupNames
    #---------------------------------------------------------------------------
    getLayerGroupNames = function(ws = NULL){
      lyrList <- sapply(self$getLayerGroups(ws), function(x){x$name})
      return(lyrList)
    },
    
    #getLayerGroup
    #---------------------------------------------------------------------------
    getLayerGroup = function(lyr, ws = NULL){
      if(is.null(ws)){
        self$INFO(sprintf("Fetching layer group '%s'", lyr))
      }else{
        self$INFO(sprintf("Fetching layer group '%s' in workspace '%s'", lyr, ws))
      }
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
    
    #createLayerGroup
    #---------------------------------------------------------------------------
    createLayerGroup = function(layerGroup, ws = NULL){
      if(is.null(ws)){
        self$INFO(sprintf("Creating layer group '%s'", layerGroup$name))
      }else{
        self$INFO(sprintf("Creating layer group '%s' in workspace '%s'", layerGroup$name, ws))
      }
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #updateLayerGroup
    #---------------------------------------------------------------------------
    updateLayerGroup = function(layerGroup, ws = NULL){
      if(is.null(ws)){
        self$INFO(sprintf("Updating layer '%s'", layerGroup$name))
      }else{
        self$INFO(sprintf("Updating layer '%s' in workspace '%s'", layerGroup$name, ws))
      }
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #deleteLayerGroup
    #---------------------------------------------------------------------------
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
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
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
    #publishLayer
    #---------------------------------------------------------------------------
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
    
    #unpublishLayer
    #---------------------------------------------------------------------------
    unpublishLayer = function(ws, ds, lyr){
      self$INFO(sprintf("Unpublishing layer '%s'", lyr))
      unpublished <- FALSE
      lyrDeleted <- self$deleteLayer(lyr)
      ftDeleted <- self$deleteFeatureType(ws, ds, lyr)
      if(ftDeleted){
          unpublished <- TRUE
          self$INFO("Successfully unpublished layer!")
      }
      if(!unpublished) self$ERROR("Error while unpublishing layer")
      return(unpublished)
    },
    
    #Upload methods
    #===========================================================================
    #uploadData
    #---------------------------------------------------------------------------
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
      
      supportedExtensions <- c("shp", "spatialite", "h2")
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
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
      if(!uploaded) self$ERROR("Error while uploading data")
      return(uploaded)
    },
    
    #uploadShapefile
    #---------------------------------------------------------------------------
    uploadShapefile = function(ws, ds, endpoint = "file",
                                configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "shp",
                        configure, update, filename, charset,
                        contentType = "application/zip")
      )
    },
    
    #uploadProperties (to test)
    #---------------------------------------------------------------------------
    uploadProperties = function(ws, ds, endpoint = "file",
                               configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "properties",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #uploadH2 (to test)
    #---------------------------------------------------------------------------
    uploadH2 = function(ws, ds, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "h2",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #uploadSpatialite (to test)
    #---------------------------------------------------------------------------
    uploadSpatialite = function(ws, ds, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "spatialite",
                        configure, update, filename, charset,
                        contentType = "application/x-sqlite3")
      )
    },
    
    #uploadAppschema (to test)
    #---------------------------------------------------------------------------
    uploadAppschema = function(ws, ds, endpoint = "file",
                                configure = "first", update = "append",
                                filename, charset = "UTF-8"){
      return(
        self$uploadData(ws, ds, endpoint, extension = "appschema",
                        configure, update, filename, charset,
                        contentType = "application/appschema")
      )
    }
    
  )
                                                        
)
