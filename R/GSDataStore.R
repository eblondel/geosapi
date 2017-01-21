#' Geoserver REST API DataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer dataStore
#' @format \code{\link{R6Class}} object.
#'
#' @field name
#' @field workspace
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, dataStore, description, type, enabled, connectionParameters)}}{
#'    This method is used to instantiate a GSDataStore
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSDataStore from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSNamespace to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setEnabled(enabled)}}{
#'    Sets the datastore as enabled if TRUE, disabled if FALSE
#'  }
#'  \item{\code{setDescription(description)}}{
#'    Sets the datastore description
#'  }
#'  \item{\code{setType(type)}}{
#'    Sets the datastore type
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
GSDataStore <- R6Class("GSDataStore",
  inherit = GSRESTResource,
  public = list(
    full = FALSE,
    name = NULL,
    enabled = NULL,
    description = "",
    type = NULL,
    connectionParameters = NULL,
    
    initialize = function(xml = NULL,
                          dataStore = NULL, description = "", type = NULL,
                          enabled = TRUE, connectionParameters){
      super$initialize(rootName = "dataStore")
      if(!missing(xml) & !is.null(xml)){
        if(!any(class(xml) %in% c("XMLInternalNode","XMLInternalDocument"))){
          stop("The argument 'xml' is not a valid XML object")
        }
        self$decode(xml)
      }else{
        
        if(is.null(dataStore)) stop("dataStore cannot be null")
        
        self$name = dataStore
        self$description = description
        self$type = type
        self$enabled = enabled
        self$connectionParameters = GSRESTEntrySet$new(rootName = "connectionParameters")
        if(!missing(connectionParameters)){
          if(!is.list(connectionParameters)) stop("Connection parameters should be provided as named list")
          self$connectionParameters$setEntryset(connectionParameters)
        }
        self$full <- TRUE
      }
    },
    
    #decode
    #---------------------------------------------------------------------------
    decode = function(xml){
      names <- getNodeSet(xml, "//dataStore/name")
      self$name <- xmlValue(names[[1]])
      enabled <- getNodeSet(xml,"//enabled")
      self$full <- length(enabled) > 0
      if(self$full){
        self$enabled <- as.logical(xmlValue(enabled[[1]]))
        self$description <- xmlValue(getNodeSet(xml,"//description")[[1]])
        
        typeXML <- getNodeSet(xml,"//type")
        if(length(typeXML) > 0) self$type <- xmlValue(typeXML[[1]])
      
        self$connectionParameters = GSRESTEntrySet$new(rootName = "connectionParameters", xml)
      }
    },
    
    #setEnabled
    #---------------------------------------------------------------------------
    setEnabled = function(enabled){
      self$enabled <- enabled
    },
    
    #setDescription
    #---------------------------------------------------------------------------
    setDescription = function(description){
      self$description = description
    },
    
    #setType
    #---------------------------------------------------------------------------
    setType = function(type){
      self$type = type
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
