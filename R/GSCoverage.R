#' Geoserver REST API Resource
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSCoverage
#' @title A GeoServer coverage
#' @description This class models a GeoServer coverage. This class is to be
#' used for manipulating representations of vector data with GeoServer.
#' @keywords geoserver rest api resource coverageType
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer coverage
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' gt <- GSCoverage$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSCoverage <- R6Class("GSCoverage",
   inherit = GSResource,
   
   public = list(
     #'@field cqlFilter CQL filter
     cqlFilter = NULL,
     
     #'@description Initializes a \link{GSCoverage} from XML
     #'@param xml object of class \link{xml_node-class}
     initialize = function(xml = NULL){
       super$initialize(rootName = "coverage")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     #'@description Decodes coverage from XML
     #'@param xml object of class \link{xml_node-class}
     decode = function(xml){
       super$decode(xml)
     },
     
     #'@description Set view
     #'@param cv cv, object of class \link{GSCoverageView}
     #'@return \code{TRUE} if set, \code{FALSE} otherwise
     setView = function(cv){
       if(!is(cv, "GSCoverageView")){
         stop("Argument 'cv' should be an object of class 'GSCoverageView'")
       }
       added <- super$setMetadata("COVERAGE_VIEW", cv)
       return(added)
     },
     
     #'@description Deletes view
     #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
     delView = function(){
       deleted <- super$delMetadata("COVERAGE_VIEW")
       return(deleted)
     }
     
   )
                         
)