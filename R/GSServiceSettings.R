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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSServiceSettings <- R6Class("GSServiceSettings",
   inherit = GSRESTResource,
   public = list(
     #' @field enabled is service enabled or not?
     enabled = TRUE,
     #' @field citeCompliant is service cite compliant?
     citeCompliant = FALSE,
     #' @field name service name
     name = NULL,
     #' @field title service title
     title = NULL,
     #' @field maintainer service maintainer
     maintainer = NULL,
     #' @field abstrct service abastract
     abstrct = NULL,
     #' @field accessConstraints service access constraints
     accessConstraints = "NONE",
     #' @field fees service fees
     fees = "NONE",
     #' @field keywords services keywords
     keywords = list(),
     #' @field onlineResource service online resource
     onlineResource = NULL,
     #' @field schemaBaseURL service schema base URL
     schemaBaseURL = "http://schemas.opengis.net",
     #' @field verbose service verbose or not?
     verbose = FALSE,
     
     #'@description Initializes an object of class \link{GSServiceSettings}
     #'@param xml object of class \link{xml_node-class}
     #'@param service service service acronym
     initialize = function(xml = NULL, service){
       super$initialize(rootName = tolower(service))
       self$setName(toupper(service))
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link{xml_node-class}
     decode = function(xml){
       enabled <- xml2::xml_find_first(xml, "//enabled")
       if(length(enabled)>0) self$enabled <- as.logical(xml2::xml_text(enabled))
       citeCompliant <- xml2::xml_find_first(xml, "//citeCompliant")
       if(length(citeCompliant)>0) self$citeCompliant <- as.logical(xml2::xml_text(citeCompliant))
       names <- xml2::xml_find_first(xml, paste0("//",self$rootName,"/name"))
       if(length(names)>0) self$name <- xml2::xml_text(names)
       titles <- xml2::xml_find_first(xml, "//title")
       if(length(titles)>0) self$title <- xml2::xml_text(titles)
       maintainers <- xml2::xml_find_first(xml, "//maintainer")
       if(length(maintainers)>0) self$maintainer <- xml2::xml_text(maintainers)
       abstracts <- xml2::xml_find_first(xml, "//abstrct")
       if(length(abstracts)>0) self$abstrct <- xml2::xml_text(abstracts)
       accessConstraints <- xml2::xml_find_first(xml, "//accessConstraints")
       if(length(accessConstraints)>0) self$accessConstraints <- xml2::xml_text(accessConstraints)
       fees <- xml2::xml_find_first(xml, "//fees")
       if(length(fees)>0) self$fees <- xml2::xml_text(fees)
       
       self$keywords <- lapply(as(xml2::xml_find_all(xml, "//keywords/string"), "list"), xml2::xml_text)
       onlineRes <- getNodeSet(xml, "//onlineResource")
       if(length(onlineRes)>0) self$onlineResource <- xml2::xml_text(onlineRes)
       schemaBaseURL <- xml2::xml_find_first(xml, "//schemaBaseURL")
       if(length(schemaBaseURL)>0) self$schemaBaseURL <- xml2::xml_text(schemaBaseURL)
       verbose <- xml2::xml_find_first(xml, "//verbose")
       if(length(verbose)>0) self$verbose <- as.logical(xml2::xml_text(verbose))
     },
     
     #'@description Set enabled
     #'@param enabled enabled
     setEnabled = function(enabled){
       self$enabled = enabled
     },
     
     #'@description Set cite compliant
     #'@param citeCompliant cite compliant
     setCiteCompliant = function(citeCompliant){
       self$citeCompliant <- citeCompliant
     },
     
     #'@description Set name
     #'@param name name
     setName = function(name){
       self$name = name
     },
     
     #'@description Set title
     #'@param title title
     setTitle = function(title){
       self$title = title
     },
     
     #'@description Set maintainer
     #'@param maintainer maintainer
     setMaintainer = function(maintainer){
       self$maintainer = maintainer
     },
     
     #'@description Set abstract
     #'@param abstract abstract
     setAbstract = function(abstract){
       self$abstrct = abstract
     },
     
     #'@description Set access constraints
     #'@param accessConstraints access constraints
     setAccessConstraints = function(accessConstraints){
       self$accessConstraints = accessConstraints
     },
     
     #'@description Set fees
     #'@param fees fees
     setFees = function(fees){
       self$fees = fees
     },
     
     #'@description Set keywords
     #'@param keywords keywords
     setKeywords = function(keywords){
       if(!is.list(keywords)) keywords = list(keywords)
       self$keywords = keywords
       return(TRUE)
     },
     
     #'@description Adds a keyword
     #'@param keyword keyword
     #'@return \code{TRUE} if added, \code{FALSE} otherwise
     addKeyword = function(keyword){
       startNb = length(self$keywords)
       if(length(which(self$keywords == keyword)) == 0){
         self$keywords = c(self$keywords, keyword)
       }
       endNb = length(self$keywords)
       return(endNb == startNb+1)
     },
     
     #'@description Deletes a keyword
     #'@param keyword keyword
     #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
     delKeyword = function(keyword){
       startNb = length(self$keywords)
       self$keywords = self$keywords[which(self$keywords != keyword)]
       endNb = length(self$keywords)
       return(endNb == startNb-1)
     }
   )                       
)