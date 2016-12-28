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
    enabled = FALSE,
    description = NA,
    type = NA,
    workspace = NA,
    connectionParameters = list(),
    featureTypes = list(),
    
    initialize = function(xml){
      self$xml <- xml
      names <- xml_find_all(xml, "//dataStore/name")
      self$name <- xml_text(names[1], trim = TRUE)
      self$full <- length(names) == 1
      if(self$full){
        self$enabled <- as.logical(xml_text(xml_find_all(xml,"//enabled")[1], trim = TRUE))
        self$workspace <- xml_text(xml_find_all(xml, "//workspace/name")[1], trim = TRUE)
        self$description <- xml_text(xml_find_all(xml,"//description")[1], trim = TRUE)
        
        typeXml <- xml_find_all(xml,"//type")
        if(length(typeXml) > 0) self$type <- xml_text(typeXml[1], trim = TRUE)
        
        paramsXML <- xml_find_all(xml,"//connectionParameters/entry")
        self$connectionParameters = lapply(paramsXML, function(x){
          param <- xml_text(x, trim = TRUE)
          if(param %in% c("true","false")){
            param <- as.logical(param)
          }
          return(param)
        })
        names(self$connectionParameters) = lapply(paramsXML, xml_attr, "key")
      }
    }
  )                     
)