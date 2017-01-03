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
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSDataStore
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSDataStore from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSDataStore
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDataStore <- R6Class("GSDataStore",

  public = list(
    xml = NA,
    full = FALSE,
    name = NA,
    enabled = NA,
    description = NA,
    type = NA,
    workspace = NA,
    connectionParameters = list(),
    featureTypes = list(),
    
    initialize = function(xml){
      self$xml <- xml
      self$decode(xml)
    },
    
    decode = function(xml){
      names <- getNodeSet(xml, "//dataStore/name")
      self$name <- xmlValue(names[[1]])
      enabled <- getNodeSet(xml,"//enabled")
      self$full <- length(length(enabled)) > 0
      if(self$full){
        self$enabled <- as.logical(xmlValue(enabled[[1]]))
        self$workspace <- xmlValue(getNodeSet(xml, "//workspace/name")[[1]])
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
    }
  )                     
)

GSDataStore$encode <- function(workspace, dataStore, description, type,
                               enabled = TRUE, connectionParameters){
  dsXML <- newXMLNode("dataStore")
  dsName <- newXMLNode("name", dataStore, parent = dsXML)
  dsDesc <- newXMLNode("description", description, parent = dsXML)
  dsType <- newXMLNode("type", type, parent = dsXML)
  dsEnabled <- newXMLNode("enabled", tolower(as.character(enabled)), parent = dsXML)
  dsWs <- newXMLNode("workspace", parent = dsXML)
  dsWsName <- newXMLNode("name", workspace, parent = dsWs)
  
  if(!missing(connectionParameters)){
    dsParams <- newXMLNode("connectionParameters", parent = dsXML)
    for(i in 1:length(connectionParameters)){
      paramName <- names(connectionParameters)[i]
      paramValue <- connectionParameters[[paramName]]
      param <- newXMLNode("entry", attrs = c(key = paramName), paramValue, parent = dsParams)
    }
  }
  
}