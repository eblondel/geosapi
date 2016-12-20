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
#' GSDataStoreManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(}}{
#'    This method is used to instantiate a GSDataStoreManager
#'  }
#'  \item{\code{getDataStores(workspace)}}{
#'    Get the list of available dataStores. Returns an object of class \code{xml_nodeset}
#'  }
#'  \item{\code{getDataStoreNames(workspace)}}{
#'    Get the list of available dataStore names. Returns an vector of class \code{character}
#'  }
#'  \item{\code{getDataStore(workspace, datastore)}}{
#'    Get an object of class \code{\link{GSDataStore}} given a workspace and datastore
#'    names.
#'  }
#'  \item{\code{uploadData(workspace, dataStore, endpoint, extension,
#'                         configure, update, filename, charset, contentType)}}{
#'    Uploads data to a target dataStore
#'  }
#'  \item{\code{uploadShapefile(workspace, dataStore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a zipped ESRIshapefile to a target dataStore
#'  }
#'  \item{\code{uploadProperties(workspace, dataStore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a properties file to a target dataStore
#'  }
#'  \item{\code{uploadH2(workspace, dataStore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a H2 database to a target dataStore
#'  }
#'  \item{\code{uploadSpatialite(workspace, dataStore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a Spatialite database to a target dataStore
#'  }
##'  \item{\code{uploadAppschema(workspace, dataStore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a appschema file to a target dataStore
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDataStoreManager <- R6Class("GSDataStoreManager",
  inherit = GSManager,
  
  public = list(   
      
    getDataStores = function(workspace){
      req <- self$GET(sprintf("/workspaces/%s/datastores.xml", workspace))
      dsXML <- content(req)
      dsList <- xml_find_all(dsXML, "//dataStore")
      return(dsList)
    },
    
    getDataStoreNames = function(workspace){
      dsList <- sapply(self$getDataStores(workspace), function(x){trimws(xml_text(x))})
      return(dsList)
    },
    
    getDataStore = function(workspace, datastore){
      req <- self$GET(sprintf("/workspaces/%s/datastores/%s.xml", workspace, datastore))
      dsXML <- content(req)
      return(GSDataStore$new(dsXML))
    },

    #Upload methods
    #===========================================================================
    
    #uploadData
    #---------------------------------------------------------------------------
    uploadData = function(workspace, dataStore, endpoint = "file", extension,
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
      
      req <- self$PUT(
        path = sprintf("/workspaces/%s/datastores/%s/%s.%s?configure=%s&update=%s",
                       workspace, dataStore, endpoint, extension, configure, update),
        filename = filename,
        contentType = contentType
      )
      if(status_code(req) == 201){
        uploaded = TRUE
      }
      return(uploaded)
    },
    
    #uploadShapefile
    #---------------------------------------------------------------------------
    uploadShapefile = function(workspace, dataStore, endpoint = "file",
                                configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, dataStore, endpoint, extension = "shp",
                        configure, update, filename, charset,
                        contentType = "application/zip")
      )
    },
    
    #uploadProperties (to test)
    #---------------------------------------------------------------------------
    uploadProperties = function(workspace, dataStore, endpoint = "file",
                               configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, dataStore, endpoint, extension = "properties",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #uploadH2 (to test)
    #---------------------------------------------------------------------------
    uploadH2 = function(workspace, dataStore, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, dataStore, endpoint, extension = "h2",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #uploadSpatialite (to test)
    #---------------------------------------------------------------------------
    uploadSpatialite = function(workspace, dataStore, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, dataStore, endpoint, extension = "spatialite",
                        configure, update, filename, charset,
                        contentType = "application/x-sqlite3")
      )
    },
    
    #uploadAppschema (to test)
    #---------------------------------------------------------------------------
    uploadAppschema = function(workspace, dataStore, endpoint = "file",
                                configure = "first", update = "append",
                                filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, dataStore, endpoint, extension = "appschema",
                        configure, update, filename, charset,
                        contentType = "application/appschema")
      )
    }
    
  )
                                                        
)