#' Geoserver REST API REST Resource interface
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer REST resource interface
#' @format \code{\link{R6Class}} object.
#' 
#'
#' @section Abstract Methods:
#' \describe{
#'  \item{\code{new()}}{
#'    This method is used to instantiate a GSRESTResource
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSDataStore from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSDataStore as XML
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSRESTResource <- R6Class("GSRESTResource",
                       
  public = list(
    decode = function(xml){
      stop("Unimplemented XML 'decode' method") 
    },
    encode = function(){
      stop("Unimplemented XML 'encode' method") 
    }
  )                     
)
