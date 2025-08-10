#' Geoserver REST API Namespace
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api namespace
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer namespace
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' GSNamespace$new(prefix = "my_ns", uri = "http://my_ns")
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSNamespace <- R6Class("GSNamespace",
  inherit = GSRESTResource,  
  public = list(
    #' @field name namespace name
    name = NA,
    #' @field prefix namespace prefix
    prefix = NA,
    #' @field uri namespace URI
    uri = NA,
    #' @field full completeness of the namespace description
    full = FALSE,
   
    #'@description Initializes an object of class \link{GSNamespace}
    #'@param xml object of class \link[xml2]{xml_node-class}
    #'@param prefix prefix
    #'@param uri uri
    initialize = function(xml = NULL, prefix, uri){
      super$initialize(rootName = "namespace")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }else{
        self$prefix <- prefix
        self$name <- prefix
        self$uri <- uri
        self$full <- TRUE
      }
    },
    
    #'@description Decodes from XML
    #'@param xml object of class \link[xml2]{xml_node-class}
    decode = function(xml){
      xml = xml2::as_xml_document(xml)
      names <- xml2::xml_find_first(xml, "//name")
      if(length(names)>0){
        self$full <- FALSE
        self$name <- xml2::xml_text(names)
      }else{
        self$full <- TRUE
        self$prefix <- xml2::xml_find_first(xml, "//prefix") %>% xml2::xml_text()
        self$name <- self$prefix
        self$uri <- xml2::xml_find_first(xml, "//uri") %>% xml2::xml_text()
      }
    }
  )                     
)
