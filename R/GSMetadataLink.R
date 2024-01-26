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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSMetadataLink <- R6Class("GSMetadataLink",
   inherit = GSRESTResource,
   
   public = list(
     #'@field type type
     type = NULL,
     #'@field metadataType metadata type
     metadataType = NULL,
     #'@field content content
     content = NULL,
     
     #'@description Initializes an object of class \link{GSMetadataLink}
     #'@param xml object of class \link{xml_node-class}
     #'@param type type
     #'@param metadataType metadata type
     #'@param content content
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
     
     #'@description Decodes from XML
     #'@param xml object of class \link{xml_node-class}
     decode = function(xml){
       xml = xml2::as_xml_document(xml)
        self$setType(xml2::xml_find_first(xml, "//type") %>% xml2::xml_text())
        self$setMetadataType(xml2::xml_find_first(xml, "//metadataType") %>% xml2::xml_text())
        self$setContent(xml2::xml_find_first(xml, "//content") %>% xml2::xml_text())
     },
     
     #'@description Set type type
     #'@param type type
     setType = function(type){
        self$type = type
     },
     
     #'@description Set metadata type
     #'@param metadataType metadata type. Supported values: "ISO19115:2003", "FGDC", "TC211", "19139", "other"
     setMetadataType = function(metadataType){
        supportedMetadataTypes <- c("ISO19115:2003", "FGDC", "TC211", "19139", "other")
        if(!(metadataType %in% supportedMetadataTypes)){
          err <- sprintf("Unknown metadataType '%s'. Supported values are: [%s]",
                         metadataType, paste0(supportedMetadataTypes, collapse=","))
          stop(err)
        }
        self$metadataType <- metadataType
     },
     
     #'@description Set content 
     #'@param content content
     setContent = function(content){
       self$content = content
     }
     
   )
                         
)