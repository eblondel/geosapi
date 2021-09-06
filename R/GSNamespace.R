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
#' @field name namespace name
#' @field prefix namespace prefix
#' @field uri namespace URI
#' @field full completeness of the namespace description
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, prefix, uri)}}{
#'    This method is used to instantiate a GSNamespace
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSNamespace from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSNamespace to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSNamespace <- R6Class("GSNamespace",
  inherit = GSRESTResource,                     
  public = list(
    name = NA,
    prefix = NA,
    uri = NA,
    full = FALSE,
   
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
