#' Geoserver REST API ArcGridCoverageStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api CoverageStore ArcGrid
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer ArcGrid CoverageStore
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSArcGridCoverageStore <- R6Class("GSArcGridCoverageStore",
  inherit = GSAbstractCoverageStore,
  private = list(
    TYPE = "ArcGrid"
  ),
  public = list(
   #'@field url url
   url = NULL,
   
   #'@description initializes an abstract ArcGrid coverage store
   #'@param xml an object of class \link[xml2]{xml_node-class} to create object from XML
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
