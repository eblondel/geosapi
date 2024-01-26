#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSPublishable
#' @title A GeoServer layer group publishable
#' @description This class models a GeoServer layer. This class is to be
#' used internally by \pkg{geosapi} for configuring layers or layer groups
#' within an object of class \code{GSLayerGroup}
#' @keywords geoserver rest api resource layer group publishable
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer layer group publishable
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   publishable <- GSPublishable$new(name = "name", type = "layer")
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSPublishable <- R6Class("GSPublishable",
   inherit = GSRESTResource,
   
   public = list(
     #'@field full full
     full = TRUE,
     #'@field name name
     name = NULL,
     #'@field attr_type type of attribute
     attr_type = NULL,
     
     #'@description Initializes a \link{GSPublishable}
     #'@param xml an object of class \link{xml_node-class}
     #'@param name name
     #'@param type type
     initialize = function(xml = NULL, name, type){
       super$initialize(rootName = "published")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }else{
         if(!missing(name) & !missing(type)){
           self$setName(name)
           self$setType(type)
         }
       }
     },
     
     #'@description Decodes from XML
     #'@param xml an object of class \link{xml_node-class}
     decode = function(xml){
       xml = xml2::as_xml_document(xml)
       self$name <- xml2::xml_find_first(xml, "//name") %>% xml2::xml_text()
       self$attr_type <- xml2::xml_attr(xml, "type")
     },
     
     #'@description set name
     #'@param name name
     setName = function(name){
       self$name = name
     },
     
     #'@description Set type
     #'@param type type
     setType = function(type){
       self$attr_type = type
     }
     
   )                       
)