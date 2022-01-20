#' Geoserver REST API GSCoverageView
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api coverageView
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer coverage view
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSCoverageView$new()
#'
#' @field name name
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a \code{GSCoverageView}
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSCoverageView} from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSCoverageView} to XML
#'  }
#'  \item{\code{setName(name)}}{
#'    Sets the name of the coverage view
#'  }
#'  \item{\code{setEnvelopeCompositionType}}{
#'    Sets the envelope composition type. Type of Envelope Composition, used to expose the bounding box 
#'    of the CoverageView, either 'UNION' or 'INTERSECTION'.
#'  }
#'  \item{\code{setSelectedResolution(selectedResolution)}}{
#'    Sets the selected resolution
#'  }
#'  \item{\code{setSelectedResolutionIndex(selectedResolutionIndex)}}{
#'    Sets the selected resolution index
#'  }
#'  \item{\code{addBand(band)}}{
#'    Adds a coverage band
#'  }
#'  \item{\code{delBand(band)}}{
#'    Removes a coverage band.
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSCoverageView <- R6Class("GSCoverageView",
  inherit = GSRESTResource,                    
  public = list(
    name = NA,
    envelopeCompositionType = NULL,
    selectedResolution = NULL,
    selectedResolutionIndex = NULL,
    coverageBands = list(),
    
    initialize = function(xml = NULL){
      super$initialize(rootName = "coverageView")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
    
    decode = function(xml){
      names <- getNodeSet(xml, "//name")
      self$name <- xmlValue(names[[1]])
      
      ect <- getNodeSet(xml, "//envelopeCompositionType")
      self$envelopeCompositionType <- xmlValue(ect[[1]])
      
      sr <- getNodeSet(xml, "//selectedResolution")
      self$selectedResolution <- xmlValue(sr[[1]])
      
      sri <- getNodeSet(xml, "//selectedResolutionIndex")
      self$selectedResolutionIndex <- xmlValue(sri[[1]])
      
      bands <- getNodeSet(xml, "//coverageBand")
      if(length(bands)>0){
        for(band in bands){
          band <- GSCoverageBand$new(xml = band)
          self$addBand(band)
        }
      }   
    },
    
    #setName
    setName = function(name){
      self$name = name
    },
    
    #setEnvelopeCompositionType
    setEnvelopeCompositionType = function(envelopeCompositionType){
      ectValues <- c("UNION", "INTERSECTION")
      if(!envelopeCompositionType %in% ectValues){
        stop(sprintf("The 'envelopeCompositionType' should be among values [%s]",
                     paste0(ectValues, collapse = ",")))
      }
      self$envelopeCompositionType = envelopeCompositionType
    },
    
    #setSelectedResolution
    setSelectedResolution = function(selectedResolution){
      srValues <- c("BEST", "WORST")
      if(!selectedResolution %in% srValues){
        stop(sprintf("The 'selectedResolution' should be among values [%s]",
                     paste0(srValues, collapse = ",")))
      }
      self$selectedResolution = selectedResolution
    },
    
    #setSelectedResolutionIndex
    setSelectedResolutionIndex = function(selectedResolutionIndex){
      self$selectedResolutionIndex = selectedResolutionIndex
    },
    
    #addBand
    addBand = function(band){
      if(!is(band, "GSCoverageBand")){
        stop("The 'band' object object should be of class 'GSCoverageBand'")
      }
      startNb = length(self$coverageBands)
      availableBands <- sapply(self$coverageBands, function(x){x$index})
      if(length(which(availableBands == band$index)) == 0){
        self$coverageBands = c(self$coverageBands, band)
      }
      endNb = length(self$coverageBands)
      return(endNb == startNb+1)
    },
    
    #delBand
    delBand = function(band){
      if(!is(band, "GSCoverageBand")){
        stop("The 'band' object object should be of class 'GSCoverageBand'")
      }
      startNb = length(self$coverageBands)
      availableBands <- sapply(self$coverageBands, function(x){x$index})
      self$coverageBands = self$coverageBands[which(availableBands != band$index)]
      endNb = length(self$coverageBands)
      return(endNb == startNb-1)
    }
    
  )                     
)