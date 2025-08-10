#' Geoserver REST API OracleNGDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore OracleNG
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer OracleNG dataStore
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#'   GSOracleNGDataStore$new(name = "ds", description = "des", enabled = TRUE)
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSOracleNGDataStore <- R6Class("GSOracleNGDataStore",
    inherit = GSAbstractDBDataStore,
    private = list(
      TYPE = "Oracle NG",
      DBTYPE = "oracle"
    ),
    public = list(
      
      #'@description initializes an Oracle NG data store
      #'@param xml an object of class \link[xml2]{xml_node-class} to create object from XML
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
