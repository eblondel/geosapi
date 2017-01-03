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
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSWorkspace from XML
#'  }
#'  \item{\code{encode(name)}}{
#'    This method is used to encode a GSWorkspace from name
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
      self$decode(xml)
    },
    
    decode = function(xml){
      names <- getNodeSet(xml, "//name")
      self$name <- xmlValue(names[[1]])
    }
    
  )                     
)

GSWorkspace$encode <- function(name){
  wsXML <- newXMLNode("workspace")
  wsName <- newXMLNode("name", name, parent = wsXML)
  return(GSWorkspace$new(wsXML))
}