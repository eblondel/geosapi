#' Geoserver REST API Style
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSLayer
#' @title A GeoServer layer style
#' @description This class models a GeoServer style.
#' @keywords geoserver rest api resourcelayer style
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer style
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' lyr <- GSStyle$new()
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GS Style
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSStyle from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSStyle to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSStyle <- R6Class("GSStyle",
  inherit = GSRESTResource,
  
  public = list(
    full = TRUE,
    name = NULL,
    filename = NULL,
    
    initialize = function(xml = NULL, name = NULL, filename = NULL){
     super$initialize(rootName = "style")
     if(!missing(xml) & !is.null(xml)){
       self$decode(xml)
     }else{
       if(!missing(name) | !is.null(name)){
         self$setName(name)
       }
       if(!missing(filename) | !is.null(filename)){
         self$setFilename(filename)
       }
     }
    },
    
    decode = function(xml){
     names <- getNodeSet(xml, "//name")
     self$setName(xmlValue(names[[1]]))
     filenames <- getNodeSet(xml, "//filename")
     if(length(filenames)==0) self$full <- FALSE
     if(self$full){
       self$setFilename(xmlValue(filenames[[1]]))
       sldVersions
     }
    },
    
    setName = function(name){
     self$name = name
    },
    
    setFilename = function(filename){
     self$filename = filename
    }
  )                       
)