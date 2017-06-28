#' Geoserver REST API ShapeFileDirectoryDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore ESRI shapefile directory
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer Shapefile directory dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSShapefileDirectoryDataStore$new(dataStore="ds", description = "des",
#'                          enabled = TRUE, url = "file://data")
#'
#' @section Methods:
#' \describe{
#'    \item{\code{new(xml, dataStore, description, enabled, url)}}{
#'      Instantiates a GSShapefileDirectoryDataStore object
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
GSShapefileDirectoryDataStore <- R6Class("GSShapefileDirectoryDataStore",
    inherit = GSShapefileDataStore,
    private = list(
      TYPE = "Directory of spatial files (shapefiles)"
    ),
    public = list(
      
      initialize = function(xml = NULL, dataStore = NULL, description = "",
                            enabled = TRUE, url){
        if(missing(xml)) xml <- NULL
        super$initialize(xml = xml, dataStore = dataStore,
                         description = description,
                         enabled = enabled, url = url)
        self$setType(private$TYPE)
      },
      
      setUrl = function(url){
        self$setConnectionParameter("url", url)
      },
      
      setCharset = function(charset = "ISO-8859-1"){
        self$setConnectionParameter("charset", charset)
      },
      
      setCreateSpatialIndex = function(create = TRUE){
        self$setConnectionParameter("create spatial index", create)
      },
      
      setMemoryMappedBuffer = function(buffer = FALSE){
        self$setConnectionParameter("memory mapped buffer", buffer)
      },
      
      setCacheReuseMemoryMaps = function(maps = TRUE){
        self$setConnectionParameter("cache and reuse memory maps", maps)
      },
      
      setDefautConnectionParameters = function(){
        self$setCharset()
        self$setCreateSpatialIndex()
        self$setMemoryMappedBuffer()
        self$setCacheReuseMemoryMaps()
      }
    )                     
)
