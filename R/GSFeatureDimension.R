#' Geoserver REST API FeatureDimension
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSDimension
#' @title A GeoServer dimension
#' @description This class models a GeoServer feature dimension.
#' @keywords geoserver rest api resource dimension
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer feature dimension
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' dim <- GSFeatureDimension$new()
#'
#' @field attribute
#' @field endAttribute
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSResource
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSResource from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSFeatureType to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSFeatureDimension <- R6Class("GSFeatureDimension",
  inherit = GSDimension,
  
  public = list(
   attribute = NULL,
   endAttribute = NULL,
   initialize = function(xml = NULL){
     super$initialize(xml)
     if(!missing(xml) & !is.null(xml)){
       self$decode(xml)
     }
   },
   
   decode = function(xml){
     super$decode(xml)
     propsXML <- xmlChildren(xml)
     props <- lapply(propsXML, xmlValue)
     self$setAttribute(props$attribute)
     self$setEndAttribute(props$endAttribute)
   },
   
   setAttribute = function(attribute){
     self$attribute = attribute
   },
   
   setEndAttribute = function(endAttribute){
     self$endAttribute = endAttribute
   }
   
  )
                       
)