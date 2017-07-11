#' Geoserver REST API REST Resource interface
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer REST resource interface
#' @format \code{\link{R6Class}} object.
#'
#' @section Abstract Methods:
#' \describe{
#'  \item{\code{new()}}{
#'    This method is used to instantiate a GSRESTResource
#'  }
#'  \item{\code{decode(xml)}}{
#'    Decodes a GS* R6 object from XML representation
#'  }
#'  \item{\code{encode()}}{
#'    Encodes a GS* R6 object to XML representation
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSRESTResource <- R6Class("GSRESTResource",
                       
  public = list(
    rootName = NA,
    initialize = function(xml, rootName){
      if(missing(rootName) | is.null(rootName)){
        stop("No root name specified for GSRESTResource")
      }
      self$rootName = rootName
    },
    
    decode = function(xml){
      stop("Unimplemented XML 'decode' method") 
    },
    
    encode = function(){
      #Generic XML encoder
      rootXML <- newXMLNode(self$rootName)
      if(is(self, "GSPublishable")){
        xmlAttrs(rootXML) <- c(type = self$type)
      }
      
      #list of fields to encode as XML
      fields <- rev(names(self))
      fields <- fields[!sapply(fields, function(x){
        (class(self[[x]]) %in% c("environment", "function")) ||
        (x %in% c("rootName", "full", "attr_type"))
      })]
      
      if(is(self, "GSRESTEntrySet")){
        items <- self$entryset
        itemNb <- length(items)
        if(itemNb > 0){
          for(i in 1:itemNb){
            itemName <- names(items)[i]
            itemValue <- items[[itemName]]
            if(is.logical(itemValue)){
              itemValue <- tolower(as.character(itemValue))
            }
            if(any(class(itemValue) == "GSRESTResource")){
              itemValue <- itemValue$encode()
            }
            item <- newXMLNode("entry", attrs = c(key = itemName),
                               itemValue, parent = rootXML)
          }
        }
      }else{
        for(field in fields){
          fieldObj <- self[[field]]
          if(!is.null(fieldObj)){
            if(is.logical(fieldObj)){
              fieldObj <- tolower(as.character(fieldObj))
            }
            
            if(any(class(fieldObj) == "list")){
              if(is(self, "GSVirtualTable")){
                itemsXML <- rootXML
              }else{
                itemsXML <- newXMLNode(field, parent = rootXML)
              }
              items <- fieldObj
              itemNames <- names(items)
              if(length(items) > 0){
                for(i in 1:length(items)){
                  item <- items[[i]]
                  itemName <- itemNames[i]
                  if(any(class(item) == "R6")){
                    itemXML <- item$encode()
                    addChildren(itemsXML, itemXML)
                  }else{
                    if(is.null(itemNames)){
                      itemXML <- suppressWarnings(newXMLNode("string", item, parent = itemsXML))
                    }else{
                      itemXML <- suppressWarnings(newXMLNode(itemName, item, parent = itemsXML))
                    }
                  }
                }
              }
            }else{
              if(any(class(fieldObj) == "R6")){
                addChildren(rootXML, fieldObj$encode())
              }else{
                itemXML <- newXMLNode(field, fieldObj, parent = rootXML)
              }
            }
          }
        }
      }
      
      return(rootXML)
    }
  )                     
)
