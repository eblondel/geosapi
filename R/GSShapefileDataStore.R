#' Geoserver REST API ShapeFileDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore ESRI shapefile
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer Shapefile dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSShapefileDataStore$new(dataStore="ds", description = "des", type="",
#'                          enabled = TRUE, url = "file://data/shape.shp")
#'
#' @section Methods:
#' \describe{
#'    \item{\code{new(xml, dataStore, description, type, enabled, url)}}{
#'      Instantiates a GSShapefileDataStore object
#'    }
#'    \item{\code{setUrl(url)}}{
#'      Set the spatial files data URL
#'    }
#'    \item{\code{setCharset(charset)}}{
#'      Set the charset used for DBF file. Default value is 'ISO-8859-1'
#'    }
#'    \item{\code{setCreateSpatialIndex(create)}}{
#'      Set the 'Create Spatial Index' option. Default is TRUE
#'    }
#'    \item{\code{setMemoryMappedBuffer(buffer)}}{
#'      Set the 'Memory Mapped Buffer' option. Default is TRUE
#'    }
#'    \item{\code{CacheReuseMemoryMaps(maps)}}{
#'      Set the 'Cache & Reuse Memory Maps' option. Default is TRUE
#'    }
#'    \item{\code{setDefautConnectionParameters()}}{
#'      Set the defaut connection paramaters
#'    }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSShapefileDataStore <- R6Class("GSShapefileDataStore",
 inherit = GSDataStore,              
 public = list(
   
   initialize = function(xml, dataStore, description, type, enabled = TRUE, url){
     if(missing(xml)) xml <- NULL
     super$initialize(xml, dataStore, description, type, enabled, list())
     self$setDefautConnectionParameters()
     self$setUrl(url)
   },
   
   setUrl = function(url){
     self$connectionParameters[["url"]] <- url
   },
   
   setCharset = function(charset = "ISO-8859-1"){
     self$connectionParameters[["charset"]] <- charset
   },
   
   setCreateSpatialIndex = function(create = TRUE){
     self$connectionParameters[["create spatial index"]] <- create
   },
   
   setMemoryMappedBuffer = function(buffer = FALSE){
     self$connectionParameters[["memory mapped buffer"]] <- buffer
   },
   
   setCacheReuseMemoryMaps = function(maps = TRUE){
     self$connectionParameters[["cache and reuse memory maps"]] <- maps
   },
   
   setDefautConnectionParameters = function(){
     self$setCharset()
     self$setCreateSpatialIndex()
     self$setMemoryMappedBuffer()
     self$setCacheReuseMemoryMaps()
   }
 )                     
)
