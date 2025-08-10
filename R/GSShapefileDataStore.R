#' Geoserver REST API ShapeFileDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore ESRI shapefile
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer Shapefile dataStore
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' GSShapefileDataStore$new(name = "ds", description = "des",
#'                          enabled = TRUE, url = "file://data/shape.shp")
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSShapefileDataStore <- R6Class("GSShapefileDataStore",
 inherit = GSAbstractDataStore,
 private = list(
   TYPE = "Shapefile"
 ),
 public = list(
    
    #'@description initializes a shapefile data store
    #'@param xml an object of class \link[xml2]{xml_node-class} to create object from XML
    #'@param name coverage store name
    #'@param description coverage store description
    #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
    #'@param url url
   initialize = function(xml = NULL, name = NULL, description = "",
                         enabled = TRUE, url){
     if(missing(xml)) xml <- NULL
     super$initialize(xml = xml, name = name,
                      description = description,
                      enabled = enabled)
     if(is.null(xml)){
      self$setUrl(url)
      self$setDefautConnectionParameters()
     }
     self$setType(private$TYPE)
   },
   
   #'@description Set the spatial files data URL
   #'@param url url
   setUrl = function(url){
     self$setConnectionParameter("url", url)
   },
   
   #'@description Set the charset used for DBF file. 
   #'@param charset charset. Default value is 'ISO-8859-1'
   setCharset = function(charset = "ISO-8859-1"){
     self$setConnectionParameter("charset", charset)
   },
   
   #'@description Set the 'Create Spatial Index' option
   #'@param create create. Default is \code{TRUE}
   setCreateSpatialIndex = function(create = TRUE){
     self$setConnectionParameter("create spatial index", create)
   },
   
   #'@description Set the 'Memory Mapped Buffer' option
   #'@param buffer buffer. Default is \code{FALSE}
   setMemoryMappedBuffer = function(buffer = FALSE){
     self$setConnectionParameter("memory mapped buffer", buffer)
   },
   
   #'@description Set the 'Cache & Reuse Memory Maps' option.
   #'@param maps maps. Default is \code{TRUE}
   setCacheReuseMemoryMaps = function(maps = TRUE){
     self$setConnectionParameter("cache and reuse memory maps", maps)
   },
   
   #'@description Set default connection parameters
   setDefautConnectionParameters = function(){
     self$setCharset()
     self$setCreateSpatialIndex()
     self$setMemoryMappedBuffer()
     self$setCacheReuseMemoryMaps()
   }
 )                     
)
