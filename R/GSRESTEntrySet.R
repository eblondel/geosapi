#' Geoserver REST API XML entry set
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSRESTEntrySet
#' 
#' @keywords geoserver rest api entryset
#' @return Object of \code{\link{R6Class}} for modelling a entry set
#' @format \code{\link{R6Class}} object.
#'
#' @field entryset
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSDataStore
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSRESTEntrySet from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSRESTEntrySet as XML
#'  }
#'  \item{\code{setEntryset(entryset)}}{
#'    Sets an entryset (list)
#'  }
#'  \item{\code{addEntry(key, value)}}{
#'    Adds an entry (key/value pair). Returns TRUE if added, FALSE otherwise
#'  }
#'  \item{\code{setEntry(key, value)}}{
#'    Sets an entry (key/value pair).
#'  }
#'  \item{\code{delEntry(key)}}{
#'    Deletes an entry by key. Returns TRUE if removed, FALSE otherwise
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSRESTEntrySet <- R6Class("GSRESTEntrySet",
  inherit = GSRESTResource,
  public = list(
   entryset = list(),
   
   initialize = function(rootName, xml = NULL, entryset){
     super$initialize(rootName = rootName)
     if(!missing(xml) & !is.null(xml)){
       if(!any(class(xml) %in% c("XMLInternalNode","XMLInternalDocument"))){
         stop("The argument 'xml' is not a valid XML object")
       }
       self$decode(xml)
     }else{
       if(!missing(entryset)){
         self$entryset = entryset
       }
     }
   },
   
   #decode
   #----------------------------------------------------------------------------
   decode = function(xml){
    entriesXML <- getNodeSet(xml, sprintf("//%s/entry", self$rootName))
     self$entryset = lapply(entriesXML, function(x){
       entry <- xmlValue(x)
       if(entry %in% c("true","false")){
         entry <- as.logical(entry)
       }
       return(entry)
     })
     names(self$entryset) = lapply(entriesXML, xmlGetAttr, "key")
   },
   
   #setEntrySet
   #----------------------------------------------------------------------------
   setEntryset = function(entryset){
     self$entryset = entryset
   },
   
   #addEntry
   #----------------------------------------------------------------------------
   addEntry = function(key, value){
     startNb <- length(self$entryset)
     if(length(which(names(self$entryset) == key)) == 0){
       self$entryset[[key]] <- value
     }
     endNb <- length(self$entryset)
     return(endNb == startNb+1)
   },
   
   #setEntry
   #----------------------------------------------------------------------------
   setEntry = function(key, value){
     self$entryset[[key]] <- value
   },
   
   #delEntry
   #----------------------------------------------------------------------------
   delEntry = function(key){
     startNb <- length(self$entryset)
     self$entryset = self$entryset[which(names(self$entryset) != key)]
     endNb <- length(self$entryset)
     return(endNb == startNb-1)
   }
   
  )                     
)
