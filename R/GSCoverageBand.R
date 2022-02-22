#' Geoserver REST API GSCoverageBand
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api coverageBand
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer coverage band
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSCoverageBand$new()
#' 

#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a \code{GSCoverageBand}
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSCoverageBand} from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSCoverageBand} to XML
#'  }
#'  \item{\code{setDefinition(definition)}}{
#'    Sets the coverage band definition
#'  }
#'  \item{\code{setIndex(index)}}{
#'    Sets the coverage band index
#'  }
#'  \item{\code{setCompositionType}}{
#'    Sets the composition type. Only 'BAND_SELECT' is supported by GeoServer for now.
#'  }
#'  \item{\code{addInputBand(band)}}{
#'    Adds a input coverage band, object of class \code{GSInputCoverageBand}
#'  }
#'  \item{\code{delInputBand(band)}}{
#'    Removes a input coverage band, object of class \code{GSInputCoverageBand}
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSCoverageBand <- R6Class("GSCoverageBand",
  inherit = GSRESTResource,                    
  public = list(
    
    #' @field inputCoverageBands list of input coverage bands
    inputCoverageBands = list(),
    #' @field definition coverage band definition
    definition = NULL,
    #' @field index coverage band index
    index = NULL,
    #' @field compositionType coverage band composition type
    compositionType = "BAND_SELECT",
    
    #'@description Initalizes a \link{GSCoverageBand}
    #'@param xml object of class \link{XMLInternalNode-class}
    initialize = function(xml = NULL){
      super$initialize(rootName = "coverageBand")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
    
    #'@description Decodes from XML
    #'@param xml object of class \link{XMLInternalNode-class}
    decode = function(xml){

      def <- getNodeSet(xml, "//definition")
      self$definition <- xmlValue(def[[1]])
      
      idx <- getNodeSet(xml, "//index")
      self$index <- xmlValue(idx[[1]])
      
      ct <- getNodeSet(xml, "//compositionType")
      self$compositionType <- xmlValue(ct[[1]])
      
      bands <- getNodeSet(xml, "//inputCoverageBands/inputCoverageBand")
      if(length(bands)>0){
        for(band in bands){
          band <- GSInputCoverageBand$new(xml = band)
          self$addInputBand(band)
        }
      }   
    },
    
    #'@description Set name
    #'@param name name
    setName = function(name){
      self$name = name
    },
    
    #'@description Set definition
    #'@param definition definition
    setDefinition = function(definition){
      self$definition = definition
    },
    
    #'@description Set index
    #'@param index index
    setIndex = function(index){
      self$index = index
    },
    
    #'@description Set composition type
    #'@param compositionType composition type
    setCompositionType = function(compositionType){
      self$compositionType = compositionType
    },
    
    #'@description Adds an input band
    #'@param band object of class \link{GSInputCoverageBand}
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
    addInputBand = function(band){
      if(!is(band, "GSInputCoverageBand")){
        stop("The 'band' object object should be of class 'GSInputCoverageBand'")
      }
      startNb = length(self$inputCoverageBands)
      availableInputBands <- sapply(self$inputCoverageBands, function(x){x$band})
      if(length(which(availableInputBands == band$band)) == 0){
        self$inputCoverageBands = c(self$inputCoverageBands, band)
      }
      endNb = length(self$inputCoverageBands)
      return(endNb == startNb+1)
    },
    
    #'@description Deletes an input band
    #'@param band object of class \link{GSInputCoverageBand}
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    delInputBand = function(band){
      if(!is(band, "GSInputCoverageBand")){
        stop("The 'band' object object should be of class 'GSInputCoverageBand'")
      }
      startNb = length(self$inputCoverageBands)
      availableInputBands <- sapply(self$inputCoverageBands, function(x){x$band})
      self$inputCoverageBands = self$inputCoverageBands[which(availableInputBands != band$band)]
      endNb = length(self$inputCoverageBands)
      return(endNb == startNb-1)
    }
    
  )                     
)