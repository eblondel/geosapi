#' Geoserver REST API Manager Utils
#'
#' @docType class
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link{R6Class}} with static util methods for communication
#' with the REST API of a GeoServer instance.
#' @format \code{\link{R6Class}} object.
#'
#' @section Static methods:
#' \describe{
#'  \item{\code{getUserAgent()}}{
#'    This method is used to get the user agent for performing GeoServer API requests.
#'    Here the user agent will be compound by geosapi package name and version.
#'  }
#'  \item{\code{getUserToken(user, pwd)}}{
#'    This method is used to get the user authentication token for performing GeoServer
#'    API requests. Token is given a Base64 encoded string.
#'  }
#'  \item{\code{GET(url, user, pwd, path, verbose)}}{
#'    This method performs a GET request for a given \code{path} to GeoServer REST API
#'  }
#'  \item{\code{PUT(url, user, pwd, path, filename, contentType, verbose)}}{
#'    This method performs a PUT request for a given \code{path} to GeoServer REST API,
#'    to upload a file of name \code{filename} with given \code{contentType}
#'  }
#'  \item{\code{POST(url, user, pwd, path, content, contentType, verbose)}}{
#'    This method performs a POST request for a given \code{path} to GeoServer REST API,
#'    to post content of given \code{contentType}
#'  }
#'  \item{\code{DELETE(url, user, pwd, path, verbose)}}{
#'    This method performs a DELETE request for a given GeoServer resource identified
#'    by a \code{path} in GeoServer REST API
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSUtils <- R6Class("GSUtils")

GSUtils$getUserAgent <- function(){
  return(paste("geosapi", packageVersion("geosapi"), sep="-"))
}

GSUtils$getUserToken <- function(user, pwd){
  token <- openssl::base64_encode(charToRaw(paste(user, pwd, sep=":")))
  return(token)
}

GSUtils$GET <- function(url, user, pwd, path, verbose = TRUE){
  #TODO activate verbose argument
  if(!grepl("^/", path)) path = paste0("/", path)
  url <- paste0(url, path) 
  req <- httr::GET(
    url = url,
    add_headers(
      "User-Agent" = GSUtils$getUserAgent(),
      "Authorization" = paste("Basic", GSUtils$getUserToken(user, pwd))
    ),    
    verbose()
  )
  return(req)
}

GSUtils$PUT <- function(url, user, pwd, path, filename, contentType, verbose = TRUE){
  #TODO activate verbose argument
  if(!grepl("^/", path)) path = paste0("/", path)
  url <- paste0(url, path)
  req <- httr::PUT(
    url = url,
    add_headers(
      "User-Agent" = GSUtils$getUserAgent(),
      "Authorization" = paste("Basic", GSUtils$getUserToken(user, pwd)),
      "Content-type" = contentType
    ),    
    body = upload_file(filename),
    verbose()
  )
  return(req)
}

GSUtils$POST <- function(url, user, pwd, path, content, contentType, verbose = TRUE){
  #TODO activate verbose argument
  if(!grepl("^/", path)) path = paste0("/", path)
  url <- paste0(url, path)
  req <- httr::POST(
    url = url,
    add_headers(
      "User-Agent" = GSUtils$getUserAgent(),
      "Authorization" = paste("Basic", GSUtils$getUserToken(user, pwd)),
      "Content-type" = contentType
    ),    
    body = content,
    verbose()
  )
  return(req)
}

GSUtils$DELETE <- function(url, user, pwd, path, verbose = TRUE){
  #TODO activate verbose argument
  if(!grepl("^/", path)) path = paste0("/", path)
  url <- paste0(url, path)
  req <- httr::DELETE(
    url = url,
    add_headers(
      "User-Agent" = GSUtils$getUserAgent(),
      "Authorization" = paste("Basic", GSUtils$getUserToken(user, pwd))
    ),
    verbose()
  )
  return(req)
}