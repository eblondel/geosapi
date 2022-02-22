#' Geoserver REST API DataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAbstractDataStore <- R6Class("GSAbstractDataStore",
  inherit = GSAbstractStore,
  private = list(
    STORE_TYPE = "dataStore"
  ),
  public = list(
    #'@field connectionParameters the list of connection parameters
    connectionParameters = NULL,
    
    #'@description initializes an abstract data store
    #'@param xml an object of class \link{XMLInternalNode-class} to create object from XML
    #'@param type the type of coverage store
    #'@param name coverage store name
    #'@param description coverage store description
    #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
    #'@param connectionParameters the list of connection parameters
    initialize = function(xml = NULL, type = NULL,
                          name = NULL, description = "", enabled = TRUE, 
                          connectionParameters){
      super$initialize(xml = xml, storeType = private$STORE_TYPE, type = type, 
                       name = name, description = description, enabled = enabled)
      if(!missing(xml) & !is.null(xml)){
        if(!any(class(xml) %in% c("XMLInternalNode","XMLInternalDocument"))){
          stop("The argument 'xml' is not a valid XML object")
        }
        self$decode(xml)
      }else{
        self$connectionParameters = GSRESTEntrySet$new(rootName = "connectionParameters")
        if(!missing(connectionParameters)){
          if(!is.list(connectionParameters)) stop("Connection parameters should be provided as named list")
          self$connectionParameters$setEntryset(connectionParameters)
        }
      }
    },
    
    #'@description Decodes a data store from XML
    #'@param xml an object of class \link{XMLInternalNode-class}
    #'@return an object of class \link{GSAbstractDataStore}
    decode = function(xml){
      super$decode(xml)
      self$connectionParameters = GSRESTEntrySet$new(rootName = "connectionParameters", xml)
    },
    
    #'@description Set list connection parameters. The argument should be an object
    #'    of class \code{GSRESTEntrySet} giving a list of key/value parameter entries.
    #'@param parameters an object of class \link{GSRESTEntrySet}
    setConnectionParameters = function(parameters){
      self$connectionParameters = parameters
    },
    
    #'@description Adds a connection parameter
    #'@param key connection parameter key
    #'@param value connection parameter value
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
    addConnectionParameter = function(key, value){
      added <- self$connectionParameters$addEntry(key, value)
      return(added)
    },
    
    #'@description Sets a connection parameter
    #'@param key connection parameter key
    #'@param value connection parameter value
    setConnectionParameter = function(key, value){
      self$connectionParameters$setEntry(key, value)
    },
    
    #'@description Removes a connection parameter
    #'@param key connection parameter key
    #'@param value connection parameter value
    #'@return \code{TRUE} if removed, \code{FALSE} otherwise
    delConnectionParameter = function(key){
      deleted <- self$connectionParameters$delEntry(key)
      return(deleted)
    }
  )                     
)
