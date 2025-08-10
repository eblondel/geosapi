#' Geoserver REST API XML entry set
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSRESTEntrySet
#' 
#' @keywords geoserver rest api entryset
#' @return Object of \code{\link[R6]{R6Class}} for modelling a entry set
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSRESTEntrySet <- R6Class("GSRESTEntrySet",
  inherit = GSRESTResource,
  public = list(
   #'@field entryset entryset
   entryset = list(),
   
   #'@description Initializes an object of class \link{GSRESTEntrySet}
   #'@param rootName root name
   #'@param xml object of class \link[xml2]{xml_node-class}
   #'@param entryset entry set
   initialize = function(rootName, xml = NULL, entryset){
     super$initialize(rootName = rootName)
     if(!missing(xml) & !is.null(xml)){
       if(!any(class(xml) %in% c("xml_document","xml_node"))){
         stop("The argument 'xml' is not a valid XML object")
       }
       self$decode(xml)
     }else{
       if(!missing(entryset)){
         self$entryset = entryset
       }
     }
   },
   
   #'@description Decodes from XML
   #'@param xml object of class \link[xml2]{xml_node-class} 
   decode = function(xml){
     xml = xml2::as_xml_document(xml)
    entriesXML <- as(xml2::xml_find_all(xml, sprintf("//%s/entry", self$rootName)), "list")
     self$entryset = lapply(entriesXML, function(x){
       entry <- xml2::xml_text(x)
       if(entry %in% c("true","false")){
         entry <- as.logical(entry)
       }
       return(entry)
     })
     names(self$entryset) = lapply(entriesXML, xml2::xml_attr, "key")
   },
   
   #'@description Set entry set
   #'@param entryset entry set
   setEntryset = function(entryset){
     self$entryset = entryset
   },
   
   #'@description Adds entry set
   #'@param key key
   #'@param value value
   #'@return \code{TRUE} if added, \code{FALSE} otherwise
   addEntry = function(key, value){
     startNb <- length(self$entryset)
     if(length(which(names(self$entryset) == key)) == 0){
       self$entryset[[key]] <- value
     }
     endNb <- length(self$entryset)
     return(endNb == startNb+1)
   },
   
   #'@description Sets entry set
   #'@param key key
   #'@param value value
   setEntry = function(key, value){
     self$entryset[[key]] <- value
   },
   
   #'@description Deletes entry set
   #'@param key key
   #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
   delEntry = function(key){
     startNb <- length(self$entryset)
     self$entryset = self$entryset[which(names(self$entryset) != key)]
     endNb <- length(self$entryset)
     return(endNb == startNb-1)
   }
   
  )                     
)
