#' Geoserver REST API Access Control List Service Rule
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSServiceRule
#' @title A GeoServer access control list service rule
#' @description This class models a GeoServer access control list service rule
#' @keywords geoserver rest api access control rule
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer access control list service rule
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSServiceRule <- R6Class("GSServiceRule",
   inherit = GSRule,
   
   public = list(
     
     #'@field roles one or more roles
     roles = list(),
     
     #'@description Initializes a \link{GSLayerRule}
     #'@param xml an object of class \link[xml2]{xml_node-class}
     #'@param service service subject to the access control rule, eg. 'wfs'
     #'@param method service method subject to the access control rule, eg. 'GetFeature'
     #'@param permission the rule permission, either \code{r} (read), \code{w} (write) or \code{a} (administer)
     #'@param roles one or more roles to add for the rule
     initialize = function(xml = NULL,
                           service, method,
                           permission = c("r","w","a"),
                           roles){
       super$initialize(xml = xml, domain = "layers")
       permission = match.arg(permission)
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }else{
         res_str = sprintf("%s.%s", service, method)
         self$attrs$resource = res_str
         self$roles = roles
       }
     }
   )                       
)
