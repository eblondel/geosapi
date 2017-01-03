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
#' GSWorkspace$new(name = "work")
#'
#' @field name
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, name)}}{
#'    This method is used to instantiate a GSWorkspace
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSWorkspace from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSWorkspace to XML
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorkspace <- R6Class("GSWorkspace",
  inherit = GSRESTResource,                    
  public = list(
    name = NA,
    
    initialize = function(xml = NULL, name){
      
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }else{
        self$name = name
      }
    },
    
    decode = function(xml){
      names <- getNodeSet(xml, "//name")
      self$name <- xmlValue(names[[1]])
    },
    
    encode = function(){
      wsXML <- newXMLNode("workspace")
      wsName <- newXMLNode("name", self$name, parent = wsXML)
      return(wsXML)
    }   
    
  )                     
)