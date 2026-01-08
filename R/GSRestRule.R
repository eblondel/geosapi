#' Geoserver REST API Access Control List REST Rule
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSRestRule
#' @title A GeoServer access control list service rule
#' @description This class models a GeoServer access control list service rule
#' @keywords geoserver rest api access control rule
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer access control list service rule
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSRestRule <- R6Class("GSRestRule",
   inherit = GSRule,
   
   public = list(
     
     #'@field roles one or more roles
     roles = list(),
     
     #'@description Initializes a \link{GSLayerRule}
     #'@param xml an object of class \link[xml2]{xml_node-class}
     #'@param pattern a URL Ant pattern, only applicable for domain \code{rest}. Default is \code{/**}
     #'@param methods HTTP method(s) 
     #'@param permission the rule permission, either \code{r} (read), \code{w} (write) or \code{a} (administer)
     #'@param roles one or more roles to add for the rule
     initialize = function(xml = NULL,
                           pattern, methods,
                           permission = c("r","w","a"),
                           roles){
       super$initialize(xml = xml, domain = "layers")
       permission = match.arg(permission)
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }else{
         pat = pattern
         if(is.null(pattern)) pat = "/**"
         res_str = sprintf("%s:%s", pat, paste0(methods, collapse = ","))
         self$attrs$resource = res_str
         self$roles = roles
       }
     }
   )                       
)
