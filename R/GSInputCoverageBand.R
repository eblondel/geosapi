#' Geoserver REST API GSInputCoverageBand
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api inputCoverageBand
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer input coverage band
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   GSInputCoverageBand$new()
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, coverageName, band)}}{
#'    This method is used to instantiate a \code{GSInputCoverageBand}
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSInputCoverageBand} from XML
#'  }
#'  \item{\code{setCoverageName(coverageName)}}{
#'    Sets the coverage name
#'  }
#'  \item{\code{setBand(band)}}{
#'    Sets the coverage band
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSInputCoverageBand <- R6Class("GSInputCoverageBand",
  inherit = GSRESTResource,                    
  public = list(
    #'@field coverageName coverage name
    coverageName = NULL,
    #'@field band band
    band = NULL,
    
    #'@description Initializes an object of class \link{GSInputCoverageBand}
    #'@param xml object of class \link{XMLInternalNode-class}
    #'@param coverageName coverage name
    #'@param band band name
    initialize = function(xml = NULL, coverageName = NULL, band = NULL){
      super$initialize(rootName = "inputCoverageBand")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }else{
        self$setCoverageName(coverageName)
        self$setBand(band)
      }
    },
    
    #'@description Decodes from XML
    #'@param xml object of class \link{XMLInternalNode-class}
    decode = function(xml){
      coverageNames <- getNodeSet(xml, "//coverageName")
      self$coverageName <- xmlValue(coverageNames[[1]])
      bands <- getNodeSet(xml, "//band")
      self$band <- xmlValue(bands[[1]])
    },
    
    #'@description Set coverage name
    #'@param coverageName coverage name
    setCoverageName = function(coverageName){
      self$coverageName = coverageName
    },
  
    #'@description Set band
    #'@param band band
    setBand = function(band){
      self$band = band
    }
    
  )                     
)