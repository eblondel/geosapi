#' Geoserver REST API Publishable
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSLayer
#' @title A GeoServer layer group publishable
#' @description This class models a GeoServer layer. This class is to be
#' used internally by \pkg{geosapi} for configuring layers or layer groups
#' within an object of class \code{GSLayerGroup}
#' @keywords geoserver rest api resource layer group publishable
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer layer group publishable
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' publishable <- GSPublishable$new(name = "name", type = "layer")
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(rootName, xml)}}{
#'    This method is used to instantiate a GSPublishable
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSPublishable
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSPublishable to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setName(name)}}{
#'    Sets the publishable name.
#'  }
#'  \item{\code{setType(type)}}{
#'    Sets the publishable type.
#'  }
#'}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSPublishable <- R6Class("GSPublishable",
   inherit = GSRESTResource,
   
   public = list(
     full = TRUE,
     name = NULL,
     attr_type = NULL,
     
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
     
     decode = function(xml){
       names <- getNodeSet(xml, "//name")
       self$name <- xmlValue(names[[1]])
       self$attr_type <- xmlGetAttr(xml, "type")[1]
     },
     
     setName = function(name){
       self$name = name
     },
     
     setType = function(type){
       self$attr_type = type
     }
     
   )                       
)