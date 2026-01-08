#' Geoserver REST API Access Control List Rule
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSRule
#' @title A GeoServer access control list rule
#' @description This class models a GeoServer access control list rule
#' @keywords geoserver rest api access control rule
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer access control list rule
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
#' @note Abstract class
#'
GSRule <- R6Class("GSRule",
 inherit = GSRESTResource,
 
 public = list(
   
   #'@description Initializes a \link{GSRule}
   #'@param xml an object of class \link[xml2]{xml_node-class}
   #'@param domain the access control domain
   initialize = function(xml = NULL, domain = c("layers", "services", "rest")){
     domain = match.arg(domain)
     super$initialize(rootName = "rule")
   },
   
   #'@description Encodes as XML
   #'@return an object of class \link[xml2]{xml_node-class}
   encode = function(){
     ruleXML = xml2::xml_new_root("rule")
     xml2::xml_attrs(ruleXML) = unlist(self$attrs)
     xml2::xml_text(ruleXML) = paste0(self$roles, collapse=",")
     return(ruleXML)
   },
   
   #'@description Decodes from XML
   #'@param xml an object of class \link[xml2]{xml_node-class}
   decode = function(xml){
     xml = xml2::as_xml_document(xml)
     self$attrs$resource = xml2::xml_attr(xml, "resource")
     self$roles = strsplit(xml2::xml_contents(xml) %>% as.character(), ",")
   }
 )                       
)
