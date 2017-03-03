#' Geoserver REST API GSVirtualTableGeometry
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api virtualTable
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer virtual table geometry
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSVirtualTableGeometry$new(name = "work", type = "MultiPolygon", srid = 4326)
#'
#' @field name
#' @field type
#' @field srid
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, name, type, srid)}}{
#'    This method is used to instantiate a GSVirtualTableGeometry
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSVirtualTableGeometry from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSVirtualTableGeometry to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVirtualTableGeometry <- R6Class("GSVirtualTableGeometry",
   inherit = GSRESTResource,                    
   public = list(
     name = NA,
     type = NA,
     srid = NA,
     
     initialize = function(xml = NULL, name, type, srid){
       super$initialize(rootName = "geometry")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }else{
         self$name = name
         self$type = type
         self$srid = srid
       }
     },
     
     decode = function(xml){
       names <- getNodeSet(xml, "//name")
       self$name <- xmlValue(names[[1]])
       types <- getNodeSet(xml, "//type")
       self$type <- xmlValue(types[[1]])
       srids <- getNodeSet(xml, "//srid")
       self$srid <- xmlValue(srids[[1]])
     }
     
   )                     
)