#' Geoserver REST API DataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer dataStore
#' @format \code{\link{R6Class}} object.
#'
#' @field connectionParameters connection parameters
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, type, name, description, enabled, connectionParameters)}}{
#'    This method is used to instantiate a \code{GSAbstractDataStore}
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSAbstractDataStore} from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSAbstractDataStore} to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setConnectionParameters(parameters)}}{
#'    Sets the datastore connection parameters. The argument should be an object
#'    of class \code{GSRESTEntrySet} giving a list of key/value parameter entries.
#'  }
#'  \item{\code{addConnectionParameter(key, value)}}{
#'    Adds a datastore connection parameter. Convenience wrapper of \code{GSRESTEntrySet} 
#'    \code{addEntry} method.
#'  }
#'  \item{\code{setConnectionParameter(key, value)}}{
#'    Sets a datastore connection parameter. Convenience wrapper of \code{GSRESTEntrySet} 
#'    \code{setEntry} method.
#'  }
#'  \item{\code{delConnectionParameter(key)}}{
#'    Deletes a datastore connection parameter. Convenience wrapper of \code{GSRESTEntrySet} 
#'    \code{delEntry} method.
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAbstractDataStore <- R6Class("GSAbstractDataStore",
  inherit = GSAbstractStore,
  private = list(
    STORE_TYPE = "dataStore"
  ),
  public = list(
    connectionParameters = NULL,
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
    
    #decode
    #---------------------------------------------------------------------------
    decode = function(xml){
      super$decode(xml)
      self$connectionParameters = GSRESTEntrySet$new(rootName = "connectionParameters", xml)
    },
    
    #setConnectionParameters
    #---------------------------------------------------------------------------
    setConnectionParameters = function(parameters){
      self$connectionParameters = parameters
    },
    
    #addConnectionParameter
    #---------------------------------------------------------------------------
    addConnectionParameter = function(key, value){
      added <- self$connectionParameters$addEntry(key, value)
      return(added)
    },
    
    #setConnectionParameter
    #---------------------------------------------------------------------------
    setConnectionParameter = function(key, value){
      self$connectionParameters$setEntry(key, value)
    },
    
    #delConnectionParameter
    #---------------------------------------------------------------------------
    delConnectionParameter = function(key){
      deleted <- self$connectionParameters$delEntry(key)
      return(deleted)
    }
  )                     
)
