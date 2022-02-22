#' Geoserver REST API Workspace Setting
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api workspace settings
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer workspace settings
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   settings <- GSWorkspaceSettings$new()
#'   settings$setCharset("UTF-8")
#'   settings$setNumDecimals(5)
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorkspaceSettings <- R6Class("GSWorkspaceSettings",
   inherit = GSRESTResource,                    
   public = list(
     #'@field contact contact
     contact = NULL,
     #'@field charset charset
     charset = "UTF-8",
     #'@field numDecimals number of decimal
     numDecimals = 8,
     #'@field onlineResource online resource
     onlineResource = NULL,
     #'@field verbose verbose
     verbose = FALSE,
     #'@field verboseExceptions verbose exceptions
     verboseExceptions = FALSE,
     #'@field localWorkspaceIncludesPrefix local workspace includes prefix
     localWorkspaceIncludesPrefix = TRUE,
     
     #'@description This method is used to instantiate a \code{GSWorkspaceSettings}. This settings 
     #'    object is required to activate a workspace configuration, using the method
     #'    \code{GSManager$createWorkspaceSettings}. Supported from GeoServer 2.12
     #' @param xml object of class \link{XMLInternalNode-class}
     initialize = function(xml = NULL){
       super$initialize(rootName = "settings")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link{XMLInternalNode-class}
     decode = function(xml){
       charset <- getNodeSet(xml, "//charset")
       if(length(charset)>0) self$charset <- xmlValue(charset[[1]])
       numDecimals <- getNodeSet(xml, "//numDecimals")
       if(length(numDecimals)>0) self$numDecimals <- as.integer(xmlValue(numDecimals[[1]]))
       onlineResource <- getNodeSet(xml, "//onlineResource")
       if(length(onlineResource)>0) self$onlineResource <- xmlValue(onlineResource[[1]])
       verbose <- getNodeSet(xml, "//verbose")
       if(length(verbose)>0) self$verbose <- as.logical(toupper(xmlValue(verbose[[1]])))
       verboseExceptions <- getNodeSet(xml, "//verboseExceptions")
       if(length(verboseExceptions)>0) self$verboseExceptions <- as.logical(toupper(xmlValue(verboseExceptions[[1]])))
       includesPrefix <- getNodeSet(xml, "//localWorkspaceIncludesPrefix")
       if(length(includesPrefix)>0) self$localWorkspaceIncludesPrefix <- as.logical(toupper(xmlValue(includesPrefix[[1]])))
     },
     
     #'@description Set charset
     #'@param charset charset
     setCharset = function(charset){
       self$charset <- charset
     },
     
     #'@description Set number of decimals
     #'@param numDecimals number of decimals
     setNumDecimals = function(numDecimals){
       self$numDecimals <- numDecimals
     },
     
     #'@description Set online resource
     #'@param onlineResource online resource
     setOnlineResource = function(onlineResource){
       self$onlineResource <- onlineResource
     },
     
     #'@description Set verbose
     #'@param verbose verbose
     setVerbose = function(verbose){
       self$verbose <- verbose
     },
     
     #'@description Set verbose exceptions
     #'@param verboseExceptions verbose exceptions
     setVerboseExceptions = function(verboseExceptions){
       self$verboseExceptions <- verboseExceptions
     },
     
     #'@description Set local workspace includes prefix
     #'@param includesPrefix includes prefix
     setLocalWorkspaceIncludesPrefix = function(includesPrefix){
       self$localWorkspaceIncludesPrefix <- includesPrefix
     }
     
   )                     
)