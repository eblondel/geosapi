#' Geoserver REST API Access Control List Layer Rule
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSLayerRule
#' @title A GeoServer access control list layer rule
#' @description This class models a GeoServer access control list layer rule
#' @keywords geoserver rest api access control rule
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer access control list layer rule
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSLayerRule <- R6Class("GSLayerRule",
  inherit = GSRule,
  
  public = list(
    
    #'@field roles one or more roles
    roles = list(),
    
    #'@description Initializes a \link{GSLayerRule}
    #'@param xml an object of class \link[xml2]{xml_node-class}
    #'@param ws the resource workspace. Default is \code{NULL}
    #'@param lyr the target layer to which the access control should be added
    #'@param permission the rule permission, either \code{r} (read), \code{w} (write) or \code{a} (administer)
    #'@param roles one or more roles to add for the rule
    initialize = function(xml = NULL,
                          ws = NULL, lyr,
                          permission = c("r","w","a"),
                          roles){
      super$initialize(xml = xml, domain = "layers")
      permission = match.arg(permission)
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }else{
        res_str = sprintf("%s.%s", lyr, permission)
        if(!is.null(ws)) res_str = sprintf("%s.%s", ws, res_str)
        self$attrs$resource = res_str
        self$roles = roles
      }
    }
  )                       
)
