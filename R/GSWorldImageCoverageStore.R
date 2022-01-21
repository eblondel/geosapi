#' Geoserver REST API WorldImageCoverageStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api CoverageStore WorldImage
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer WorldImage CoverageStore
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, name, description, enabled, url)}}{
#'    This method is used to instantiate a \code{GSWorldImageCoverageStore}
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorldImageCoverageStore <- R6Class("GSWorldImageCoverageStore",
  inherit = GSAbstractCoverageStore,
  private = list(
    TYPE = "WorldImage"
  ),
  public = list(
    url = NULL,
    initialize = function(xml = NULL, name = NULL, description = "", enabled = TRUE, url = NULL){
      super$initialize(xml = xml, type = private$TYPE, 
                       name = name, description = description, enabled = enabled, url = url)
    }
  )                     
)
