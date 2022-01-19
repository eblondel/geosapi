#' Geoserver REST API Store
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api store
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer store
#' @format \code{\link{R6Class}} object.
#'
#' @field name store name
#' @field description store description
#' @field enabled if the store is enabled or not
#' @field type store type
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, storeType, type, name, description, enabled)}}{
#'    This method is used to instantiate a \code{GSAbstractStore}
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSAbstractStore} from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSAbstractStore} to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setEnabled(enabled)}}{
#'    Sets the datastore as enabled if TRUE, disabled if FALSE
#'  }
#'  \item{\code{setDescription(description)}}{
#'    Sets the datastore description
#'  }
#'  \item{\code{setType(type)}}{
#'    Sets the datastore type
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAbstractStore <- R6Class("GSAbstractStore",
 inherit = GSRESTResource,
 private = list(
   store_type = NULL
 ),
 public = list(
   full = FALSE,
   name = NULL,
   enabled = NULL,
   description = "",
   type = NULL,
   workspace = NULL,
   
   initialize = function(xml = NULL, storeType, type = NULL,
                         name = NULL, description = "", enabled = TRUE){
     super$initialize(rootName = storeType)
     private$store_type = storeType
     if(!missing(xml) & !is.null(xml)){
       if(!any(class(xml) %in% c("XMLInternalNode","XMLInternalDocument"))){
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
   
   #decode
   #---------------------------------------------------------------------------
   decode = function(xml){
     names <- getNodeSet(xml, sprintf("//%s/name", private$store_type))
     self$name <- xmlValue(names[[1]])
     enabled <- getNodeSet(xml,"//enabled")
     self$full <- length(enabled) > 0
     if(self$full){
       self$enabled <- as.logical(xmlValue(enabled[[1]]))
       
       descriptionXML <- getNodeSet(xml,"//description")
       if(length(descriptionXML) > 0) self$description <- xmlValue(descriptionXML[[1]])
       
       typeXML <- getNodeSet(xml,"//type")
       if(length(typeXML) > 0) self$type <- xmlValue(typeXML[[1]])
     }
   },
   
   #setType
   #---------------------------------------------------------------------------
   setType = function(type){
     self$type = type
   },
   
   #setEnabled
   #---------------------------------------------------------------------------
   setEnabled = function(enabled){
     self$enabled <- enabled
   },
   
   #setDescription
   #---------------------------------------------------------------------------
   setDescription = function(description){
     self$description = description
   }
 )                     
)
