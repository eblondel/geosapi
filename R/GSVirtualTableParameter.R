#' Geoserver REST API GSVirtualTableParameter
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api virtualTable
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer virtual table parameter
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSVirtualTableParameter$new(name = "fieldname", defaultValue = "default_value",
#'                             regexpValidator = "^[\/w\/d\/s]+$")
#'
#' @field name
#' @field defaultValue
#' @field regexpValidator
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, name, defaultValue, regexpValidator}}{
#'    This method is used to instantiate a GSVirtualTableParameter
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSVirtualTableParameter from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSVirtualTableParameter to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVirtualTableParameter <- R6Class("GSVirtualTableParameter",
  inherit = GSRESTResource,                    
  public = list(
    name = NA,
    defaultValue = NA,
    regexpValidator = NA,
    
    initialize = function(xml = NULL, name, defaultValue, regexpValidator){
      super$initialize(rootName = "parameter")
      if(!missing(xml) & !is.null(xml)){
        self$decode(xml)
      }else{
        self$name = name
        self$defaultValue = defaultValue
        self$regexpValidator = regexpValidator
      }
    },
    
    decode = function(xml){
      names <- getNodeSet(xml, "//name")
      self$name <- xmlValue(names[[1]])
      defaultValues <- getNodeSet(xml, "//defaultValue")
      self$defaultValue <- xmlValue(defaultValues[[1]])
      regexpValidators <- getNodeSet(xml, "//regexpValidator")
      self$regexpValidator <- xmlValue(regexpValidators[[1]])
    }
    
  )                     
)