#' Geoserver REST API Dimension
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSDimension
#' @title A GeoServer dimension
#' @description This class models a GeoServer resource dimension.
#' @keywords geoserver rest api resource dimension
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer dimension
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' dim <- GSDimension$new()
#'
#' @field enabled
#' @field presentation
#' @field resolution
#' @field units
#' @field unitSymbol
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSResource
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSResource from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSFeatureType to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDimension <- R6Class("GSDimension",
  inherit = GSRESTResource,
  
  public = list(
    enabled = TRUE,
    presentation = NULL,
    resolution = NULL,
    units = NULL,
    unitSymbol = NULL,
    initialize = function(xml = NULL){
      super$initialize(rootName = "dimensionInfo")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
   
    decode = function(xml){
      propsXML <- xmlChildren(xml)
      props <- lapply(propsXML, xmlValue)
      self$setEnabled(as.logical(props$enabled))
      self$setPresentation(props$presentation)
      self$setUnit(props$units)
      self$setUnitSymbol(props$unitSymbol)
    },
    
    setEnabled = function(enabled){
      self$enabled = enabled
    },
    
    setPresentation = function(presentation, interval = NULL){
      supportedPresentations <- c("LIST", "CONTINUOUS_INTERVAL", "DISCRETE_INTERVAL")
      if(!(presentation %in% supportedPresentations)){
        err <- sprintf("Unknown presentation '%s'. Supported values are: [%s]",
                       presentation, paste0(supportedPresentations, collapse=","))
        stop(err)
      }
      self$presentation = presentation
      if(self$presentation == "DISCRETE_INTERVAL"){
        if(missing(interval) | is.null(interval)){
          stop("Interval should be provided for DISCRETE_INTERVAL presentation")
        }
        self$resolution <- interval
      }
    },
    
    setUnit = function(unit){
      self$units = unit
    },
    
    setUnitSymbol = function(unitSymbol){
      self$unitSymbol = unitSymbol
    }
   
  )
                         
)