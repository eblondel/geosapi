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
#'   lyr <- GSLayer$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSLayer <- R6Class("GSLayer",
  inherit = GSRESTResource,
  
  public = list(
    #'@field full full
    full = TRUE,
    #'@field name name
    name = NULL,
    #'@field path path
    path = NULL,
    #'@field defaultStyle default style
    defaultStyle = list(),
    #'@field styles styles
    styles = list(),
    #'@field enabled enabled
    enabled = TRUE,
    #'@field queryable queryable
    queryable = TRUE,
    #'@field advertised advertised
    advertised = TRUE,
    
    #'@description Initializes an object of class \link{GSLayer}
    #'@param xml object of class \link{xml_node-class}
    initialize = function(xml = NULL){
      super$initialize(rootName = "layer")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }
    },
   
    #'@description Decodes from XML
    #'@param xml object of class \link{xml_node-class}
    decode = function(xml){
      xml = xml2::as_xml_document(xml)
      names <- xml2::xml_find_first(xml, "//name")
      self$name <- xml2::xml_text(names)
      defaultStyle <- xml2::xml_find_first(xml, "//defaultStyle/name")
      if(length(defaultStyle)==0) self$full <- FALSE
      
      if(self$full){
        self$setDefaultStyle(xml2::xml_text(defaultStyle))
        
        styles <- as(xml2::xml_find_all(xml, "//styles/style"), "list")
        if(length(styles)>0){
          styles <- lapply(styles, function(x){
            style <- GSStyle$new()
            style$setName(xml2::xml_find_first(x, "//name") %>% xml2::xml_text())
            filename = xml2::xml_find_first(x, "//filename")
            if(length(filename)>0){
              style$setFilename(xml2::xml_text(filename))
            }
            return(style)
          })
          self$setStyles(styles)
        }
        
        paths <- xml2::xml_find_first(xml, "//path")
        if(length(paths)>0) self$path = xml2::xml_text(path)
        enabled <-xml2::xml_find_first(xml, "//enabled")
        if(length(enabled)>0) self$enabled <- as.logical(xml2::xml_text(enabled))
        queryable <- xml2::xml_find_first(xml, "//queryable")
        if(length(queryable)>0) self$queryable <- as.logical(xml2::xml_text(queryable))
        advertised <- xml2::xml_find_first(xml, "//advertised")
        if(length(advertised)>0) self$advertised <- as.logical(xml2::xml_text(advertised))
      }
    },
    
    #'@description Set name
    #'@param name name
    setName = function(name){
      self$name = name
    },
    
    #'@description Set path
    #'@param path path
    setPath = function(path){
      self$path = path
    },
    
    #'@description Set enabled
    #'@param enabled enabled
    setEnabled = function(enabled){
      self$enabled = enabled
    },
    
    #'@description Set queryable
    #'@param queryable queryable
    setQueryable = function(queryable){
      self$queryable = queryable
    },
    
    #'@description Set advertised
    #'@param advertised advertised
    setAdvertised = function(advertised){
      self$advertised = advertised
    },
    
    #'@description Set default style
    #'@param style object o class \link{GSStyle} or \code{character}
    setDefaultStyle = function(style){
      if(any(class(style)=="GSStyle")) style <- style$name
      self$defaultStyle[["name"]] <- style
    },
    
    #'@description Set styles
    #'@param styles styles
    setStyles = function(styles){
      if(!is.list(styles)) styles = list(styles)
      self$styles = styles
      return(TRUE)
    },
    
    #'@description Adds style
    #'@param style style, object o class \link{GSStyle} or \code{character}
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
    addStyle = function(style){
      if(is(style, "character")) style <- GSStyle$new(xml=NULL, name = style)
      startNb = length(self$styles)
      availableStyles <- sapply(self$styles, function(x){x$name})
      if(length(which(availableStyles == style$name)) == 0){
        self$styles = c(self$styles, style)
      }
      endNb = length(self$styles)
      return(endNb == startNb+1)
    },
    
    #'@description Deletes style
    #'@param style style, object o class \link{GSStyle} or \code{character}
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    delStyle = function(style){
      if(is(style, "character")) style <- GSStyle$new(xml=NULL, name = style)
      startNb = length(self$styles)
      availableStyles <- sapply(self$styles, function(x){x$name})
      self$styles = self$styles[which(availableStyles != style$name)]
      endNb = length(self$styles)
      return(endNb == startNb-1)
    }
   
  )                       
)