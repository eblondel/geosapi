#' Geoserver REST API - Geoserver Version
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSVersion
#' @title A GeoServer version
#' @description This class allows to grab the GeoServer version. By default, a 
#' tentative is made to fetch version from web admin default page, since Geoserver 
#' REST API did not support GET operation for the Geoserver version in past releases
#' of Geoserver.
#' @keywords geoserver rest api version
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer version
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' version <- GSVersion$new(
#'              url = "http://localhost:8080/geoserver",
#'              user = "admin", pwd = "geoserver"
#'            )
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, user, pwd)}}{
#'    This method is used to instantiate a GSVersion object.
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVersion <- R6Class("GSVersion",
  
  private = list(
    getVersionValue = function(version){
      version <- gsub("x", "0", version)
      version <- gsub("\\.", "", version)
      value <- suppressWarnings(as.integer(version))
      return(value)
    }
  ),
                     
  public = list(
    version = NULL,
    value = NULL,
    initialize = function(url, user, pwd){ 
      
      #try to grab version from web admin
      req <- GET(paste(url, "web", sep = "/"))
      if(status_code(req) == 200){
        html <- htmlParse(content(req, "text", encoding = "ISO-8859-1"))
        trgSet <- getNodeSet(html, "//strong")
        if(length(trgSet) > 0){
          version <- xmlValue(trgSet[[1]])
          value <- private$getVersionValue(version)
          if(!is.na(value) & is.integer(value)){
            self$version <- version
            self$value <- value
          }
        }
      }
      
      #try to grab version from REST API
      if(is.null(self$version) & is.null(self$value)){
        req <- GSUtils$GET(url, user, pwd, "/rest/about/version.xml", FALSE)
        if(status_code(req) == 200){
          xml <- xmlParse(content(req, "text", encoding = "UTF-8"))
          trgSet <- getNodeSet(xml, "//resource[@name='GeoServer']/Version")
          if(length(trgSet) > 0){
            version <- xmlValue(trgSet[[1]])
            value <- private$getVersionValue(version)
            if(!is.na(value) & is.integer(value)){
              self$version <- version
              self$value <- value
            }
          }
        }
      }
    },
    
    lowerThan = function(version){
      lower <- FALSE
      if(is.character(version)){
        value <- private$getVersionValue(version)
        lower <- (self$value < value)
      }else if(is.numeric(version)){
        lower <- (self$value < version)
      }
      return(lower)
    },
    
    greaterThan = function(version){
      greater <- FALSE
      if(is.character(version)){
        value <- private$getVersionValue(version)
        greater <- (self$value > value)
      }else if(is.numeric(version)){
        greater <- (self$value > version)
      }
      return(greater)
    }
  
  )                  
)