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
#'   lyr <- GSStyle$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSStyle <- R6Class("GSStyle",
  inherit = GSRESTResource,
  
  public = list(
    #'@field full full
    full = TRUE,
    #'@field name name
    name = NULL,
    #'@field filename filename
    filename = NULL,
    
    #'@description Initializes a \link{GSStyle}
    #'@param xml an object of class \link{xml_node-class}
    #'@param name name
    #'@param filename filename
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
    
    #'@description Decodes from XML
    #'@param xml an object of class \link{xml_node-class}
    decode = function(xml){
      xml = xml2::as_xml_document(xml)
      self$setName(xml2::xml_find_first(xml) %>% xml2::xml_text())
      filenames <- xml2::xml_find_first(xml, "//filename")
      if(length(filenames)==0) self$full <- FALSE
      if(self$full){
        self$setFilename(xml2::xml_text(filenames))
      }
    },
    
    #'@description set name
    #'@param name name
    setName = function(name){
     self$name = name
    },
    
    #'@description Set filename
    #'@param filename filename
    setFilename = function(filename){
     self$filename = filename
    }
  )                       
)