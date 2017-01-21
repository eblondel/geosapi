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
#' \donttest{
#'    GSDataStoreManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'  }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(}}{
#'    This method is used to instantiate a GSDataStoreManager
#'  }
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
#'    Updates a new featureType given a workspace, datastore names and an object of
#'    class \code{\link{GSFeatureType}}
#'  }
#'  \item{\code{deleteFeatureType(ws, ds, featureType, recurse)}}{
#'    Deletes a featureType given a workspace, datastore names, and an object of 
#'    class \code{\link{GSFeatureType}}. By defaut, the option \code{recurse} is 
#'    set to FALSE, ie datastore layers are not removed.
#'  }
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
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
        sprintf("/workspaces/%s/datastores.xml", ws),
        self$verbose)
      dsList <- NULL
      if(status_code(req) == 200){
        dsXML <- GSUtils$parseResponseXML(req)
        dsXMLList <- getNodeSet(dsXML, "//dataStore")
        dsList <- lapply(dsXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSDataStore$new(xml = xml))
        })
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
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
        sprintf("/workspaces/%s/datastores/%s.xml", ws, ds),
        self$verbose)
      dataStore <- NULL
      if(status_code(req) == 200){
        dsXML <- GSUtils$parseResponseXML(req)
        dataStore <- GSDataStore$new(xml = dsXML)
      }
      return(dataStore)
    },
    
    #createDataStore
    #---------------------------------------------------------------------------
    createDataStore = function(ws, dataStore){
      created <- FALSE

      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$pwd,
        path = sprintf("/workspaces/%s/datastores.xml", ws),
        content = GSUtils$getPayloadXML(dataStore),
        contentType = "text/xml",
        verbose = self$verbose
      )
      if(status_code(req) == 201){
        created = TRUE
      }
    },
    
    #updateDataStore
    #---------------------------------------------------------------------------
    updateDataStore = function(ws, dataStore){
      stop("Not yet implemented")
    },
    
    #deleteDataStore
    #---------------------------------------------------------------------------
    deleteDataStore = function(ws, ds, recurse = FALSE){
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s.xml", ws, ds)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
                            path = path, self$verbose)
      if(status_code(req) == 200){
        deleted = TRUE
      }
      return(deleted)  
    },
    
    #DataStore featureType CRUD methods
    #===========================================================================
    
    #getFeatureTypes
    #---------------------------------------------------------------------------
    getFeatureTypes = function(ws, ds, list = "configured"){
      
      supportedListValues <- c("configured", "available", "available_with_geom", "all")
      if(!(list %in% supportedListValues)){
        stop(sprintf("Unsupported 'list' parameter value '%s'. Possible values: [%s]",
                     list, paste0(supportedListValues, collapse=",")))
      }
      
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
        sprintf("/workspaces/%s/datastores/%s/featuretypes.xml?list=%s", ws, ds, list),
        self$verbose)
      ftList <- NULL
      if(status_code(req) == 200){
        ftXML <- GSUtils$parseResponseXML(req)
        ftXMLList <- getNodeSet(ftXML, "//featureTypes/featureType")
        ftList <- lapply(ftXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSFeatureType$new(xml = xml))
        })
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
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
        sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml", ws, ds, ft),
        self$verbose)
      featureType <- NULL
      if(status_code(req) == 200){
        ftXML <- GSUtils$parseResponseXML(req)
        featureType <- GSFeatureType$new(xml = ftXML)
      }
      return(featureType)
    },
    
    #createFeatureType
    #---------------------------------------------------------------------------
    createFeatureType = function(ws, ds, featureType){
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$pwd,
        path = sprintf("/workspaces/%s/datastores/%s/featuretypes.xml", ws, ds),
        content = GSUtils$getPayloadXML(featureType),
        contentType = "text/xml",
        verbose = self$verbose
      )
      if(status_code(req) == 201){
        created = TRUE
      }
    },
    
    #createFeatureType
    #---------------------------------------------------------------------------
    updateFeatureType = function(ws, ds, featureType){
      stop("Not yet implemented")
    },
    
    #deleteLayer
    #---------------------------------------------------------------------------
    deleteLayer = function(ws, lyr){
      deleted <- FALSE
      path <- sprintf("/layers/%s.xml", lyr)
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
                            path = path, self$verbose)
      if(status_code(req) == 200){
        deleted = TRUE
      }
      return(deleted)
    },
    
    #deleteFeatureType
    #---------------------------------------------------------------------------
    deleteFeatureType = function(ws, ds, ft, recurse = FALSE){
      
      self$deleteLayer(ws, ft)
      
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/datastores/%s/featuretypes/%s.xml", ws, ds, ft)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
                            path = path, self$verbose)
      if(status_code(req) == 200){
        deleted = TRUE
      }
      return(deleted)  
    },
    
    #Upload methods
    #===========================================================================
    
    #uploadData
    #---------------------------------------------------------------------------
    uploadData = function(ws, ds, endpoint = "file", extension,
                          configure = "first", update = "append", filename,
                          charset, contentType){
      uploaded <- FALSE
      
      supportedEndpoints <- c("file","url","external")
      if(!(endpoint %in% supportedEndpoints)){
        stop(sprintf("Unsupported endpoint '%s'. Possible values: [%s]",
                     endpoint, paste0(supportedEndpoints, collapse=",")))
      }
      
      supportedExtensions <- c("shp")
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
        filename = filename,
        contentType = contentType,
        self$verbose
      )
      if(status_code(req) == 201){
        uploaded = TRUE
      }
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