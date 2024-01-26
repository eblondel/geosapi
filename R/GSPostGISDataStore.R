#' Geoserver REST API PostGISDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore PostGIS
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer PostGIS dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   GSPostGISDataStore$new(name = "ds", description = "des", enabled = TRUE)
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSPostGISDataStore <- R6Class("GSPostGISDataStore",
    inherit = GSAbstractDBDataStore,
    private = list(
      TYPE = "PostGIS",
      DBTYPE = "postgis"
    ),
    public = list(
      
      #'@description initializes a PostGIS data store
      #'@param xml an object of class \link{xml_node-class} to create object from XML
      #'@param name coverage store name
      #'@param description coverage store description
      #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
      initialize = function(xml = NULL, name = NULL, description = "", enabled = TRUE){
        super$initialize(xml = xml, type = private$TYPE, dbType = private$DBTYPE,
                         name = name, description = description,
                         enabled = enabled)
      }
    )                     
)
