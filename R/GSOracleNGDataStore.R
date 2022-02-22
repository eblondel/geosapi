#' Geoserver REST API OracleNGDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore OracleNG
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer OracleNG dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   GSOracleNGDataStore$new(name = "ds", description = "des", enabled = TRUE)
#'
#' @section Methods inherited from \code{GSAbstractDBDataStore}:
#' \describe{
#'    \item{\code{setDatabaseType(dbtype)}}{
#'      Sets the database type, here "OracleNG"
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
#' @section Methods :
#' \describe{
#'    \item{\code{new(xml, name, description, enabled)}}{
#'      Instantiates a GSOracleNGDataStore object
#'    }
#'  }
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
      #'@param xml an object of class \link{XMLInternalNode-class} to create object from XML
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
