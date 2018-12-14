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
#' settings <- GSWorkspaceSettings$new()
#' settings$setCharset("UTF-8")
#' settings$setNumDecimals(5)
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a \code{GSWorkspaceSettings}. This settings 
#'    object is required to activate a workspace configuration, using the method
#'    \code{GSManager$createWorkspaceSettings}. Supported from GeoServer 2.12
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a \code{GSWorkspaceSettings} from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a \code{GSWorkspaceSettings} to XML. 
#'    Inherited from the generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setCharset(charset)}}{
#'    Set charset
#'  }
#'  \item{\code{setNumDecimals(numDecimals)}}{
#'    Set number of decimals
#'  }
#'  \item{\code{setOnlineResource(onlineResource)}}{
#'    Set the online resource
#'  }
#'  \item{\code{setVerbose(verbose)}}{
#'    Set verbose
#'  }
#'  \item{\code{setVerboseExceptions(verboseExceptions)}}{
#'    Set verbose exceptions
#'  }
#'  \item{\code{setLocalWorkspaceIncludesPrefix(includesPrefix)}}{
#'    Set if the Local workspace includes prefix
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSWorkspaceSettings <- R6Class("GSWorkspaceSettings",
   inherit = GSRESTResource,                    
   public = list(
     contact = NULL,
     charset = "UTF-8",
     numDecimals = 8,
     onlineResource = NULL,
     verbose = FALSE,
     verboseExceptions = FALSE,
     localWorkspaceIncludesPrefix = TRUE,
     initialize = function(xml = NULL){
       super$initialize(rootName = "settings")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     decode = function(xml){
       charset <- getNodeSet(xml, "//charset")
       if(length(charset)>0) self$charset <- xmlValue(charset[[1]])
       numDecimals <- getNodeSet(xml, "//numDecimals")
       if(length(numDecimals)>0) self$numDecimals <- xmlValue(numDecimals[[1]])
       onlineResource <- getNodeSet(xml, "//onlineResource")
       if(length(onlineResource)>0) self$onlineResource <- xmlValue(onlineResource[[1]])
       verbose <- getNodeSet(xml, "//verbose")
       if(length(verbose)>0) self$verbose <- as.logical(toupper(xmlValue(verbose[[1]])))
       verboseExceptions <- getNodeSet(xml, "//verboseExceptions")
       if(length(verboseExceptions)>0) self$verboseExceptions <- as.logical(toupper(xmlValue(verboseExceptions[[1]])))
       includesPrefix <- getNodeSet(xml, "//localWorkspaceIncludesPrefix")
       if(length(includesPrefix)>0) self$localWorkspaceIncludesPrefix <- as.logical(toupper(xmlValue(includesPrefix[[1]])))
     },
     
     setCharset = function(charset){
       self$charset <- charset
     },
     
     setNumDecimals = function(numDecimals){
       self$numDecimals <- numDecimals
     },
     
     setOnlineResource = function(onlineResource){
       self$onlineResource <- onlineResource
     },
     
     setVerbose = function(verbose){
       self$verbose <- verbose
     },
     
     setVerboseExceptions = function(verboseExceptions){
       self$verboseExceptions <- verboseExceptions
     },
     
     setLocalWorkspaceIncludesPrefix = function(includesPrefix){
       self$localWorkspaceIncludesPrefix <- includesPrefix
     }
     
   )                     
)