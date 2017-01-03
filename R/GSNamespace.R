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
#' GSNamespace$new(xml)
#'
#' @field xml
#' @field name
#' @field full
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSNamespace
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSNamespace from XML
#'  }
#'  \item{\code{encode(prefix, uri)}}{
#'    This method is used to encode a GSNamespace with a prefix and uri
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSNamespace <- R6Class("GSNamespace",
                       
  public = list(
    xml = NA,
    name = NA,
    prefix = NA,
    uri = NA,
    full = FALSE,
   
    initialize = function(xml){
      self$xml <- xml
      self$decode(xml)
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

GSNamespace$encode <- function(prefix, uri){
  nsXML <- newXMLNode("namespace")
  nsPrefix <- newXMLNode("prefix", prefix, parent = nsXML)
  nsUri <- newXMLNode("uri", uri, parent = nsXML)
  return(GSNamespace$new(nsXML))
}