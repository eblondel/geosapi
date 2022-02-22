#' Geoserver REST API AbstractDBDataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore DB database
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer abstract DB dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @note Internal abstract class used for setting DB stores
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAbstractDBDataStore <- R6Class("GSAbstractDBDataStore",
    inherit = GSAbstractDataStore,
    public = list(
      
      #'@description initializes an abstract DB data store
      #'@param xml an object of class \link{XMLInternalNode-class} to create object from XML
      #'@param type the type of DB data store
      #'@param dbType DB type
      #'@param name coverage store name
      #'@param description coverage store description
      #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
      initialize = function(xml = NULL, type = NULL, dbType = NULL,
                            name = NULL, description = "", enabled = TRUE){
        if(missing(xml)) xml <- NULL
        super$initialize(xml = xml, name = name,
                         description = description,
                         enabled = enabled)
        if(is.null(xml)){
          self$setDefautConnectionParameters()
        }
        self$setType(type)
        self$setDatabaseType(dbType)
      },
      
      #'@description Set database type
      #'@param dbtype DB type
      setDatabaseType = function(dbtype) {
        self$setConnectionParameter("dbtype", dbtype);
      },
      
      #'@description Set namespace
      #'@param namespace namespace
      setNamespace = function(namespace) {
        self$setConnectionParameter("namespace", namespace);
      },
      
      #'@description Set host
      #'@param host host
      setHost = function(host) {
        self$setConnectionParameter("host", host);
      },
      
      #'@description Set port
      #'@param port port
      setPort = function(port) {
        self$setConnectionParameter("port", port);
      },
      
      #'@description Set database
      #'@param database database
      setDatabase = function(database) {
        self$setConnectionParameter("database", database);
      },
      
      #'@description Set schema
      #'@param schema schema
      setSchema = function(schema) {
        self$setConnectionParameter("schema", schema);
      },
      
      #'@description Set user
      #'@param user user
      setUser = function(user) {
        self$setConnectionParameter("user", user);
      },
      
      #'@description Set password
      #'@param password password
      setPassword = function(password) {
        self$setConnectionParameter("passwd", password);
      },
      
      #'@description Set JNDI reference name
      #'@param jndiReferenceName JNDI reference name
      setJndiReferenceName = function(jndiReferenceName) {
        self$setConnectionParameter("jndiReferenceName", jndiReferenceName);
      },
      
      #'@description Set expose primary keyws
      #'@param exposePrimaryKeys expose primary keys
      setExposePrimaryKeys = function(exposePrimaryKeys) {
        self$setConnectionParameter("Expose primary keys", exposePrimaryKeys);
      },
      
      #'@description Set min connections
      #'@param minConnections min connections. Default is 11
      setMinConnections = function(minConnections = 1) {
        self$setConnectionParameter("min connections", minConnections);
      },
      
      #'@description Set max connections
      #'@param maxConnections max connections. Default is 10
      setMaxConnections = function(maxConnections = 10) {
        self$setConnectionParameter("max connections", maxConnections);
      },
      
      #'@description Set fetch size
      #'@param fetchSize fetch size. Default is 1000
      setFetchSize = function(fetchSize = 1000) {
        self$setConnectionParameter("fetch size", fetchSize);
      },
      
      #'@description Set connection timeout
      #'@param seconds timeout (in seconds). Default is 20
      setConnectionTimeout = function(seconds = 20) {
        self$setConnectionParameter("Connection timeout", seconds);
      },
      
      #'@description Set validate connection
      #'@param validateConnections Validate connections
      setValidateConnections = function(validateConnections) {
        self$setConnectionParameter("validate connections", validateConnections);
      },
      
      #'@description Set primary key metadata table
      #'@param primaryKeyMetadataTable primary key metadata table
      setPrimaryKeyMetadataTable = function(primaryKeyMetadataTable) {
        self$setConnectionParameter("Primary key metadata table", primaryKeyMetadataTable);
      },
      
      #'@description Set loose bbox
      #'@param looseBBox loose bbox. Default is \code{TRUE}
      setLooseBBox = function(looseBBox = TRUE) {
        self$setConnectionParameter("Loose bbox", looseBBox);
      },
      
      #'@description Set prepared statemnts
      #'@param preparedStatements prepared Statements. Default is \code{FALSE}
      setPreparedStatements = function(preparedStatements = FALSE) {
        self$setConnectionParameter("preparedStatements", preparedStatements);
      },
      
      #'@description Set max open prepared statements
      #'@param maxOpenPreparedStatements max open preepared statements. Default is 50
      setMaxOpenPreparedStatements = function(maxOpenPreparedStatements = 50) {
        self$setConnectionParameter("Max open prepared statements", maxOpenPreparedStatements);
      },
      
      #'@description Set estimatedExtends
      #'@param estimatedExtends estimated extends. Default is \code{FALSE}
      setEstimatedExtends = function(estimatedExtends = FALSE){
        self$setConnectionParameter("Estimated extends", estimatedExtends);
      },
      
      #'@description Set default connection parameters
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
