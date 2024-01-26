#' Geoserver REST API Resource
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSFeatureType
#' @title A GeoServer feature type
#' @description This class models a GeoServer feature type. This class is to be
#' used for manipulating representations of vector data with GeoServer.
#' @keywords geoserver rest api resource featureType
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer feature type
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   ft <- GSFeatureType$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSFeatureType <- R6Class("GSFeatureType",
  inherit = GSResource,

  public = list(
    #'@field cqlFilter CQL filter
    cqlFilter = NULL,
    
    #'@description Initializes an object of class \link{GSFeatureType}
    #'@param xml object of class \link{xml_node-class}
    initialize = function(xml = NULL){
      super$initialize(rootName = "featureType")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
    
    #'@description Decodes from XML
    #'@param xml object of class \link{xml_node-class}
    decode = function(xml){
      super$decode(xml)
    },
    
    #'@description Set CQL filter
    #'@param cqlFilter CQL filter
    setCqlFilter = function(cqlFilter){
      self$cqlFilter <- cqlFilter
    },
    
    #'@description Set virtual table
    #'@param vt object of class \link{GSVirtualTable}
    #'@return \code{TRUE} if set/added, \code{FALSE} otherwise
    setVirtualTable = function(vt){
      if(!is(vt, "GSVirtualTable")){
        stop("Argument 'vt' should be an object of class 'GSVirtualTable'")
      }
      added <- super$setMetadata("JDBC_VIRTUAL_TABLE", vt)
      return(added)
    },
    
    #'@description Deletes virtual table
    #'@param vt object of class \link{GSVirtualTable}
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    delVirtualTable = function(){
      deleted <- super$delMetadata("JDBC_VIRTUAL_TABLE")
      return(deleted)
    }
  
  )
                    
)