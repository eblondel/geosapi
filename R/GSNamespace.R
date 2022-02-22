#' Geoserver REST API Namespace
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api namespace
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer namespace
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSNamespace$new(prefix = "prefix", uri = "http://prefix")
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
    #'@param xml object of class \link{XMLInternalNode-class}
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
    #'@param xml object of class \link{XMLInternalNode-class}
    decode = function(xml){
      names <- getNodeSet(xml, "//name")
      if(length(names)>0){
        self$full <- FALSE
        self$name <- xmlValue(names[[1]])
      }else{
        self$full <- TRUE
        self$prefix <- xmlValue(getNodeSet(xml, "//prefix")[[1]])
        self$name <- self$prefix
        self$uri <- xmlValue(getNodeSet(xml, "//uri")[[1]])
      }
    }
  )                     
)
