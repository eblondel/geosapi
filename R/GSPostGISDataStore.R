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
#' GSPostGISDataStore$new(dataStore="ds", description = "des", enabled = TRUE)
#'
#' @section Methods:
#' \describe{
#'    \item{\code{new(xml, dataStore, description, enabled)}}{
#'      Instantiates a GSPostGISDataStore object
#'    }
#'    \item{\code{setDatabaseType(dbtype)}}{
#'      Sets the database type, here "postgis"
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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSPostGISDataStore <- R6Class("GSPostGISDataStore",
    inherit = GSDataStore,
    private = list(
      TYPE = "PostGIS"
    ),
    public = list(
      
      initialize = function(xml = NULL, dataStore = NULL, description = "", enabled = TRUE){
        if(missing(xml)) xml <- NULL
        super$initialize(xml = xml, dataStore = dataStore,
                         description = description,
                         enabled = enabled)
        if(is.null(xml)){
          self$setDefautConnectionParameters()
        }
        self$setType(private$TYPE)
        self$setDatabaseType("postgis")
      },
      
      setDatabaseType = function(dbtype) {
        self$setConnectionParameter("dbtype", dbtype);
      },
      
      setNamespace = function(namespace) {
        self$setConnectionParameter("namespace", namespace);
      },
      
      setHost = function(host) {
        self$setConnectionParameter("host", host);
      },
      
      setPort = function(port) {
        self$setConnectionParameter("port", port);
      },
      
      setDatabase = function(database) {
        self$setConnectionParameter("database", database);
      },
      
      setSchema = function(schema) {
        self$setConnectionParameter("schema", schema);
      },
      
      setUser = function(user) {
        self$setConnectionParameter("user", user);
      },
      
      setPassword = function(password) {
        self$setConnectionParameter("passwd", password);
      },
      
      setJndiReferenceName = function(jndiReferenceName) {
        self$setConnectionParameter("jndiReferenceName", jndiReferenceName);
      },
      
      setExposePrimaryKeys = function(exposePrimaryKeys) {
        self$setConnectionParameter("Expose primary keys", exposePrimaryKeys);
      },
      
      setMaxConnections = function(maxConnections = 10) {
        self$setConnectionParameter("max connections", maxConnections);
      },
      
      setMinConnections = function(minConnections = 1) {
        self$setConnectionParameter("min connections", minConnections);
      },
      
      setFetchSize = function(fetchSize = 1000) {
        self$setConnectionParameter("fetch size", fetchSize);
      },
      
      setConnectionTimeout = function(seconds = 20) {
        self$setConnectionParameter("Connection timeout", seconds);
      },
      
      setValidateConnections = function(validateConnections) {
        self$setConnectionParameter("validate connections", validateConnections);
      },
      
      setPrimaryKeyMetadataTable = function(primaryKeyMetadataTable) {
        self$setConnectionParameter("Primary key metadata table", primaryKeyMetadataTable);
      },
      
      setLooseBBox = function(looseBBox = TRUE) {
        self$setConnectionParameter("Loose bbox", looseBBox);
      },
      
      setPreparedStatements = function(preparedStatements = FALSE) {
        self$setConnectionParameter("preparedStatements", preparedStatements);
      },
      
      setMaxOpenPreparedStatements = function(maxOpenPreparedStatements = 50) {
        self$setConnectionParameter("Max open prepared statements", maxOpenPreparedStatements);
      },
      
      setEstimatedExtends = function(estimatedExtends = FALSE){
        self$setConnectionParameter("Estimated extends", estimatedExtends);
      },
      
      setDefautConnectionParameters = function(){
        self$setMinConnections()
        self$setMaxConnections()
        self$setFetchSize()
        self$setConnectionTimeout()
        self$setLooseBBox()
        self$setPreparedStatements()
        self$setMaxOpenPreparedStatements()
        self$setEstimatedExtends()
      }
    )                     
)
