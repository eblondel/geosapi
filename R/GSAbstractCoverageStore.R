#' Geoserver REST API CoverageStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api CoverageStore
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer CoverageStore
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, type, name, description, enabled)}}{
#'    This method is used to instantiate a \code{GSAbstractCoverageStore}
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSAbstractCoverageStore} from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSAbstractCoverageStore} to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAbstractCoverageStore <- R6Class("GSAbstractCoverageStore",
 inherit = GSAbstractStore,
 private = list(
   STORE_TYPE = "coverageStore"
 ),
 public = list(
   url = NULL,
   initialize = function(xml = NULL, type = NULL,
                         name = NULL, description = "", enabled = TRUE, url){
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
   
   #decode
   decode = function(xml){
     super$decode(xml)
     urlXML <- getNodeSet(xml,"//url")
     if(length(urlXML) > 0) self$url <- xmlValue(urlXML[[1]])
   },
   
   #setUrl
   setUrl = function(url){
     self$url <- url
   }
 )                     
)
