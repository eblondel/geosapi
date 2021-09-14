#' Geoserver REST API Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @importFrom openssl base64_encode
#' @import httr
#' @import XML
#' @import keyring
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
#' @field loggerType the type of logger
#' @field verbose.info if geosapi logs have to be printed
#' @field verbose.debug if curl logs have to be printed
#' @field url the Base url of GeoServer
#' @field version the version of Geoserver. Handled as \code{GSVersion} object
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, user, pwd, logger, keyring_backend)}}{
#'    This method is used to instantiate a GSManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd}). 
#'    
#'    By default, the \code{logger} argument will be set to \code{NULL} (no logger). 
#'    This argument accepts two possible values: \code{INFO}: to print only geosapi logs,
#'    \code{DEBUG}: to print geosapi and CURL logs.
#'    
#'    The \code{keyring_backend} can be set to use a different backend for storing 
#'    the Geoserver user password with \pkg{keyring} (Default value is 'env').
#'  }
#'  \item{\code{logger(type, text)}}{
#'    Basic logger to report geosapi logs. Used internally
#'  }
#'  \item{\code{INFO(text)}}{
#'    Logger to report information. Used internally
#'  }
#'  \item{\code{WARN(text)}}{
#'    Logger to report warnings. Used internally
#'  }
#'  \item{\code{ERROR(text)}}{
#'    Logger to report errors. Used internally
#'  }
#'  \item{\code{getUrl()}}{
#'    Get the authentication URL
#'  }
#'  \item{\code{connect()}}{
#'    This methods attempts a connection to GeoServer REST API. User internally
#'    during initialization of \code{GSManager}.
#'  }
#'  \item{\code{reload()}}{
#'    Reloads the GeoServer catalog.
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
    keyring_backend = NULL,
    keyring_service = NULL,
    user = NA
  ),
                     
  public = list(
    #logger
    verbose.info = FALSE,
    verbose.debug = FALSE,
    loggerType = NULL,
    logger = function(type, text){
      if(self$verbose.info){
        cat(sprintf("[geosapi][%s] %s \n", type, text))
      }
    },
    INFO = function(text){self$logger("INFO", text)},
    WARN = function(text){self$logger("WARN", text)},
    ERROR = function(text){self$logger("ERROR", text)},
    
    #manager
    url = NA,
    version = NULL,
    initialize = function(url, user, pwd, logger = NULL,
                          keyring_backend = 'env'){
      
      private$keyring_backend <- keyring:::known_backends[[keyring_backend]]$new()
      private$keyring_service <- paste0("geosapi@", url)
      
      #logger
      if(!missing(logger)){
        if(!is.null(logger)){
          self$loggerType <- toupper(logger)
          if(!(self$loggerType %in% c("INFO","DEBUG"))){
            stop(sprintf("Unknown logger type '%s", logger))
          }
          if(self$loggerType == "INFO"){
            self$verbose.info = TRUE
          }else if(self$loggerType == "DEBUG"){
            self$verbose.info = TRUE
            self$verbose.debug = TRUE
          }
        }
      }
      
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
      private$keyring_backend$set_with_value(private$keyring_service, username = user, password = pwd)
      
      #try to connect
      if(self$getClassName() == "GSManager"){
        
        #test connection
        self$connect()
      
        #inherit managers methods (experimenting)
        list_of_classes <- rev(ls("package:geosapi"))
        supportedManagers <- list_of_classes[regexpr("GS.+Manager", list_of_classes)>0]
        for(manager in supportedManagers){
          class <- eval(parse(text=manager))
          man <- class$new(baseUrl, user, pwd, logger)          
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
      
      #inherit GeoServer version
      self$version <- GSVersion$new(url, user, pwd)
      
      invisible(self)
      
    },
    
    #getUrl
    #---------------------------------------------------------------------------
    getUrl = function(){
      return(self$url)
    },
    
    #connect
    #---------------------------------------------------------------------------
    connect = function(){
      req <- GSUtils$GET(
        self$getUrl(), 
        private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user), 
        "/", 
        self$verbose.debug
      )
      if(status_code(req) == 401){
        err <- "Impossible to connect to GeoServer: Wrong credentials"
        self$ERROR(err)
        stop(err)
      }
      if(status_code(req) == 404){
        err <- "Impossible to connect to GeoServer: Incorrect URL or GeoServer temporarily unavailable"
        self$ERROR(err)
        stop(err)
      }
      if(status_code(req) != 200){
        err <- "Impossible to connectto Geoserver: Unexpected error"
        self$ERROR(err)
        stop(err)
      }else{
        self$INFO("Successfully connected to GeoServer!")
      }
      return(TRUE)
    },
   
    #reload
    #---------------------------------------------------------------------------
    reload = function(){
      self$INFO("Reloading GeoServer catalog")
      reloaded <- FALSE
      req <- GSUtils$POST(self$getUrl(), private$user, 
                          private$keyring_backend$get(service = private$keyring_service, username = private$user), 
                          "/reload",
                          content = NULL, contentType = "text/plain",
                          self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully reloaded GeoServer catalog!")
        reloaded <- TRUE
      }else{
        self$ERROR("Error while reloading the GeoServer catalog")
      }
      return(reloaded)
    },

    #getClassName
    #---------------------------------------------------------------------------
    getClassName = function(){
      return(class(self)[1])
    },
    
    #Resources GS managers
    #---------------------------------------------------------------------------
    getWorkspaceManager = function(){
      return(GSWorkspaceManager$new(self$getUrl(), private$user, 
                                    private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                    self$loggerType))
    },
    
    getNamespaceManager = function(){
      return(GSNamespaceManager$new(self$getUrl(), private$user, 
                                    private$keyring_backend$get(service = private$keyring_service, username = private$user)
                                    , self$loggerType))
    },
    
    getDataStoreManager = function(){
      return(GSDataStoreManager$new(self$getUrl(), private$user,
                                    private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                    self$loggerType))
    }
    
  )
                     
)
