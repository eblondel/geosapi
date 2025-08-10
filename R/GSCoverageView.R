#' Geoserver REST API GSCoverageView
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api coverageView
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer coverage view
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#'   GSCoverageView$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSCoverageView <- R6Class("GSCoverageView",
  inherit = GSRESTResource,                    
  public = list(
    #'@field name name
    name = NA,
    #'@field envelopeCompositionType envelope composition type
    envelopeCompositionType = NULL,
    #'@field selectedResolution selected resolution
    selectedResolution = NULL,
    #'@field selectedResolutionIndex selected resolution index
    selectedResolutionIndex = NULL,
    #'@field coverageBands coverage bands
    coverageBands = list(),
    
    #'@description Initializes an object of class \link{GSCoverageView}
    #'@param xml object of class \link[xml2]{xml_node-class}
    initialize = function(xml = NULL){
      super$initialize(rootName = "coverageView")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
    
    #'@description Decodes from XML
    #'@param xml object of class \link[xml2]{xml_node-class}
    decode = function(xml){
      xml = xml2::as_xml_document(xml)
      names <- xml2::xml_find_first(xml, "//name") 
      self$name <- xml2::xml_text(names)
      
      ect <- xml2::xml_find_first(xml, "//envelopeCompositionType")
      self$envelopeCompositionType <- xml2::xml_text(ect)
      
      sr <- xml2::xml_find_first(xml, "//selectedResolution")
      self$selectedResolution <- xml2::xml_text(sr)
      
      sri <- xml2::xml_find_first(xml, "//selectedResolutionIndex")
      self$selectedResolutionIndex <- xml2::xml_text(sri)
      
      bands <- as(xml2::xml_find_all(xml, "//coverageBand"), "list")
      if(length(bands)>0){
        for(band in bands){
          band <- GSCoverageBand$new(xml = band)
          self$addBand(band)
        }
      }   
    },
    
    #'@description Set name
    #'@param name name
    setName = function(name){
      self$name = name
    },
    
    #'@description Sets the envelope composition type. Type of Envelope Composition, used to expose the bounding box 
    #' of the CoverageView, either 'UNION' or 'INTERSECTION'.
    #'@param envelopeCompositionType envelope composition type
    setEnvelopeCompositionType = function(envelopeCompositionType){
      ectValues <- c("UNION", "INTERSECTION")
      if(!envelopeCompositionType %in% ectValues){
        stop(sprintf("The 'envelopeCompositionType' should be among values [%s]",
                     paste0(ectValues, collapse = ",")))
      }
      self$envelopeCompositionType = envelopeCompositionType
    },
    
    #'@description Set selected resolution
    #'@param selectedResolution selected resolution
    setSelectedResolution = function(selectedResolution){
      srValues <- c("BEST", "WORST")
      if(!selectedResolution %in% srValues){
        stop(sprintf("The 'selectedResolution' should be among values [%s]",
                     paste0(srValues, collapse = ",")))
      }
      self$selectedResolution = selectedResolution
    },
    
    #'@description Set selected resolution index
    #'@param selectedResolutionIndex selected resolution index
    setSelectedResolutionIndex = function(selectedResolutionIndex){
      self$selectedResolutionIndex = selectedResolutionIndex
    },
    
    #'@description Adds band
    #'@param band object of class \link{GSCoverageBand}
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
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
    
    #'@description Deletes band
    #'@param band object of class \link{GSCoverageBand}
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
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
