#' Geoserver REST API Resource
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSLayer
#' @title A GeoServer layer resource
#' @description This class models a GeoServer layer. This class is to be
#' used for published resource (feature type or coverage).
#' @keywords geoserver rest api resource featureType coverage layer
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer layer
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' lyr <- GSLayer$new()
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(rootName, xml)}}{
#'    This method is used to instantiate a GSLayer
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSLayer from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSLayer to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSLayer <- R6Class("GSLayer",
  inherit = GSRESTResource,
  
  public = list(
    full = TRUE,
    name = NULL,
    path = NULL,
    defaultStyle = list(),
    styles = list(),
    enabled = TRUE,
    queryable = TRUE,
    advertised = TRUE,
    
    initialize = function(xml = NULL){
      super$initialize(rootName = "layer")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
   
    decode = function(xml){
      names <- getNodeSet(xml, "//name")
      self$name <- xmlValue(names[[1]])
      defaultStyle <- getNodeSet(xml, "//defaultStyle/name")
      if(length(defaultStyle)==0) self$full <- FALSE
      
      if(self$full){
        self$setDefaultStyle(xmlValue(defaultStyle[[1]]))
        paths <- getNodeSet(xml, "//path")
        if(length(paths)>0) self$path = xmlValue(paths[[1]])
        enabled <- getNodeSet(xml, "//enabled")
        if(length(enabled)>0) self$enabled <- as.logical(xmlValue(enabled[[1]]))
        queryable <- getNodeSet(xml, "//queryable")
        if(length(queryable)>0) self$queryable <- as.logical(xmlValue(queryable[[1]]))
        advertised <- getNodeSet(xml, "//advertised")
        if(length(advertised)>0) self$advertised <- as.logical(xmlValue(advertised[[1]]))
      }
    },
    
    setName = function(name){
      self$name = name
    },
    
    setPath = function(path){
      self$path = path
    },
    
    setEnabled = function(enabled){
      self$enabled = enabled
    },
    
    setQueryable = function(queryable){
      self$queryable = queryable
    },
    
    setAdvertised = function(advertised){
      self$advertised = advertised
    },
    
    setDefaultStyle = function(style){
      self$defaultStyle[["name"]] <- style
    }
   
  )                       
)