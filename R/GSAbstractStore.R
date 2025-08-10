#' Geoserver REST API Store
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api store
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer store
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAbstractStore <- R6Class("GSAbstractStore",
 inherit = GSRESTResource,
 private = list(
   store_type = NULL
 ),
 public = list(
   #'@field full whether store object is fully described
   full = FALSE,
   #' @field name store name
   name = NULL,
   #'@field enabled if the store is enabled or not
   enabled = NULL,
   #'@field description store description
   description = "",
   #' @field type store type
   type = NULL,
   #'@field workspace workspace name
   workspace = NULL,

   #'@description initializes an abstract store
   #'@param xml an object of class \link[xml2]{xml_node-class} to create object from XML
   #'@param storeType store type
   #'@param type the type of coverage store
   #'@param name coverage store name
   #'@param description coverage store description
   #'@param enabled whether the store should be enabled or not. Default is \code{TRUE}
   initialize = function(xml = NULL, storeType, type = NULL,
                         name = NULL, description = "", enabled = TRUE){
     super$initialize(rootName = storeType)
     private$store_type = storeType
     if(!missing(xml) & !is.null(xml)){
       if(!any(class(xml) %in% c("xml_document","xml_node"))){
         stop("The argument 'xml' is not a valid XML object")
       }
       self$decode(xml)
     }else{
       if(is.null(name)) stop("The 'name' cannot be null")
       self$name = name
       self$description = description
       self$type = type
       self$enabled = enabled
       self$full <- TRUE
     }
   },
   
   #'@description Decodes store from XML
   #'@param xml object of class \link[xml2]{xml_node-class}
   decode = function(xml){
     xml = xml2::as_xml_document(xml)
     names <- xml2::xml_find_first(xml, sprintf("//%s/name", private$store_type))
     self$name <- xml2::xml_text(names)
     enabled <- xml2::xml_find_first(xml,"//enabled")
     self$full <- length(enabled) > 0
     if(self$full){
       self$enabled <- as.logical(xml2::xml_text(enabled))
       
       descriptionXML <- xml2::xml_find_first(xml,"//description")
       if(length(descriptionXML) > 0) self$description <- xml2::xml_text(descriptionXML)
       
       typeXML <- xml2::xml_find_first(xml,"//type")
       if(length(typeXML) > 0) self$type <- xml2::xml_text(typeXML)
     }
   },
   
   #'@description Set type
   #'@param type type
   setType = function(type){
     self$type = type
   },
   
   #'@description Set enabled
   #'@param enabled enabled
   setEnabled = function(enabled){
     self$enabled <- enabled
   },
   
   #'@description Set description
   #'@param description description
   setDescription = function(description){
     self$description = description
   }
 )                     
)
