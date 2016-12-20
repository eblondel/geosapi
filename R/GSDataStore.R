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
    name = NA,
    description = NA,
    type = NA,
    workspace = NA,
    connectionParameters = list(),
    featureTypes = list(),
    
    initialize = function(xml){
      names <- xml_find_all(xml, "//name")
      self$name <- xml_text(names[1], trim = TRUE)
      self$workspace <- xml_text(names[2], trim = TRUE)
      self$description <- xml_text(xml_find_all(xml,"//description")[1], trim = TRUE)
      self$type <- xml_text(xml_find_all(xml,"//type")[1], trim = TRUE)
      paramsXML <- xml_find_all(xml,"//connectionParameters/entry")
      self$connectionParameters = lapply(paramsXML, xml_text, trim = TRUE)
      names(self$connectionParameters) = lapply(paramsXML, xml_attr, "key")
    }
  )                     
)