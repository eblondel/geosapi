#' Geoserver REST API GSVirtualTableGeometry
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api virtualTable
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer virtual table geometry
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSVirtualTableGeometry$new(name = "work", type = "MultiPolygon", srid = 4326)
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVirtualTableGeometry <- R6Class("GSVirtualTableGeometry",
   inherit = GSRESTResource,                    
   public = list(
     #' @field name geometry name
     name = NA,
     #' @field type geometry type
     type = NA,
     #' @field srid geometry SRID
     srid = NA,
     
     #'@description Initializes an object of class \link{GSVirtualTableGeometry}
     #'@param xml object of class \link{xml_node-class}
     #'@param name name
     #'@param type type
     #'@param srid srid
     initialize = function(xml = NULL, name, type, srid){
       super$initialize(rootName = "geometry")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }else{
         self$name = name
         self$type = type
         self$srid = srid
       }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link{xml_node-class}
     decode = function(xml){
       xml = xml2::as_xml_document(xml)
       self$name <- xml2::xml_find_first(xml, "//name") %>% xml2::xml_text()
       self$type <- xml2::xml_find_first(xml, "//type") %>% xml2::xml_text()
       self$srid <- xml2::xml_find_first(xml, "//srid") %>% xml2::xml_text()
     }
     
   )                     
)