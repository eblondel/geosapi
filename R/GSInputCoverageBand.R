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
#' GSInputCoverageBand$new()
#' 
#' @field coverageName coverage name
#' @field band coverage band
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
    coverageName = NULL,
    band = NULL,
    initialize = function(xml = NULL, coverageName = NULL, band = NULL){
      super$initialize(rootName = "inputCoverageBand")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }else{
        self$setCoverageName(coverageName)
        self$setBand(band)
      }
    },
    
    decode = function(xml){
      coverageNames <- getNodeSet(xml, "//coverageName")
      self$coverageName <- xmlValue(coverageNames[[1]])
      bands <- getNodeSet(xml, "//band")
      self$band <- xmlValue(bands[[1]])
    },
    
    #setCoverageName
    setCoverageName = function(coverageName){
      self$coverageName = coverageName
    },
  
    #setBand
    setBand = function(band){
      self$band = band
    }
    
  )                     
)