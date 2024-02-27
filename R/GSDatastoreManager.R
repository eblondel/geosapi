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
      msg = sprintf("Fetching list of datastores in workspace '%s'", ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores.xml", ws),
        verbose = self$verbose.debug)
      dsList <- NULL
      if(status_code(req) == 200){
        dsXML <- GSUtils$parseResponseXML(req)
        dsXMLList <- as(xml2::xml_find_all(dsXML, "//dataStore"), "list")
        dsList <- lapply(dsXMLList, function(xml){
          dsType <-  xml2::xml_find_first(xml, "//type") %>% xml2::xml_text()
          dataStore <- switch(dsType,
              "Shapefile" = GSShapefileDataStore$new(xml = xml),
              "Directory of spatial files (shapefiles)" = GSShapefileDirectoryDataStore$new(xml = xml),
              "GeoPackage" = GSGeoPackageDataStore$new(xml = xml),
              "PostGIS" = GSPostGISDataStore$new(xml = xml),
              "Oracle NG" = GSOracleNGDataStore$new(xml = xml),
              GSAbstractDataStore$new(xml = xml)
          )
          return(dataStore)
        })
        msg = sprintf("Successfully fetched %s datastores!", length(dsList))
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching list of datastores"
        cli::cli_alert_danger(err)
        self$ERROR(err)
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
      msg = sprintf("Fetching datastore '%s' in workspace '%s'", ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores/%s.xml", ws, ds),
        verbose = self$verbose.debug)
      dataStore <- NULL
      if(status_code(req) == 200){
        dsXML <- GSUtils$parseResponseXML(req)
        dsType <-  xml2::xml_find_first(dsXML, "//type") %>% xml2::xml_text()
        dataStore <- switch(dsType,
          "Shapefile" = GSShapefileDataStore$new(xml = dsXML),
          "Directory of spatial files (shapefiles)" = GSShapefileDirectoryDataStore$new(xml = dsXML),
          "GeoPackage" = GSGeoPackageDataStore$new(xml = dsXML),
          "PostGIS" = GSPostGISDataStore$new(xml = dsXML),
          "Oracle NG" = GSOracleNGDataStore$new(xml = dsXML),
          GSAbstractDataStore$new(xml = dsXML)
        )
        msg = "Successfully fetched datastore!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching datastore"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(dataStore)
    },
    
    #'@description Creates a datastore given a workspace and an object of class \code{\link{GSAbstractDataStore}}.
    #'@param ws workspace name
    #'@param dataStore datastore object of class \link{GSAbstractDataStore}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createDataStore = function(ws, dataStore){
      msg = sprintf("Creating datastore '%s' in workspace '%s'", dataStore$name, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
        msg = "Successfully created datastore!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while creating datastore"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
    },
    
    
    #'@description Updates a datastore given a workspace and an object of class \code{\link{GSAbstractDataStore}}.
    #'@param ws workspace name
    #'@param dataStore datastore object of class \link{GSAbstractDataStore}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateDataStore = function(ws, dataStore){
      updated <- FALSE
      msg = sprintf("Updating datastore '%s' in workspace '%s'", dataStore$name, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, 
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/datastores/%s.xml", ws, dataStore$name),
        content = GSUtils$getPayloadXML(dataStore),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfully updated datastore!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating datastore"
        cli::cli_alert_danger(err)
        self$ERROR(err)
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
      msg = sprintf("Deleting datastore '%s' in workspace '%s'", ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s.xml", ws, ds)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user, 
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfully deleted datastore!"
        cli::cli_alert_info(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting datastore"
        cli::cli_alert_danger(err)
        self$ERROR(err)
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
      msg = sprintf("Fetching featureTypes for datastore '%s' in workspace '%s'", ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      supportedListValues <- c("configured", "available", "available_with_geom", "all")
      if(!(list %in% supportedListValues)){
        err = sprintf("Unsupported 'list' parameter value '%s'. Possible values: [%s]",
                      list, paste0(supportedListValues, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores/%s/featuretypes.xml?list=%s", ws, ds, list),
        verbose = self$verbose.debug)
      ftList <- NULL
      if(status_code(req) == 200){
        ftXML <- GSUtils$parseResponseXML(req)
        ftXMLList <- as(xml2::xml_find_all(ftXML, "//featureTypes/featureType"), "list")
        ftList <- lapply(ftXMLList, GSFeatureType$new)
        msg = sprintf("Successfully fetched %s featureTypes!", length(ftList))
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching list of featureTypes"
        cli::cli_alert_danger(err)
        self$ERROR(err)
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
      msg = sprintf("Fetching featureType '%s' in datastore '%s' (workspace '%s')", ft, ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml", ws, ds, ft),
        verbose = self$verbose.debug)
      featureType <- NULL
      if(status_code(req) == 200){
        ftXML <- GSUtils$parseResponseXML(req)
        featureType <- GSFeatureType$new(xml = ftXML)
        msg = "Successfully fetched featureType!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching featureType"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(featureType)
    },
    
    #'@description Creates a new featureType given a workspace, datastore names and an object of class \code{\link{GSFeatureType}}
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param featureType feature type
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createFeatureType = function(ws, ds, featureType){
      msg = sprintf("Creating featureType '%s' in datastore '%s' (workspace '%s')", featureType$name, ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
        msg = "Successfully created featureType!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while creating featureType"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(created)
    },
    
    #'@description Updates a featureType given a workspace, datastore names and an object of class \code{\link{GSFeatureType}}
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param featureType feature type
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateFeatureType = function(ws, ds, featureType){
      msg = sprintf("Updating featureType '%s' in datastore '%s' (workspace '%s')", featureType$name, ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
        msg = "Successfully updated featureType!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating featureType"
        cli::cli_alert_danger(err)
        self$ERROR(err)
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
      msg = sprintf("Deleting featureType '%s' in datastore '%s' (workspace '%s')", ft, ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml", ws, ds, ft)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfuly deleted featureType!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting featureType"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)  
    },
    
    #Featuretype Layer publication methods
    #===========================================================================    
    #'@description Publish a feature type/layer pair given a workspace and datastore. The name 'layer' here 
    #'encompasses both \link{GSFeatureType} and \link{GSLayer} resources.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param featureType object of class \link{GSFeatureType}
    #'@param layer object of class \link{GSLayer}
    #'@return \code{TRUE} if published, \code{FALSE} otherwise
    publishLayer = function(ws, ds, featureType, layer){
      msg = sprintf("Publishing layer '%s'", layer$name)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      published <- FALSE
      if(featureType$name != layer$name){
        stop("FeatureType and Layer names differ!")
      }
      ftCreated <- self$createFeatureType(ws, ds, featureType)
      if(ftCreated){
        lyrCreated <- self$createLayer(layer)
        if(lyrCreated){
          published <- TRUE
          msg = "Successfully published layer!"
          cli::cli_alert_success(msg)
          self$INFO(msg)
        }else{
          #rolling back
          published <- FALSE
          msg = "Rolling back - deleting previously created FeatureType!"
          cli::cli_alert_warning(msg)
          self$WARN(msg)
          ftDeleted <- self$deleteFeatureType(ws, ds, featureType$name)
        }
      }
      if(!published){
        err = "Error while publishing layer"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(published)
    },
    
    #'@description Unpublish a feature type/layer pair given a workspace and datastore. The name 'layer' here 
    #'encompasses both \link{GSFeatureType} and \link{GSLayer} resources.
    #'@param ws workspace name
    #'@param ds datastore name
    #'@param lyr layer name
    #'@return \code{TRUE} if published, \code{FALSE} otherwise
    unpublishLayer = function(ws, ds, lyr){
      msg = sprintf("Unpublishing layer '%s'", lyr)
      cli::cli_alert_info(msg)
      self$INFO(msg)
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
            msg = "Successfully unpublished layer!"
            cli::cli_alert_success(msg)
            self$INFO(msg)
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
      msg = sprintf("Uploading %s data in datastore '%s' (workspace '%s')",
                    toupper(extension), ds, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      
      uploaded <- FALSE
      
      supportedEndpoints <- c("file","url","external")
      if(!(endpoint %in% supportedEndpoints)){
        err = sprintf("Unsupported endpoint '%s'. Possible values: [%s]",
                      endpoint, paste0(supportedEndpoints, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      supportedExtensions <- c("shp", "spatialite", "h2", "gpkg")
      if(!(extension %in% supportedExtensions)){
        err = sprintf("Unsupported extension '%s'. Possible values: [%s]",
                      extension, paste0(supportedExtensions, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      supportedConfigurations <- c("first", "none", "all")
      if(!(configure %in% supportedConfigurations)){
        err = sprintf("Unsupported configure parameter '%s'. Possible values: [%s]",
                      configure, paste0(supportedConfigurations, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      supportedUpdates <- c("append","overwrite")
      if(!(update %in% supportedUpdates)){
        err = sprintf("Unsupported update parameter '%s'. Possible values: [%s]",
                      update, paste0(supportedUpdates, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
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
        msg = "Successfull data upload!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        uploaded = TRUE
      }
      if(!uploaded){
        err = sprintf("Error while uploading data: %s", http_status(req)$message)
        cli::cli_alert_danger(err)
        self$ERROR(err)
        self$ERROR("Response headers -->")
        print(headers(req))
        self$ERROR("Response content -->")
        print(as(content(req), "character"))
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
                        contentType = "application/zip")
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
      contentType = ""
      if(endsWith(filename, ".zip")) contentType = "application/zip"
      return(
        self$uploadData(ws, ds, endpoint, extension = "gpkg",
                        configure, update, filename, charset,
                        contentType = contentType)
      )
    }
    
  )
                                                        
)
