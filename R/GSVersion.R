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
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer version
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#' version <- GSVersion$new(
#'              url = "http://localhost:8080/geoserver",
#'              user = "admin", pwd = "geoserver"
#'            )
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSVersion <- R6Class("GSVersion",
  
  private = list(
    getVersionValue = function(version){
      version <- gsub("x", "0", version)
      version <- gsub("-SNAPSHOT", "", version)
      versions <- unlist(strsplit(version, "\\."))
      value <- list()
      value[["major"]] <- as.integer(versions[1])
      value[["minor"]] <- as.integer(versions[2])
      value[["revision"]] <- 0
      if(length(versions)==3){
        value[["revision"]] <- as.integer(versions[3])
      }
      return(value)
    }
  ),
                     
  public = list(
    #'@field version version
    version = NULL,
    #'@field value value
    value = NULL,
    
    #'@description Initializes an object of class \link{GSVersion}
    #'@param url url
    #'@param user user
    #'@param pwd pwd
    initialize = function(url, user, pwd){ 
      
      #try to grab version from web admin
      req <- httr::GET(paste(dirname(url), "web", sep = "/"))
      if(status_code(req) == 200){
        html <- xml2::read_html(content(req, "text", encoding = "ISO-8859-1"))
        trgSet <- xml2::xml_find_first(html, "//strong")
        if(length(trgSet) > 0){
          version <- xml2::xml_text(trgSet)
          value <- private$getVersionValue(version)
          if(is.list(value)){
            self$version <- version
            self$value <- value
          }
        }
      }
      
      #try to grab version from REST API
      if(is.null(self$version) & is.null(self$value)){
        req <- GSUtils$GET(url, user, pwd, "about/version.xml", verbose = FALSE)
        if(status_code(req) == 200){
          xml <- httr::content(req, encoding = "UTF-8")
          trgSet <- xml2::xml_find_first(xml, "//resource[@name='GeoServer']/Version")
          if(length(trgSet) > 0){
            version <- xml2::xml_text(trgSet)
            value <- private$getVersionValue(version)
            if(is.list(value)){
              self$version <- version
              self$value <- value
            }
          }
        }
      }
    },
    
    #'@description  Compares to a version and returns TRUE if it is lower, FALSE otherwise
    #'@param version version
    #'@return \code{TRUE} if lower, \code{FALSE} otherwise
    lowerThan = function(version){
      lower <- FALSE
      if(is.character(version)){
        value <- private$getVersionValue(version)
      }else if(is.list(version)){
        value <- version
      }
      lower <- (self$value$major < value$major)
      if(!lower & identical(self$value$major, value$major)){
        lower <- (self$value$minor < value$minor)
      }
      if(!lower & identical(self$value$minor, value$minor)){
        lower <- (self$value$revision < value$revision)
      }
      return(lower)
    },

    #'@description  Compares to a version and returns TRUE if it is greater, FALSE otherwise
    #'@param version version
    #'@return \code{TRUE} if greater, \code{FALSE} otherwise
    greaterThan = function(version){
      greater <- FALSE
      if(is.character(version)){
        value <- private$getVersionValue(version)
      }else if(is.list(version)){
        value <- version
      }
      greater <- (self$value$major > value$major)
      if(!greater & identical(self$value$major, value$major)){
        greater <- (self$value$minor > value$minor)
      } 
      if(!greater & identical(self$value$minor, value$minor)){
        greater <- (self$value$revision > value$revision)
      }
      return(greater)
    },
    
    #'@description  Compares to a version and returns TRUE if it is equal, FALSE otherwise
    #'@param version version
    #'@return \code{TRUE} if equal, \code{FALSE} otherwise
    equalTo = function(version){
      equal <- FALSE
      if(is.character(version)){
        value <- private$getVersionValue(version)
      }else if(is.list(version)){
        value <- version
      }
      equal <- !self$lowerThan(version) & !self$greaterThan(version)
      return(equal)
    }
  
  )                  
)
