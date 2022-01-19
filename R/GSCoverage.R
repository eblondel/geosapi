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
#' @section Methods:
#' \describe{
#'  \item{\code{new(rootName, xml)}}{
#'    This method is used to instantiate a \code{GSCoverage}
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSCoverage}. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSCoverage} to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setView(cv)}}{
#'    Sets a coverage view for the coverage.
#'  }
#'  \item{\code{delView()}}{
#'    Deletes the coverage view for the coverage
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSCoverage <- R6Class("GSCoverage",
   inherit = GSResource,
   
   public = list(
     cqlFilter = NULL,
     initialize = function(xml = NULL){
       super$initialize(rootName = "coverage")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     decode = function(xml){
       super$decode(xml)
     },
     
     setView = function(cv){
       if(!is(cv, "GSCoverageView")){
         stop("Argument 'cv' should be an object of class 'GSCoverageView'")
       }
       added <- super$setMetadata("COVERAGE_VIEW", cv)
       return(added)
     },
     
     delView = function(){
       deleted <- super$delMetadata("COVERAGE_VIEW")
       return(deleted)
     }
     
   )
                         
)