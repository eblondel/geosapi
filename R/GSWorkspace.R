#' Geoserver REST API Workspace
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api workspace
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer workspace
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSWorkspace$new(xml)
#'
#' @field xml
#' @field name
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSWorkspace
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorkspace <- R6Class("GSWorkspace",
                       
  public = list(
    xml = NA,
    name = NA,
    
    initialize = function(xml){
     self$xml <- xml
     names <- xml_find_all(xml, "//name")
     self$name <- xml_text(names[1], trim = TRUE)
    }
   )                     
)