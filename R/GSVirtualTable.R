#' Geoserver REST API GSVirtualTable
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api virtualTable
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer virtual table
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSVirtualTable$new()
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml)}}{
#'    This method is used to instantiate a GSVirtualTable
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSVirtualTable from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSVirtualTable to XML
#'  }
#'  \item{\code{setName(name)}}{
#'    Sets the name of the virtual table
#'  }
#'  \item{\code{setSql(sql)}}{
#'    Sets the sql of the virtual table
#'  }
#'  \item{\code{setEscapeSql(escapeSql)}}{
#'    Sets the escapeSql. Default is FALSE
#'  }
#'  \item{\code{setKeyColumn(keyColumn)}}{
#'    Sets the keyColumn. Name of the column to be the primary key
#'  }
#'  \item{\code{setGeometry(vtg)}}{
#'    Sets the virtual table geometry
#'  }
#'  \item{\code{addParameter(parameter)}}{
#'    Adds a virtual table parameter
#'  }
#'  \item{\code{delParameter(parameter)}}{
#'    Removes a virtual table parameter.
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVirtualTable <- R6Class("GSVirtualTable",
   inherit = GSRESTResource,                    
   public = list(
      #' @field name name
     name = NA,
     #' @field sql SQL statement
     sql = NA,
     #' @field escapeSql escape SQL?
     escapeSql = FALSE,
     #' @field keyColumn key column
     keyColumn = NULL,
     #' @field geometry geometry
     geometry = NULL,
     #' @field parameters list of virtual parameters
     parameters = list(),
     
     #'@description Initializes an object of class \link{GSVirtualTable}
     #'@param xml object of class \link{XMLInternalNode-class}
     initialize = function(xml = NULL){
       super$initialize(rootName = "virtualTable")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link{XMLInternalNode-class}
     decode = function(xml){
       names <- getNodeSet(xml, "//name")
       self$name <- xmlValue(names[[1]])
       sql <- getNodeSet(xml, "//sql")
       self$sql <- xmlValue(sql[[1]])
       escapeSql <- getNodeSet(xml, "//escapeSql")
       if(length(escapeSql)>0){
         self$escapeSql <- as.logical(xmlValue(escapeSql[[1]]))
       }
       keyColumns <- getNodeSet(xml, "//keyColumn")
       if(length(keyColumns)>0){
         self$keyColumn <- xmlValue(keyColumns[[1]])
       }
       geoms <- getNodeSet(xml, "//geometry")
       if(length(geoms)>0){
         vtg <- GSVirtualTableGeometry$new(xml = geoms[[1]])
         self$setGeometry(vtg)
       }
       params <- getNodeSet(xml, "//parameter")
       if(length(params)>0){
        for(param in params){
          vtp <- GSVirtualTableParameter$new(xml = param)
          self$addParameter(vtp)
        }
       }   
     },
     
     #'@description Set name
     #'@param name name
     setName = function(name){
       self$name = name
     },
     
     #'@description Set SQL
     #'@param sql sql
     setSql = function(sql){
       self$sql = sql
     },
     
     #'@description Set escape SQL
     #'@param escapeSql escape SQL
     setEscapeSql = function(escapeSql){
       self$escapeSql = escapeSql
     },
     
     #'@description Set key column
     #'@param keyColumn key column
     setKeyColumn = function(keyColumn){
       self$keyColumn = keyColumn
     },
     
     #'@description Set geometry
     #'@param vtg object of class \link{GSVirtualTableGeometry}
     setGeometry = function(vtg){
       self$geometry = vtg
     },
     
     #'@description Adds parameter
     #'@param parameter object of class \link{GSVirtualTableParameter}
     #'@return \code{TRUE} if added, \code{FALSE} otherwise
     addParameter = function(parameter){
       startNb = length(self$parameters)
       availableParams <- sapply(self$parameters, function(x){x$name})
       if(length(which(availableParams == parameter$name)) == 0){
         self$parameters = c(self$parameters, parameter)
       }
       endNb = length(self$parameters)
       return(endNb == startNb+1)
     },
    
     #'@description Deletes parameter
     #'@param parameter object of class \link{GSVirtualTableParameter}
     #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
     delParameter = function(parameter){
       startNb = length(self$parameters)
       availableParams <- sapply(self$parameters, function(x){x$name})
       self$parameters = self$parameters[which(availableParams != parameter$name)]
       endNb = length(self$parameters)
       return(endNb == startNb-1)
     }
     
   )                     
)