#' Geoserver REST API Datastore Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api datastore
#' @return Object of \code{\link{R6Class}} with methods for managing GeoServer
#' datastores (i.e. stores of vector data)
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSDatastoreManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(}}{
#'    This method is used to instantiate a GSDatastoreManager
#'  }
#'  \item{\code{uploadData(workspace, datastore, endpoint, extension,
#'                         configure, update, filename, charset, contentType)}}{
#'    Uploads data to a target datastore
#'  }
#'  \item{\code{uploadShapefile(workspace, datastore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a zipped ESRIshapefile to a target datastore
#'  }
#'  \item{\code{uploadProperties(workspace, datastore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a properties file to a target datastore
#'  }
#'  \item{\code{uploadH2(workspace, datastore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a H2 database to a target datastore
#'  }
#'  \item{\code{uploadSpatialite(workspace, datastore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a Spatialite database to a target datastore
#'  }
##'  \item{\code{uploadAppschema(workspace, datastore, endpoint,
#'                              configure, update, filename, charset)}}{
#'    Uploads a appschema file to a target datastore
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDatastoreManager <- R6Class("GSDatastoreManager",
  inherit = GSManager,
  
  public = list(
    
    #Upload methods
    #===========================================================================
    
    #uploadData
    #---------------------------------------------------------------------------
    uploadData = function(workspace, datastore, endpoint = "file", extension,
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
                       workspace, datastore, endpoint, extension, configure, update),
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
    uploadShapefile = function(workspace, datastore, endpoint = "file",
                                configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, datastore, endpoint, extension = "shp",
                        configure, update, filename, charset,
                        contentType = "application/zip")
      )
    },
    
    #uploadProperties (to test)
    #---------------------------------------------------------------------------
    uploadProperties = function(workspace, datastore, endpoint = "file",
                               configure = "first", update = "append",
                               filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, datastore, endpoint, extension = "properties",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #uploadH2 (to test)
    #---------------------------------------------------------------------------
    uploadH2 = function(workspace, datastore, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, datastore, endpoint, extension = "h2",
                        configure, update, filename, charset,
                        contentType = "")
      )
    },
    
    #uploadSpatialite (to test)
    #---------------------------------------------------------------------------
    uploadSpatialite = function(workspace, datastore, endpoint = "file",
                        configure = "first", update = "append",
                        filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, datastore, endpoint, extension = "spatialite",
                        configure, update, filename, charset,
                        contentType = "application/x-sqlite3")
      )
    },
    
    #uploadAppschema (to test)
    #---------------------------------------------------------------------------
    uploadAppschema = function(workspace, datastore, endpoint = "file",
                                configure = "first", update = "append",
                                filename, charset = "UTF-8"){
      return(
        self$uploadData(workspace, datastore, endpoint, extension = "appschema",
                        configure, update, filename, charset,
                        contentType = "application/appschema")
      )
    }
    
  )
                                                        
)