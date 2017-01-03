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
#'    This method is used to instantiate a GSDataStoreManager
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