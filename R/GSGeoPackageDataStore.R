#' Geoserver REST API GeoPackageDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore GeoPackage
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer GeoPackage dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' ds <- GSGeoPackageDataStore$new(
#'  dataStore="ds", description = "des", 
#'  enabled = TRUE, database = NULL
#' )
#'
#'
#' @section Methods inherited from \code{GSAbstractDBDataStore}:
#' \describe{
#'    \item{\code{setDatabaseType(dbtype)}}{
#'      Sets the database type, here "geopkg
#'    }
#'    \item{\code{setNamespace(namespace)}}{
#'      Sets the datastore namespace
#'    }
#'    \item{\code{setHost(host)}}{
#'      Sets the database host
#'    }
#'    \item{\code{setPort(port)}}{
#'      Set the database port
#'    }
#'    \item{\code{setDatabase(database)}}{
#'      Set the database name
#'    }
#'    \item{\code{setSchema(schema)}}{
#'      Set the database schema
#'    }
#'    \item{\code{setUser(user)}}{
#'      Set the database username
#'    }
#'    \item{\code{setPassword(password)}}{
#'      Set the database password
#'    }
#'    \item{\code{setJndiReferenceName(jndiReferenceName)}}{
#'      Set a JNDI reference name
#'    }
#'    \item{\code{setExposePrimaryKeys(exposePrimaryKeys)}}{
#'      Set TRUE if primary keys have to be exposed to datastore, FALSE otherwise.
#'    }
#'    \item{\code{setMaxConnections(maxConnections)}}{
#'      Set the maximum number of connections. Default is set to 10.
#'    }
#'    \item{\code{setMinConnections(minConnections)}}{
#'      Set the minimum number of connections. Default is set to 1.
#'    }
#'    \item{\code{setFetchSize(fetchSize)}}{
#'      Set the fetch size. Default is set to 10.
#'    }
#'    \item{\code{setConnectionTimeout(seconds)}}{
#'      Set the connection timeout. Default is set to 20s.
#'    }
#'    \item{\code{setValidateConnections(validateConnections)}}{
#'      Set TRUE if connections have to be validated, FALSE otherwise.
#'    }
#'    \item{\code{setPrimaryKeyMetadataTable(primaryKeyMetadataTable)}}{
#'      Set the name of the primaryKey metadata table
#'    }
#'    \item{\code{setLooseBBox(looseBBox)}}{
#'      Set losse bbox parameter.
#'    }
#'    \item{\code{setPreparedStatements(preparedStatements)}}{
#'      Set prepared statements
#'    }
#'    \item{\code{setMaxOpenPreparedStatements(maxOpenPreparedStatements)}}{
#'      Set maximum open prepared statements
#'    }
#'    \item{\code{setEstimatedExtends(estimatedExtends)}}{
#'      Set estimatedExtend parameter
#'    }
#'    \item{\code{setDefautConnectionParameters()}}{
#'      Set default connection parameters
#'    }
#' }
#' 
#' @section Methods:
#' \describe{
#'    \item{\code{new(xml, dataStore, description, enabled, database)}}{
#'      Instantiates a GSGeoPackageDataStore object
#'    }
#' }
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
    initialize = function(xml = NULL, dataStore = NULL, 
                          description = "", enabled = TRUE,
                          database = NULL){
      super$initialize(xml = xml, type = private$TYPE, dbType = private$DBTYPE,
                       dataStore = dataStore, description = description,
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
