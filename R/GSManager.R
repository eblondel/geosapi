#' Geoserver REST API Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @importFrom openssl base64_encode
#' @import httr
#' @import xml2
#' @import keyring
#' @import cli
#' @import magrittr
#' @importFrom readr read_csv
#' @importFrom readr write_csv
#' @export
#' @keywords geoserver rest api
#' @return Object of \code{\link[R6]{R6Class}} with methods for communication with
#' the REST API of a GeoServer instance.
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
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
    
    #' @field verbose.info if geosapi logs have to be printed
    verbose.info = FALSE,
    #' @field verbose.debug if curl logs have to be printed
    verbose.debug = FALSE,
    #' @field loggerType the type of logger
    loggerType = NULL,
    
    #'@description Prints a log message
    #'@param type type of log, "INFO", "WARN", "ERROR"
    #'@param text text
    logger = function(type, text){
      if(self$verbose.info){
        cat(sprintf("[geosapi][%s] %s \n", type, text))
      }
    },
    
    #'@description Prints an INFO log message
    #'@param text text
    INFO = function(text){self$logger("INFO", text)},
    
    #'@description Prints an WARN log message
    #'@param text text
    WARN = function(text){self$logger("WARN", text)},
    
    #'@description Prints an ERROR log message
    #'@param text text
    ERROR = function(text){self$logger("ERROR", text)},
    
    #' @field url the Base url of GeoServer
    url = NA,
    #' @field version the version of Geoserver. Handled as \code{GSVersion} object
    version = NULL,
    
    #'@description This method is used to instantiate a GSManager with the \code{url} of the
    #'    GeoServer and credentials to authenticate (\code{user}/\code{pwd}). 
    #'    
    #'    By default, the \code{logger} argument will be set to \code{NULL} (no logger). 
    #'    This argument accepts two possible values: \code{INFO}: to print only geosapi logs,
    #'    \code{DEBUG}: to print geosapi and CURL logs.
    #'    
    #'    The \code{keyring_backend} can be set to use a different backend for storing 
    #'    the Geoserver user password with \pkg{keyring} (Default value is 'env').
    #'@param url url
    #'@param user user
    #'@param pwd pwd
    #'@param logger logger
    #'@param keyring_backend keyring backend. Default is 'env'
    initialize = function(url, user, pwd, logger = NULL,
                          keyring_backend = 'env'){
      
      if(!keyring_backend %in% names(keyring:::known_backends)){
        errMsg <- sprintf("Backend '%s' is not a known keyring backend!", keyring_backend)
        self$ERROR(errMsg)
        stop(errMsg)
      }
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
        list_of_classes <- ls(getNamespaceInfo("geosapi", "exports"))
        supportedManagers <- list_of_classes[regexpr("GS.+Manager", list_of_classes)>0]
        for(manager in supportedManagers){
          class <- eval(parse(text = paste0("geosapi::", manager)))
          man <- class$new(baseUrl, user, pwd, logger)          
          list_of_methods <- rev(names(man))
          for(method in list_of_methods){
            methodObj <- man[[method]]
            if(!(method %in% names(self)) && is(methodObj,"function")){
              self[[method]] <- methodObj
              environment(self[[method]]) <- environment(self$connect)
            } 
          }
        }
      }
      
      #inherit GeoServer version
      self$version <- GSVersion$new(baseUrl, user, pwd)
      
      invisible(self)
      
    },
    
    #'@description Get URL
    #'@return the Geoserver URL
    getUrl = function(){
      return(self$url)
    },
    
    #'@description Connects to geoServer
    #'@return \code{TRUE} if connected, raises an error otherwise
    connect = function(){
      req <- GSUtils$GET(
        url = self$getUrl(), 
        user = private$user, 
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user), 
        path = "",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 401){
        err <- "Impossible to connect to GeoServer: Wrong credentials"
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      if(status_code(req) == 404){
        err <- "Impossible to connect to GeoServer: Incorrect URL or GeoServer temporarily unavailable"
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      if(status_code(req) != 200){
        err <- sprintf("Impossible to connect to Geoserver: Unexpected error (status code %s)", status_code(req))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }else{
        msg = "Successfully connected to GeoServer!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }
      return(TRUE)
    },
   
    #'@description Reloads the GeoServer catalog
    #'@return \code{TRUE} if reloaded, \code{FALSE} otherwise
    reload = function(){
      msg = "Reloading GeoServer catalog"
      cli::cli_alert_info(msg)
      self$INFO(msg)
      reloaded <- FALSE
      req <- GSUtils$POST(self$getUrl(), private$user, 
                          private$keyring_backend$get(service = private$keyring_service, username = private$user), 
                          "/reload",
                          content = NULL, contentType = "text/plain",
                          self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfully reloaded GeoServer catalog!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        reloaded <- TRUE
      }else{
        err = "Error while reloading the GeoServer catalog"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(reloaded)
    },
    
    #'@description Get system status
    #'@return an object of class \code{data.frame} given the date time and metrics value
    getSystemStatus = function(){
      msg = "Get system status"
      cli::cli_alert_info(msg)
      self$INFO(msg)
      datetime <- Sys.time()
      req <- GSUtils$GET(self$getUrl(), private$user, 
                         private$keyring_backend$get(service = private$keyring_service, username = private$user),
                         "/about/system-status",
                         contentType = "application/json",
                         self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfully fetched system status"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching system status"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      content <- httr::content(req)
      status <- list(
        raw = do.call("rbind", lapply(content$metrics$metric, function(metric){
          met <- data.frame(metric, stringsAsFactors = FALSE)
          return(met)
        }))
      )
      status$values = {
        df <- cbind(time = datetime, data.frame(t(status$raw$value), stringsAsFactors = F))
        colnames(df) <- c("TIME", status$raw$identifier)
        df
      }

      return(status)
    },
    
    #'@description Monitors the Geoserver by launching a small shiny monitoring application
    #'@param file file where to store monitoring results
    #'@param append whether to append results to existing files
    #'@param sleep sleeping interval to trigger a system status call
    monitor = function(file = NULL, append = FALSE, sleep = 1){
      monitor <- GSShinyMonitor$new(manager = self, file = file, append = append, sleep = sleep)
      monitor$run()
    },

    #'@description Get class name
    #'@return the self class name, as \code{character}
    getClassName = function(){
      return(class(self)[1])
    },
    
    #Resources GS managers
    #---------------------------------------------------------------------------
    
    #'@description Get Workspace manager
    #'@return an object of class \link{GSWorkspaceManager}
    getWorkspaceManager = function(){
      return(GSWorkspaceManager$new(self$getUrl(), private$user, 
                                    private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                    self$loggerType))
    },
    
    #'@description Get Namespace manager
    #'@return an object of class \link{GSNamespaceManager}
    getNamespaceManager = function(){
      return(GSNamespaceManager$new(self$getUrl(), private$user, 
                                    private$keyring_backend$get(service = private$keyring_service, username = private$user)
                                    , self$loggerType))
    },
    
    #'@description Get Datastore manager
    #'@return an object of class \link{GSDataStoreManager}
    getDataStoreManager = function(){
      return(GSDataStoreManager$new(self$getUrl(), private$user,
                                    private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                    self$loggerType))
    },
    
    #'@description Get Coverage store manager
    #'@return an object of class \link{GSCoverageStoreManager}
    getCoverageStoreManager = function(){
      return(GSCoverageStoreManager$new(self$getUrl(), private$user,
                                    private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                    self$loggerType))
    },
    
    #'@description Get service manager
    #'@return an object of class \link{GSServiceManager}
    getServiceManager = function(){
      return(GSServiceManager$new(self$getUrl(), private$user,
                                private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                self$loggerType))      
    },
    
    #'@description Get style manager
    #'@return an object of class \link{GSStyleManager}
    getStyleManager = function(){
      return(GSStyleManager$new(self$getUrl(), private$user,
                                        private$keyring_backend$get(service = private$keyring_service, username = private$user),
                                        self$loggerType))      
    }
    
  )
                     
)
