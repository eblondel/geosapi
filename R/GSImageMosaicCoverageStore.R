#' Geoserver REST API ImageMosaicCoverageStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api CoverageStore ImageMosaic
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer ImageMosaic CoverageStore
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, name, description, enabled, url)}}{
#'    This method is used to instantiate a \code{GSImageMosaicCoverageStore}
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSImageMosaicCoverageStore <- R6Class("GSImageMosaicCoverageStore",
   inherit = GSAbstractCoverageStore,
   private = list(
     TYPE = "ImageMosaic"
   ),
   public = list(
     url = NULL,
     initialize = function(xml = NULL, name = NULL, description = "", enabled = TRUE, url){
       super$initialize(xml = xml, type = private$TYPE, 
                        name = name, description = description, enabled = enabled, url = url)
     }
   )                     
)
