#' Geoserver REST API DataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api DataStore
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer dataStore
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSDataStore$new(xml)
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
#'    This method is used to encode a GSDataStore as XML
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDataStore <- R6Class("GSDataStore",
  inherit = GSRESTResource,
  public = list(
    full = FALSE,
    name = NA,
    enabled = NA,
    description = NA,
    type = NA,
    connectionParameters = list(),
    
    initialize = function(xml = NULL,
                          dataStore, description, type,
                          enabled = TRUE, connectionParameters){
      if(!missing(xml) & !is.null(xml)){
        if(!any(class(xml) %in% c("XMLInternalNode","XMLInternalDocument"))){
          stop("The argument 'xml' is not a valid XML object")
        }
        self$decode(xml)
      }else{
        self$name = dataStore
        self$description = description
        self$type = type
        self$enabled = enabled
        self$connectionParameters = connectionParameters
        self$full <- TRUE
      }
    },
    
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
        
        paramsXML <- getNodeSet(xml,"//connectionParameters/entry")
        self$connectionParameters = lapply(paramsXML, function(x){
          param <- xmlValue(x)
          if(param %in% c("true","false")){
            param <- as.logical(param)
          }
          return(param)
        })
        names(self$connectionParameters) = lapply(paramsXML, xmlGetAttr, "key")
      }
    },
    
    encode = function(){
      dsXML <- newXMLNode("dataStore")
      dsName <- newXMLNode("name", self$dataStore, parent = dsXML)
      dsDesc <- newXMLNode("description", self$description, parent = dsXML)
      if(!is.na(self$type)) dsType <- newXMLNode("type", self$type, parent = dsXML)
      dsEnabled <- newXMLNode("enabled", tolower(as.character(self$enabled)), parent = dsXML)
      
      dsParams <- newXMLNode("connectionParameters", parent = dsXML)
      for(i in 1:length(self$connectionParameters)){
        paramName <- names(self$connectionParameters)[i]
        paramValue <- self$connectionParameters[[paramName]]
        if(is.logical(paramValue)){
          paramValue <- tolower(as.character(paramValue))
        }
        param <- newXMLNode("entry", attrs = c(key = paramName), paramValue, parent = dsParams)
      }
      
      return(dsXML)
    }
  )                     
)
