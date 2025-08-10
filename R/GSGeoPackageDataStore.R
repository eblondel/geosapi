#' Geoserver REST API GeoPackageDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore GeoPackage
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer GeoPackage dataStore
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' ds <- GSGeoPackageDataStore$new(
#'  name = "ds", description = "des", 
#'  enabled = TRUE, database = NULL
#' )
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSGeoPackageDataStore <- R6Class("GSGeoPackageDataStore",
  inherit = GSAbstractDBDataStore,
  private = list(
    TYPE = "GeoPackage",
    DBTYPE = "geopkg"
  ),
  public = list(
    
    #'@description initializes an GeoPackage data store
    #'@param xml an object of class \link[xml2]{xml_node-class} to create object from XML
    #'@param name coverage store name
    #'@param description coverage store description
    #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
    #'@param database database
    initialize = function(xml = NULL, name = NULL, 
                          description = "", enabled = TRUE,
                          database = NULL){
      super$initialize(xml = xml, type = private$TYPE, dbType = private$DBTYPE,
                       name = name, description = description,
                       enabled = enabled)
      if(!is.null(database)) super$setDatabase(database)
      super$setMinConnections(NULL)
      super$setMaxConnections(NULL)
      super$setConnectionTimeout(NULL)
      super$setFetchSize(NULL)
      super$setLooseBBox(NULL)
      super$setPreparedStatements(NULL)
      super$setMaxOpenPreparedStatements(NULL)
      super$setEstimatedExtends(NULL)
    }
   )                     
)
