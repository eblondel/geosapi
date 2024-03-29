#' Geoserver REST API Workspace
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api workspace
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer workspace
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   GSWorkspace$new(name = "work")
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorkspace <- R6Class("GSWorkspace",
  inherit = GSRESTResource,                    
  public = list(
    #'@field name name
    name = NA,
    
    #'@description initializes a \link{GSWorkspace}
    #'@param xml an object of class \link{xml_node-class}
    #'@param name name
    initialize = function(xml = NULL, name){
      super$initialize(rootName = "workspace")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }else{
        self$name = name
      }
    },
    
    #'@description Decodes from XML
    #'@param xml an object of class \link{xml_node-class}
    decode = function(xml){
      xml = xml2::as_xml_document(xml)
      self$name <- xml2::xml_child(xml) %>% xml2::xml_text()
    }
    
  )                     
)