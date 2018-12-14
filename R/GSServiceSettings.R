#' Geoserver REST API Service Setting
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSServiceSettings
#' @title A GeoServer service settings resource
#' @description This class models a GeoServer OWS service settings.
#' @keywords geoserver rest api service OGC OWS WMS WFS WCS
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer OWS service setting
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' settings <- GSServiceSettings$new(service = "WMS")
#' settings$setEnabled(TRUE)
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(rootName, xml)}}{
#'    This method is used to instantiate a \code{GSServiceSettings}. This settings 
#'    object is required to model/manipulate an OGC service configuration, using the method
#'    \code{GSManager$updateServiceSettings} or derivates.
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSServiceSettings} from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSServiceSettings} to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setEnabled(enabled)}}{
#'    Sets if the layer is enabled (TRUE) or not (FALSE)
#'  }
#'  \item{\code{setName(name)}}{
#'    Sets the service name
#'  }
#'  \item{\code{setTitle(title)}}{
#'    Sets the service title
#'  }
#'  \item{\code{setAbstract(abstract)}}{
#'    Sets the service abstract
#'  }
#'  \item{\code{setMaintainer(maintainer)}}{
#'    Sets the service maintainer
#'  }
#'}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSServiceSettings <- R6Class("GSServiceSettings",
   inherit = GSRESTResource,
   public = list(
     enabled = TRUE,
     name = NULL,
     title = NULL,
     maintainer = NULL,
     abstrct = NULL,
     initialize = function(xml = NULL, service){
       super$initialize(rootName = tolower(service))
       self$setName(toupper(service))
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     decode = function(xml){
       enabled <- getNodeSet(xml, "//enabled")
       if(length(enabled)>0) self$enabled <- as.logical(xmlValue(enabled[[1]]))
       names <- getNodeSet(xml, paste0("//",self$rootName,"/name"))
       if(length(names)>0) self$name <- xmlValue(names[[1]])
       titles <- getNodeSet(xml, "//title")
       if(length(titles)>0) self$title <- xmlValue(titles[[1]])
       maintainers <- getNodeSet(xml, "//maintainer")
       if(length(maintainers)>0) self$maintainer <- xmlValue(maintainers[[1]])
       abstracts <- getNodeSet(xml, "//abstrct")
       if(length(abstracts)>0) self$abstrct <- xmlValue(abstracts[[1]])
     },
     
     setEnabled = function(enabled){
       self$enabled = enabled
     },     
     
     setName = function(name){
       self$name = name
     },
     
     setTitle = function(title){
       self$title = title
     },
     
     setMaintainer = function(maintainer){
       self$maintainer = maintainer
     },
     
     setAbstract = function(abstract){
       self$abstrct = abstract
     }
   )                       
)