#' Geoserver REST API Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @importFrom openssl base64_encode
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link{R6Class}} with methods for communication with
#' the REST API of a GeoServer instance.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' GSManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'
#' @field baseUrl the base URL of the GeoServer REST API
#' @field token the authentication token used to connect to Geoserver
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, user, pwd)}}{
#'    This method is used to instantiate a GSManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd})
#'  }
#'  \item{\code{getBaseUrl()}}{
#'    This method gives the base URL of the GeoServer REST API.
#'  }
#'  \item{\code{getToken()}}{
#'    This method gives the authentication token to connect to Geoserver
#'  }
#'  \item{\code{GET(path)}}{
#'    This method performs a GET request for a given \code{path} to GeoServer REST API
#'  }
#'  \item{\code{PUT(path, filename, contentType)}}{
#'    This method performs a PUT request for a given \code{path} to GeoServer REST API,
#'    to upload a file of name \code{filename} with given \code{contentType}
#'  }
#'  \item{\code{connect()}}{
#'    This methods attempts a connection to GeoServer REST API. User internally
#'    during initialization of \code{GSManager}.
#'  }
#'  \item{\code{getClassName()}}{
#'    Retrieves the name of the class instance
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSManager <- R6Class("GSManager",
 
  private = list(
    userAgent = paste("geosapi", packageVersion("geosapi"), sep="-"),
    baseUrl = NA,
    token = NA
  ),

  public = list(
    verbose = TRUE,
    initialize = function(url, user, pwd, verbose = TRUE){
     
      self$verbose = verbose
      
      #baseUrl
      if(missing(url)) stop("Please provide the GeoServer base URL")
      baseUrl = url
      if(grepl("/$", baseUrl)){
        baseUrl = paste0(baseUrl, "rest")
      }else{
        baseUrl = paste(baseUrl, "rest", sep = "/")
      }  
      private$baseUrl = baseUrl
      
      #credentials
      private$token = openssl::base64_encode(charToRaw(paste(user, pwd, sep=":")))
      
      #try to connect
      if(self$getClassName() == "GSManager"){
        pong = self$connect()
        if(self$verbose){
          cat("Successfully connected to GeoServer!\n")
        }
      }
      
    },
    
    getBaseUrl = function(){
      return(private$baseUrl)
    },
    
    getToken = function(){
      return(private$token)
    },
    
    GET = function(path){
      if(!grepl("^/", path)) path = paste0("/", path)
      url <- paste0(self$getBaseUrl(), path) 
      req <- httr::GET(
        url = url,
        add_headers(
          "User-Agent" = private$userAgent,
          "Authorization" = paste("Basic", self$getToken())
        ),    
        verbose(data_out = self$verbose)
      )
      return(req)
    },
    
    PUT = function(path, filename, contentType){
      if(!grepl("^/", path)) path = paste0("/", path)
      url <- paste0(self$getBaseUrl(), path)
      req <- httr::PUT(
        url = url,
        add_headers(
          "User-Agent" = private$userAgent,
          "Authorization" = paste("Basic", self$getToken()),
          "Content-type" = contentType
        ),    
        body = upload_file(filename),
        verbose()
      )
      return(req)
    },
    
    connect = function(){
      req <- self$GET("/")
      if(status_code(req) == 401){
        stop("Impossible to connect to GeoServer: Wrong credentials")
      }
      if(status_code(req) == 404){
        stop("Impossible to connect to GeoServer: Incorrect URL or GeoServer temporarily unavailable")
      }
      if(status_code(req) != 200){
        stop("Impossible to connectto Geoserver: Unexpected error")
      }
      return(TRUE)
    },
    
    getClassName = function(){
      return(class(self)[1])
    }
    
  )
                     
)