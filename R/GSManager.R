#' Geoserver REST API Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @importFrom openssl base64_encode
#' @import httr
#' @import XML
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link{R6Class}} with methods for communication with
#' the REST API of a GeoServer instance.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#' }
#'
#' @field baseUrl the Base url of GeoServer
#' @field verbose if logs have to be printed
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, user, pwd)}}{
#'    This method is used to instantiate a GSManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd})
#'  }
#'  \item{\code{getUrl()}}{
#'    Get the authentication URL
#'  }
#'  \item{\code{connect()}}{
#'    This methods attempts a connection to GeoServer REST API. User internally
#'    during initialization of \code{GSManager}.
#'  }
#'  \item{\code{getClassName()}}{
#'    Retrieves the name of the class instance
#'  }
#'  \item{\code{getWorkspaceManager()}}{
#'    Retrieves an instance of workspace manager
#'  }
#'  \item{\code{getNamespaceManager()}}{
#'    Retrieves an instance of namespace manager
#'  }
#'  \item{\code{getDataStoreManager()}}{
#'    Retrieves an instance of datastore manager
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
GSManager <- R6Class("GSManager",
  lock_objects = FALSE,
  private = list(
    user = NA,
    pwd = NA
  ),
                     
  public = list(
    url = NA,
    verbose = TRUE,
    initialize = function(url, user, pwd, verbose = TRUE){
     
      self$verbose = verbose
      
      #baseUrl
      if(missing(url)) stop("Please provide the GeoServer base URL")
      baseUrl = url
      if(!grepl("/rest", baseUrl)){
        if(grepl("/$", baseUrl)){
          baseUrl = paste0(baseUrl, "rest")
        }else{
          baseUrl = paste(baseUrl, "rest", sep = "/")
        }
      }
      self$url = baseUrl
      private$user = user
      private$pwd = pwd
      
      #try to connect
      if(self$getClassName() == "GSManager"){
        pong = self$connect()
        if(self$verbose){
          cat("Successfully connected to GeoServer!\n")
        }
      
        #inherit managers methods (experimenting)
        list_of_classes <- rev(ls("package:geosapi"))
        supportedManagers <- list_of_classes[regexpr("GS.+Manager", list_of_classes)>0]
        for(manager in supportedManagers){
          class <- eval(parse(text=manager))
          man <- class$new(baseUrl, user, pwd, verbose)          
          list_of_methods <- rev(names(man))
          for(method in list_of_methods){
            methodObj <- man[[method]]
            if(!(method %in% names(self)) && class(methodObj) == "function"){
              self[[method]] <- methodObj
              environment(self[[method]]) <- environment(self$connect)
            } 
          }
        }
      }
      
      invisible(self)
      
    },
    
    getUrl = function(){
      return(self$url)
    },
    
    connect = function(){
      req <- GSUtils$GET(self$getUrl(), private$user, private$pwd, "/", self$verbose)
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
    },
    
    getWorkspaceManager = function(){
      return(GSWorkspaceManager$new(self$getUrl(), private$user, private$pwd))
    },
    
    getNamespaceManager = function(){
      return(GSNamespaceManager$new(self$getUrl(), private$user, private$pwd))
    },
    
    getDataStoreManager = function(){
      return(GSDataStoreManager$new(self$getUrl(), private$user, private$pwd))
    }
    
  )
                     
)