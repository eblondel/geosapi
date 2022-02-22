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
#'                             regexpValidator = "someregexp")
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVirtualTableParameter <- R6Class("GSVirtualTableParameter",
  inherit = GSRESTResource,                    
  public = list(
    #' @field name parameter name
    name = NA,
    #' @field defaultValue parameter default value
    defaultValue = NA,
    #' @field regexpValidator parameter regexp validator
    regexpValidator = NA,
    
    #'@description Initializes an object of class \link{GSVirtualTableParameter}
    #'@param xml object of class \link{XMLInternalNode-class}
    #'@param name name
    #'@param defaultValue default value
    #'@param regexpValidator regexp validator
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
    
    #'@description Decodes from XML
    #'@param xml object of class \link{XMLInternalNode-class}
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