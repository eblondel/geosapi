#' Geoserver REST API REST Resource interface
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer REST resource interface
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSRESTResource <- R6Class("GSRESTResource",
  public = list(
    
    #'@field rootName root name
    rootName = NA,
    
    #'@field attrs attrs
    attrs = list(),
    
    #'@description Initializes an object of class \link{GSRESTResource}
    #'@param xml object of class \link[xml2]{xml_node-class}
    #'@param rootName root name
    initialize = function(xml, rootName){
      if(missing(rootName) | is.null(rootName)){
        stop("No root name specified for GSRESTResource")
      }
      self$rootName = rootName
    },
    
    #'@description Decodes from XML. Abstract method to be implemented by sub-classes
    #'@param xml object of class \link[xml2]{xml_node-class}
    decode = function(xml){
      stop("Unimplemented XML 'decode' method") 
    },
    
    #'@description Encodes as XML
    #'@return an object of class \link[xml2]{xml_node-class}
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
        (x %in% c("rootName", "full", "attr_type", "attrs"))
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
            }
            if(is(itemValue, "GSRESTResource")){
              itemValue <- itemValue$encode()
              item %>% xml2::xml_add_child(itemValue)
            }else{
              xml2::xml_text(item) <- itemValue
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
      
      #XML attribute support
      if(length(self$attrs)>0){
        xml2::xml_attrs(rootXML) <- self$attrs
      }
      
      return(rootXML)
    },
    
    #'@description Provides a custom print output (as tree) of the current class
    #'@param ... args
    #'@param depth class nesting depth
    print = function(..., depth = 1){
      #list of fields to encode as XML
      fields <- rev(names(self))
      
      #fields
      fields <- fields[!sapply(fields, function(x){
        (class(self[[x]])[1] %in% c("environment", "function")) ||
          (x %in% c("rootName", "full", "attr_type"))
      })]
      
      cat(crayon::white(paste0("<", crayon::underline(self$getClassName()), ">")))
      
      for(field in fields){
        fieldObj <- self[[field]]
        
        print_attrs <- function(obj){
          paste(
            sapply(names(obj$attrs), function(attrName){
              paste0( crayon::magenta(attrName,"=",sep=""), crayon::green(obj$attrs[[attrName]]))
            }
            ), 
            collapse=",")
        }
        
        #user values management
        shift <- "...."
        if(!is.null(fieldObj)){
          if(is(fieldObj, "GSRESTResource")){
            attrs_str <- ""
            if(length(fieldObj$attrs)>0){
              attrs <- print_attrs(fieldObj)
              attrs_str <- paste0(" [",attrs,"] ")
            }
            cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), " ", attrs_str))
            fieldObj$print(depth = depth+1)
          }else if(is(fieldObj, "list")){
            if(is.null(names(fieldObj))){
              for(item in fieldObj){
                if(is(item, "GSRESTResource")){
                  attrs_str <- ""
                  if(length(item$attrs)>0){
                    attrs <- print_attrs(item)
                    attrs_str <- paste0(" [",attrs,"] ")
                  }
                  cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), " ", attrs_str))
                  item$print(depth = depth+1)
                }else if(is(item, "matrix")){
                  m <- paste(apply(item, 1L, function(x){
                    x <- lapply(x, function(el){
                      if(is.na(suppressWarnings(as.numeric(el))) & !all(sapply(item,class)=="character")){
                        el <- paste0("\"",el,"\"")
                      }else{
                        if(!is.na(suppressWarnings(as.numeric(el)))){
                          el <- as.numeric(el)
                        }
                      }
                      return(el)
                    })
                    return(paste(x, collapse = " "))
                  }), collapse = " ")
                  cat(paste0("\n",paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(m)))
                }else{
                  cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(item)))
                }
              }
            }else{
              cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field)))
              for(itemName in names(fieldObj)){
                item = fieldObj[[itemName]]
                if(is(item, "GSRESTResource")){
                  attrs_str <- ""
                  if(length(item$attrs)>0){
                    attrs <- print_attrs(item)
                    attrs_str <- paste0(" [",attrs,"] ")
                  }
                  cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), " ", attrs_str))
                  item$print(depth = depth+1)
                }else{
                  cat(paste0("\n", paste(rep(shift, depth+1), collapse=""),"|-- ", crayon::italic(itemName), ": ", crayon::bgWhite(fieldObj[[itemName]])))
                }
              }
            }
          }else if (is(fieldObj,"matrix")){
            m <- paste(apply(fieldObj, 1L, function(x){
              x <- lapply(x, function(el){
                if(is.na(suppressWarnings(as.numeric(el)))& !all(sapply(fieldObj,class)=="character")){
                  el <- paste0("\"",el,"\"")
                }else{
                  if(!is.na(suppressWarnings(as.numeric(el)))){
                    el <- as.numeric(el)
                  }
                }
                return(el)
              })
              return(paste(x, collapse = " "))
            }), collapse = " ")
            cat(paste0("\n",paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(m)))
          }else{
            cat(paste0("\n",paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(fieldObj)))
          }
        }
      }
      invisible(self)
    },
    
    #'@description Get class name
    #'@return an object of class \code{character}
    getClassName = function(){
      return(class(self)[1])
    }
  )                     
)
