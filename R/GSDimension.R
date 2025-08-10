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
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer dimension
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#'   dim <- GSDimension$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSDimension <- R6Class("GSDimension",
  inherit = GSRESTResource,
  
  public = list(
    #' @field enabled true/false
    enabled = TRUE,
    #' @field presentation dimension presentation
    presentation = NULL,
    #' @field resolution dimension resolution
    resolution = NULL,
    #' @field units dimension units
    units = NULL,
    #' @field unitSymbol dimension unitsSymbol
    unitSymbol = NULL,
    
    #'@description Initializes an object of class \link{GSDimension}
    #'@param xml object of class \link[xml2]{xml_node-class}
    initialize = function(xml = NULL){
      super$initialize(rootName = "dimensionInfo")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
   
    #'@description Decodes from XML
    #'@param xml object of class \link[xml2]{xml_node-class}
    decode = function(xml){
      xml = xml2::as_xml_document(xml)
      enabled = xml2::xml_find_first(xml, "//enabled") %>% xml2::xml_text() %>% as.logical()
      self$setEnabled(enabled)
      presentation = xml2::xml_find_first(xml, "//presentation") %>% xml2::xml_text()
      self$setPresentation(presentation)
      units = xml2::xml_find_first(xml, "//units") %>% xml2::xml_text()
      self$setUnit(units)
      unitSymbol = xml2::xml_find_first(xml, "//unitSymbol") %>% xml2::xml_text()
      if(!is.na(unitSymbol)) self$setUnitSymbol(unitSymbol)
    },
    
    #'@description Set enabled
    #'@param enabled enabled
    setEnabled = function(enabled){
      self$enabled = enabled
    },
    
    #'@description Set presentation
    #'@param presentation presentation. Possible values: "LIST", "CONTINUOUS_INTERVAL", "DISCRETE_INTERVAL"
    #'@param interval interval
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
    
    #'@description Set unit
    #'@param unit unit
    setUnit = function(unit){
      self$units = unit
    },
    
    #'@description Set unit symbol
    #'@param unitSymbol unit symbol
    setUnitSymbol = function(unitSymbol){
      self$unitSymbol = unitSymbol
    }
   
  )
                         
)
