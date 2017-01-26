#' Geoserver REST API Metadatalink
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSMetadataLink
#' @title A GeoServer resource metadataLink
#' @description This class models a GeoServer resource metadataLink made of a type
#' (free text e.g. text/xml, text/html), a metadataType (Possible values are 
#' ISO19115:2003, FGDC, TC211, 19139, other), and a content: an URL that gives 
#' the metadataLink
#' @keywords geoserver rest api resource metadataLink
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer resource metadataLink
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' md <- GSMetadataLink$new(type, metadataType, content)
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, type, metadataType, content)}}{
#'    This method is used to instantiate a GSMetadataLink
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSMetadataLink from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSMetadataLink to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSMetadataLink <- R6Class("GSMetadataLink",
   inherit = GSRESTResource,
   
   public = list(
     type = NULL,
     metadataType = NULL,
     content = NULL,
     initialize = function(xml = NULL, type, metadataType, content){
       super$initialize(rootName = "metadataLink")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }else{
         self$setType(type)
         self$setMetadataType(metadataType)
         self$setContent(content)
       }
     },
     
     decode = function(xml){
        propsXML <- xmlChildren(xml)
        props <- lapply(propsXML, xmlValue)
        self$setType(props$type)
        self$setMetadataType(props$metadataType)
        self$setContent(props$content)
     },
     
     setType = function(type){
        self$type = type
     },
     
     setMetadataType = function(metadataType){
        supportedMetadataTypes <- c("ISO19115:2003", "FGDC", "TC211", "19139", "other")
        if(!(metadataType %in% supportedMetadataTypes)){
          err <- sprintf("Unknown metadataType '%s'. Supported values are: [%s]",
                         metadataType, paste0(supportedMetadataTypes, collapse=","))
          stop(err)
        }
        self$metadataType <- metadataType
     },
     
     setContent = function(content){
       self$content = content
     }
     
   )
                         
)