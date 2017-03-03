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
#' @field name
#' @field sql
#' @field escapeSql
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
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVirtualTable <- R6Class("GSVirtualTable",
   inherit = GSRESTResource,                    
   public = list(
     name = NA,
     sql = NA,
     escapeSql = FALSE,
     keyColumn = NA,
     
     initialize = function(xml = NULL){
       super$initialize(rootName = "virtualTable")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     decode = function(xml){
       #TODO
     },
     
     setName = function(name){
       self$name = name
     },
     
     setSql = function(sql){
       self$sql = sql
     },
     
     setEscapeSql = function(escapeSql){
       self$escapeSql = escapeSql
     },
     
     setKeyColumn = function(keyColumn){
       self$keyColumn = keyColumn
     },
     
     setGeometry = function(vtg){
       #TODO
     },
     
     addParameter = function(parameter){
       #TODO
     }
     
   )                     
)