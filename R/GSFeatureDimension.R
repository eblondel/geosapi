#' Geoserver REST API FeatureDimension
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSFeatureDimension
#' @title A GeoServer dimension
#' @description This class models a GeoServer feature dimension.
#' @keywords geoserver rest api resource dimension
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer feature dimension
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   dim <- GSFeatureDimension$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSFeatureDimension <- R6Class("GSFeatureDimension",
  inherit = GSDimension,
  
  public = list(
   #'@field attribute attribute
   attribute = NULL,
   #'@field endAttribute end attribute
   endAttribute = NULL,
   
   #'@description Initializes an object of class \link{GSFeatureDimension}
   #'@param xml object of class \link{XMLInternalNode-class}
   initialize = function(xml = NULL){
     super$initialize(xml)
     if(!missing(xml) & !is.null(xml)){
       self$decode(xml)
     }
   },
   
   #'@description Decodes from XML
   #'@param xml object of class \link{XMLInternalNode-class}
   decode = function(xml){
     super$decode(xml)
     propsXML <- xmlChildren(xml)
     props <- lapply(propsXML, xmlValue)
     self$setAttribute(props$attribute)
     self$setEndAttribute(props$endAttribute)
   },
   
   #'@description Set attribute
   #'@param attribute attribute
   setAttribute = function(attribute){
     self$attribute = attribute
   },
   
   #'@description Set end attribute
   #'@param endAttribute end attribute
   setEndAttribute = function(endAttribute){
     self$endAttribute = endAttribute
   }
   
  )
                       
)