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
     #'@param xml object of class \link{xml_node-class}
     initialize = function(xml = NULL){
       super$initialize(rootName = "virtualTable")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link{xml_node-class}
     decode = function(xml){
       xml = xml2::as_xml_document(xml)
       self$name <- xml2::xml_find_first(xml, "//name") %>% xml2::xml_text()
       self$sql <- xml2::xml_find_first(xml, "//sql") %>% xml2::xml_text()
       escapeSql <- xml2::xml_find_first(xml, "//escapeSql")
       if(length(escapeSql)>0){
         self$escapeSql <- as.logical(xml2::xml_text(escapeSql))
       }
       keyColumns <- xml2::xml_find_first(xml, "//keyColumn")
       if(length(keyColumns)>0){
         self$keyColumn <- xml2::xml_text(keyColumns)
       }
       geoms <- xml2::xml_find_first(xml, "//geometry")
       if(length(geoms)>0){
         vtg <- GSVirtualTableGeometry$new(xml = geoms)
         self$setGeometry(vtg)
       }
       params <- as(xml2::xml_find_all(xml, "//parameter"), "list")
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