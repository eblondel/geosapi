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
    #'@param xml object of class \link{xml_node-class}
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
    #'@param xml object of class \link{xml_node-class}
    decode = function(xml){
      xml = xml2::as_xml_document(xml)
      coverageNames <- xml2::xml_find_first(xml, "//coverageName")
      self$coverageName <- xml2::xml_text(coverageNames)
      bands <- xml2::xml_find_first(xml, "//band")
      self$band <- xml2::xml_text(bands)
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