#' Geoserver REST API REST Resource interface
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer REST resource interface
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSRESTResource <- R6Class("GSRESTResource",
                       
  public = list(
    #'@field rootName root name
    rootName = NA,
    
    #'@description Initializes an object of class \link{GSRESTResource}
    #'@param xml object of class \link{xml_node-class}
    #'@param rootName root name
    initialize = function(xml, rootName){
      if(missing(rootName) | is.null(rootName)){
        stop("No root name specified for GSRESTResource")
      }
      self$rootName = rootName
    },
    
    #'@description Decodes from XML. Abstract method to be implemented by sub-classes
    #'@param xml object of class \link{xml_node-class}
    decode = function(xml){
      stop("Unimplemented XML 'decode' method") 
    },
    
    #'@description Encodes as XML
    #'@return an object of class \link{xml_node-class}
    encode = function(){
      #Generic XML encoder
      rootXML <- xml2::xml_new_root(self$rootName)
      if(is(self, "GSPublishable")){
        xml2::xml_attrs(rootXML) <- c(type = self$attr_type)
      }
      
      #list of fields to encode as XML
      fields <- rev(names(self))
      fields <- fields[!sapply(fields, function(x){
        (class(self[[x]])[1] %in% c("environment", "function")) ||
        (x %in% c("rootName", "full", "attr_type"))
      })]
      
      if(is(self, "GSRESTEntrySet")){
        items <- self$entryset
        itemNb <- length(items)
        if(itemNb > 0){
          for(i in 1:itemNb){
            itemName <- names(items)[i]
            
            item <- xml2::xml_new_root("entry")
            xml2::xml_attrs(item) = c(key = itemName)
            
            itemValue <- items[[itemName]]
            if(is.logical(itemValue)){
              itemValue <- tolower(as.character(itemValue))
              xml2::xml_text(item) <- itemValue
            }
            if(is(itemValue, "GSRESTResource")){
              itemValue <- itemValue$encode()
              item %>% xml2::xml_add_child(itemValue)
            }
            rootXML %>% xml2::xml_add_child(item)
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
                itemsXML <- xml2::xml_new_root(field)
              }
              items <- fieldObj
              itemNames <- names(items)
              if(length(items) > 0){
                for(i in 1:length(items)){
                  item <- items[[i]]
                  itemName <- itemNames[i]
                  if(any(class(item) == "R6")){
                    itemXML <- item$encode()
                    itemsXML %>% xml2::xml_add_child(itemXML)
                  }else{
                    if(is.null(itemNames)){
                      itemXML <- xml2::xml_new_root("string")
                      if(!is.na(item)) xml2::xml_text(itemXML) <- as.character(item)
                      itemsXML %>% xml2::xml_add_child(itemXML)
                    }else{
                      itemXML <- xml2::xml_new_root(itemName)
                      if(!is.na(item)) xml2::xml_text(itemXML) <- as.character(item)
                      itemsXML %>% xml2::xml_add_child(itemXML)
                    }
                  }
                }
              }
              if(!is(self, "GSVirtualTable")) rootXML %>% xml2::xml_add_child(itemsXML)
            }else{
              if(any(class(fieldObj) == "R6")){
                rootXML %>% xml2::xml_add_child(fieldObj$encode())
              }else{
                itemXML <- xml2::xml_new_root(field)
                if(!is.na(fieldObj)) xml2::xml_text(itemXML) <- as.character(fieldObj)
                rootXML %>% xml2::xml_add_child(itemXML)
              }
            }
          }
        }
      }
      
      return(rootXML)
    }
  )                     
)
