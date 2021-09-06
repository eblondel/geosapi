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
#' @field enabled is service enabled or not?
#' @field citeCompliant is service cite compliant?
#' @field name service name
#' @field title service title
#' @field maintainer service maintainer
#' @field abstract service abastract
#' @field accessConstraints service access constraints
#' @field fees service fees
#' @field keywords services keywords
#' @field onlineResource service online resource
#' @field schemaBaseURL service schema base URL
#' @field verbose service verbose or not?
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
#'    Sets if the service is enabled (TRUE) or not (FALSE)
#'  }
#'  \item{\code{setCiteCompliant(citeCompliant)}}{
#'    Sets if the service is compliant with CITE (TRUE) or not (FALSE)
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
#'  \item{\code{setKeywords(keywords)}}{
#'    Sets a list of keywords
#'  }
#'  \item{\code{addKeyword(keyword)}}{
#'    Sets a keyword. Returns TRUE if set, FALSE otherwise
#'  }
#'  \item{\code{delKeyword(keyword)}}{
#'    Deletes a keyword. Returns TRUE if deleted, FALSE otherwise
#'  }
#'  \item{\code{setOnlineResource(onlineResource)}}{
#'    Sets the online resource
#'  }
#'  \item{\code{setSchemaBaseURL(schemaBaseURL)}}{
#'    Sets the schema base URL. Default is http://schemas.opengis.net
#'  }
#'  \item{\code{setVerbose(verbose)}}{
#'    Sets verbose
#'  }
#'}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSServiceSettings <- R6Class("GSServiceSettings",
   inherit = GSRESTResource,
   public = list(
     enabled = TRUE,
     citeCompliant = FALSE,
     name = NULL,
     title = NULL,
     maintainer = NULL,
     abstrct = NULL,
     accessConstraints = "NONE",
     fees = "NONE",
     keywords = list(),
     onlineResource = NULL,
     schemaBaseURL = "http://schemas.opengis.net",
     verbose = FALSE,
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
       citeCompliant <- getNodeSet(xml, "//citeCompliant")
       if(length(citeCompliant)>0) self$citeCompliant <- as.logical(xmlValue(citeCompliant[[1]]))
       names <- getNodeSet(xml, paste0("//",self$rootName,"/name"))
       if(length(names)>0) self$name <- xmlValue(names[[1]])
       titles <- getNodeSet(xml, "//title")
       if(length(titles)>0) self$title <- xmlValue(titles[[1]])
       maintainers <- getNodeSet(xml, "//maintainer")
       if(length(maintainers)>0) self$maintainer <- xmlValue(maintainers[[1]])
       abstracts <- getNodeSet(xml, "//abstrct")
       if(length(abstracts)>0) self$abstrct <- xmlValue(abstracts[[1]])
       accessConstraints <- getNodeSet(xml, "//accessConstraints")
       if(length(accessConstraints)>0) self$accessConstraints <- xmlValue(accessConstraints[[1]])
       fees <- getNodeSet(xml, "//fees")
       if(length(fees)>0) self$fees <- xmlValue(fees[[1]])
       self$keywords <- lapply(getNodeSet(xml, "//keywords/string"), xmlValue)
       onlineRes <- getNodeSet(xml, "//onlineResource")
       if(length(onlineRes)>0) self$onlineResource <- xmlValue(onlineRes[[1]])
       schemaBaseURL <- getNodeSet(xml, "//schemaBaseURL")
       if(length(schemaBaseURL)>0) self$schemaBaseURL <- xmlValue(schemaBaseURL[[1]])
       verbose <- getNodeSet(xml, "//verbose")
       if(length(verbose)>0) self$verbose <- as.logical(xmlValue(verbose[[1]]))
     },
     
     setEnabled = function(enabled){
       self$enabled = enabled
     },
     
     setCiteCompliant = function(citeCompliant){
       self$citeCompliant <- citeCompliant
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
     },
     
     setAccessConstraints = function(accessConstraints){
       self$accessConstraints = accessConstraints
     },
     
     setFees = function(fees){
       self$fees = fees
     },
     
     setKeywords = function(keywords){
       if(!is.list(keywords)) keywords = list(keywords)
       self$keywords = keywords
       return(TRUE)
     },
     
     addKeyword = function(keyword){
       startNb = length(self$keywords)
       if(length(which(self$keywords == keyword)) == 0){
         self$keywords = c(self$keywords, keyword)
       }
       endNb = length(self$keywords)
       return(endNb == startNb+1)
     },
     
     delKeyword = function(keyword){
       startNb = length(self$keywords)
       self$keywords = self$keywords[which(self$keywords != keyword)]
       endNb = length(self$keywords)
       return(endNb == startNb-1)
     }
   )                       
)