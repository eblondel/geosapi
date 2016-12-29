#' Geoserver REST API Namespace
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api namespace
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer namespace
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSNamespace$new(xml)
#'
#' @field xml
#' @field name
#' @field full
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSNamespace
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSNamespace <- R6Class("GSNamespace",
                       
  public = list(
    xml = NA,
    name = NA,
    prefix = NA,
    uri = NA,
    full = FALSE,
   
    initialize = function(xml){
      self$xml <- xml
      names <- xml_find_all(xml, "//name")
      if(length(names)>0){
        self$full <- FALSE
        self$name <- xml_text(names[1], trim = TRUE)
      }else{
        self$full <- TRUE
        self$prefix <- xml_text(xml_find_all(xml, "//prefix")[1], trim = TRUE)
        self$name <- self$prefix
        self$uri <- xml_text(xml_find_all(xml, "//uri")[1], trim = TRUE)
      }
    }
  )                     
)