#' Geoserver REST API WorldImageCoverageStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api CoverageStore WorldImage
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer WorldImage CoverageStore
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorldImageCoverageStore <- R6Class("GSWorldImageCoverageStore",
  inherit = GSAbstractCoverageStore,
  private = list(
    TYPE = "WorldImage"
  ),
  public = list(
    #'@field url url
    url = NULL,
    
    #'@description Initializes an WorldImage coverage store
    #'@param xml an object of class \link{XMLInternalNode-class} to create object from XML
    #'@param name coverage store name
    #'@param description coverage store description
    #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
    #'@param url url
    initialize = function(xml = NULL, name = NULL, description = "", enabled = TRUE, url = NULL){
      super$initialize(xml = xml, type = private$TYPE, 
                       name = name, description = description, enabled = enabled, url = url)
    }
  )                     
)
