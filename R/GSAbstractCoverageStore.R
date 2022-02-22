#' Geoserver REST API CoverageStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api CoverageStore
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer CoverageStore
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAbstractCoverageStore <- R6Class("GSAbstractCoverageStore",
 inherit = GSAbstractStore,
 private = list(
   STORE_TYPE = "coverageStore"
 ),
 public = list(
   #'@field url URL of the abstract coverage store
   url = NULL,
   
   #'@description initializes an abstract coverage store
   #'@param xml an object of class \link{XMLInternalNode-class} to create object from XML
   #'@param type the type of coverage store
   #'@param name coverage store name
   #'@param description coverage store description
   #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
   #'@param url URL of the store
   initialize = function(xml = NULL, type = NULL,
                         name = NULL, description = "", enabled = TRUE, url = NULL){
     super$initialize(xml = xml, storeType = private$STORE_TYPE, type = type, 
                      name = name, description = description, enabled = enabled)
     if(!missing(xml) & !is.null(xml)){
       if(!any(class(xml) %in% c("XMLInternalNode","XMLInternalDocument"))){
         stop("The argument 'xml' is not a valid XML object")
       }
       self$decode(xml)
     }else{
       self$setUrl(url)
     }
   },
   
   #'@description Decodes a coverage store from XML
   #'@param xml an object of class \link{XMLInternalNode-class}
   #'@return an object of class \link{GSAbstractCoverageStore}
   decode = function(xml){
     super$decode(xml)
     urlXML <- getNodeSet(xml,"//url")
     if(length(urlXML) > 0) self$url <- xmlValue(urlXML[[1]])
   },
   
   #'@description set coverage store URL
   #'@param url the store URL to set
   setUrl = function(url){
     self$url <- url
   }
 )                     
)
