#' Geoserver REST API CoverageStore Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api CoverageStore
#' @return Object of \code{\link{R6Class}} with methods for managing GeoServer
#' CoverageStores (i.e. stores of coverage data)
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSCoverageStoreManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'  }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSCoverageStoreManager <- R6Class("GSCoverageStoreManager",
  inherit = GSManager,
  
  public = list(   
    
    #CoverageStore generic CRUD methods
    #===========================================================================
    
    #'@description Get the list of available coverage stores. Returns an object of class \code{list}
    #'    giving items of class \code{\link{GSAbstractCoverageStore}}
    #'@param ws workspace name
    #'@return the list of coverage stores
    getCoverageStores = function(ws){
      msg = sprintf("Fetching list of coverage stores in workspace '%s'", ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores.xml", ws),
        verbose = self$verbose.debug)
      covList <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        covXMLList <- as(xml2::xml_find_all(covXML, "//coverageStore"), "list")
        covList <- lapply(covXMLList, function(xml){
          covType <- xml2::xml_find_first(xml, "//type") %>% xml2::xml_text()
          coverageStore <- switch(covType,
            "GeoTIFF" = GSGeoTIFFCoverageStore$new(xml = xml),
            "WorldImage" = GSWorldImageCoverageStore$new(xml = xml),
            "ImageMosaic" = GSImageMosaicCoverageStore$new(xml = xml),
            "ArcGrid" = GSArcGridCoverageStore$new(xml = xml),
            GSAbstractCoverageStore$new(xml = xml)
          )
          return(coverageStore)
        })
        msg = sprintf("Successfully fetched %s coverage stores!", length(covList))
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching list of datastores"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(covList)
    },
    
    #'@description Get the list of available coverage store names. Returns an vector of class \code{character}
    #'@param ws workspace name
    #'@return the list of coverage store names, as \code{character}
    getCoverageStoreNames = function(ws){
      covList <- sapply(self$getCoverageStores(ws), function(x){x$name})
      return(covList)
    },
    
    #'@description Get an object of class \code{\link{GSAbstractDataStore}} given a workspace and coverage store names.
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@return the coverage store
    getCoverageStore = function(ws, cs){
      msg = sprintf("Fetching coverage store '%s' in workspace '%s'", cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores/%s.xml", ws, cs),
        verbose = self$verbose.debug)
      coverageStore <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        covType <-  xml2::xml_find_first(covXML, "//type") %>% xml2::xml_text()
        coverageStore <- switch(covType,
          "GeoTIFF" = GSGeoTIFFCoverageStore$new(xml = covXML),
          "WorldImage" = GSWorldImageCoverageStore$new(xml = covXML),
          "ImageMosaic" = GSImageMosaicCoverageStore$new(xml = covXML),
          "ArcGrid" = GSArcGridCoverageStore$new(xml = covXML),
          GSAbstractCoverageStore$new(xml = covXML)
        )
        msg = "Successfully fetched coverage store!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching coverage store"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(coverageStore)
    },

    #'@description  Creates a new coverage store given a workspace, coverage store name. Abstract method used in below format-specific
    #'    methods to create coverage stores.
    #'@param ws workspace name
    #'@param coverageStore coverage store object
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createCoverageStore = function(ws, coverageStore){
      msg = sprintf("Creating coverage store '%s' in workspace '%s'", coverageStore$name, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      created <- FALSE
      if(is.null(coverageStore$workspace)) coverageStore$workspace <- ws
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/coveragestores.xml", ws),
        content = GSUtils$getPayloadXML(coverageStore),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        msg = "Successfully created coverage store!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while creating coverage store"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
    },
    
    #'@description  Updates a coverage store given a workspace, coverage store name. Abstract method used in below format-specific
    #'    methods to create coverage stores.
    #'@param ws workspace name
    #'@param coverageStore coverage store object
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateCoverageStore = function(ws, coverageStore){
      if(is.null(coverageStore$workspace)) coverageStore$workspace <- ws
      updated <- FALSE
      msg = sprintf("Updating coverage store '%s' in workspace '%s'", coverageStore$name, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/coveragestores/%s.xml", ws, coverageStore$name),
        content = GSUtils$getPayloadXML(coverageStore),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfully updated coverage store!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating coverage store"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(updated)
    },
    
    #'@description Deletes a coverage store given a workspace and an object of class \code{\link{GSAbstractCoverageStore}}.
    #'    By defaut, the option \code{recurse} is set to FALSE, ie datastore layers are not removed.
    #'    To remove all coverage store layers, set this option to TRUE. The \code{purge} parameter is used 
    #'    to customize the delete of files on disk (in case the underlying reader implements a delete method). 
    #'    It can take one of the three values: none, metadata, all. For more details see \url{https://docs.geoserver.org/stable/en/user/rest/api/coveragestores.html#purge}
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param recurse recurse
    #'@param purge purge
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteCoverageStore = function(ws, cs, recurse = FALSE, purge = NULL){
      msg = sprintf("Deleting coverage store '%s' in workspace '%s'", cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/coveragestores/%s.xml", ws, cs)
      if(recurse) path <- paste0(path, "?recurse=true")
      if(!is.null(purge)){
        allowedPurgeValues <- c("none","metadata","all")
        if(!(purge %in% allowedPurgeValues)){
          err = sprintf("Purge value should be among allowed purge values [%s]",
                        paste(allowedPurgeValues, collapse=","))
          cli::cli_alert_danger(err)
          stop(err)
        }
        path <- paste0(path, ifelse(recurse,"&","?"), "purge=", purge)
      }
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfully deleted coverage store!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting coverage store"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)  
    },
    
    #CoverageStore coverages CRUD methods
    #===========================================================================
    
    #'@description Get the list of available coverages for given workspace and coverage store.
    #'    Returns an object of class \code{list} giving items of class \code{\link{GSCoverage}}
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@return the list of \link{GSCoverage}
    getCoverages = function(ws, cs){
      msg = sprintf("Fetching coverages for coverage store '%s' in workspace '%s'", cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores/%s/coverages.xml", ws, cs),
        verbose = self$verbose.debug)
      covList <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        covXMLList <- as(xml2::xml_find_all(covXML, "//coverages/coverage"), "list")
        covList <- lapply(covXMLList, GSCoverage$new)
        msg = sprintf("Successfully fetched %s coverages!", length(covList))
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching list of coverages"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(covList)
    },
    
    #'@description Get the list of available coverage names for given workspace and coverage store.
    #'    Returns an object of class \code{list} giving items of class \code{\link{GSCoverage}}
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@return the list of coverage names
    getCoverageNames = function(ws, cs){
      covList <- sapply(self$getCoverages(ws, cs), function(x){x$name})
      return(covList)
    },
    
    #'@description Get coverage
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param cv coverage name
    getCoverage = function(ws, cs, cv){
      msg = sprintf("Fetching coverage '%s' in coverage store '%s' (workspace '%s')", cv, cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores/%s/coverages/%s.xml", ws, cs, cv),
        verbose = self$verbose.debug)
      coverage <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        coverage <- GSCoverage$new(xml = covXML)
        msg = "Successfully fetched coverage!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching coverage"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(coverage)
    },
    
    #'@description  Creates a new coverage given a workspace, coverage store names and an object of class \code{\link{GSCoverage}}
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param coverage object of class \link{GSCoverage}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createCoverage = function(ws, cs, coverage){
      msg = sprintf("Creating coverage '%s' in coverage store '%s' (workspace '%s')", coverage$name, cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(),
        user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/coveragestores/%s/coverages.xml", ws, cs),
        content = GSUtils$getPayloadXML(coverage),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        msg = "Successfully created coverage!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while creating coverage"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(created)
    },
    
    #'@description  Updates a coverage given a workspace, coverage store names and an object of class \code{\link{GSCoverage}}
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param coverage object of class \link{GSCoverage}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateCoverage = function(ws, cs, coverage){
      msg = sprintf("Updating coverage '%s' in coverage store '%s' (workspace '%s')", coverage$name, cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      updated <- FALSE
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, 
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/coveragestores/%s/coverages/%s.xml",
                       ws, cs, coverage$name),
        content = GSUtils$getPayloadXML(coverage),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfully updated coverage!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        updated = TRUE
      }else{
        err = "Error while updating coverage"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(updated)
    },
    
    #'@description Deletes a coverage given a workspace, coverage store names, and an object of 
    #'    class \code{\link{GSCoverage}}. By defaut, the option \code{recurse} is 
    #'    set to FALSE, ie coverage layers are not removed.
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param cv coverage name
    #'@param recurse recurse
    deleteCoverage = function(ws, cs, cv, recurse = FALSE){
      msg = sprintf("Deleting coverage '%s' in coverage '%s' (workspace '%s')", cv, cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/coveragestores/%s/coverages/%s.xml", ws, cs, cv)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfuly deleted coverage!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting coverage"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)  
    },
    
    #Upload methods
    #===========================================================================
    
    #'@description Abstract method to upload a coverage file targeting a workspace (\code{ws}) and datastore (\code{cs}). The \code{extension}
    #'    corresponds to the format/type of coverage to be uploaded (among values 'geotiff', 'worldimage', 'arcgrid', or 'imagemosaic'). 
    #'    The \code{endpoint} takes a value among \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name 
    #'    of the coverage file to upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param endpoint endpoint. Default is "file"
    #'@param extension extension
    #'@param filename filename
    #'@param configure configure. Default is "first"
    #'@param update update. Default is "append"
    #'@param contentType content type
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise
    uploadCoverage = function(ws, cs,
                                   endpoint = "file", extension, filename,
                                   configure = "first", update = "append",
                                   contentType){
      msg = sprintf("Uploading %s coverage in new datastore '%s' (workspace '%s')",
                    toupper(extension), cs, ws)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      
      uploaded <- FALSE
      
      supportedEndpoints <- c("file","url","external")
      if(!(endpoint %in% supportedEndpoints)){
        err = sprintf("Unsupported endpoint '%s'. Possible values: [%s]",
                      endpoint, paste0(supportedEndpoints, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      supportedExtensions <- c("geotiff", "worldimage", "imagemosaic", "arcgrid")
      if(!(extension %in% supportedExtensions)){
        err = sprintf("Unsupported extension '%s'. Possible values: [%s]",
                      extension, paste0(supportedExtensions, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      supportedConfigurations <- c("first", "none", "all")
      if(!(configure %in% supportedConfigurations)){
        err = sprintf("Unsupported configure parameter '%s'. Possible values: [%s]",
                      configure, paste0(supportedConfigurations, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      supportedUpdates <- c("append","overwrite")
      if(!(update %in% supportedUpdates)){
        err = sprintf("Unsupported update parameter '%s'. Possible values: [%s]",
                      update, paste0(supportedUpdates, collapse=","))
        cli::cli_alert_danger(err)
        self$ERROR(err)
        stop(err)
      }
      
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/coveragestores/%s/%s.%s?configure=%s&update=%s",
                       ws, cs, endpoint, extension, configure, update),
        content = NULL,
        filename = filename,
        contentType = contentType,
        verbose = self$verbose.debug
      )
      if(status_code(req) == 201){
        msg = "Successfull coverage upload!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        uploaded = TRUE
      }
      if(!uploaded){
        err = sprintf("Error while uploading coverage: %s", http_status(req)$message)
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(uploaded)
    },
    
    #'@description Uploads a GeoTIFF file targeting a workspace (\code{ws}) and datastore (\code{cs}). The \code{endpoint} takes a value among
    #'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the GeoTIFF file to
    #'    upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param endpoint endpoint. Default is "file"
    #'@param filename filename
    #'@param configure configure. Default is "first"
    #'@param update update. Default is "append"
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise   
    uploadGeoTIFF = function(ws, cs,
                             endpoint = "file", filename,
                             configure = "first", update = "append"){
      return(self$uploadCoverage(
        ws = ws, cs = cs, 
        endpoint = endpoint, extension = "geotiff", filename = filename,
        configure = configure, update = update, 
        contentType = "text/plain"
      ))
    },
    
    #'@description Uploads a WorldImage file targeting a workspace (\code{ws}) and datastore (\code{cs}). The \code{endpoint} takes a value among
    #'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the zipped file to
    #'    upload and set for the newly created datastore. It is assumed the zip archive contains the .prj file to set the SRS. 
    #'    The \code{configure} parameter can take a value among values  \code{"none"} (indicates to configure only the datastore 
    #'    but no layer configuration) or \code{"first"} (configure both datastore and layer). The \code{update} defines the strategy
    #'    for the upload: \code{"append"} (default value) for the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param endpoint endpoint. Default is "file"
    #'@param filename filename
    #'@param configure configure. Default is "first"
    #'@param update update. Default is "append"
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise 
    uploadWorldImage = function(ws, cs,
                                endpoint = "file", filename,
                                configure = "first", update = "append"){
      return(self$uploadCoverage(
        ws = ws, cs = cs, 
        endpoint = endpoint, extension = "worldimage", filename = filename,
        configure = configure, update = update, 
        contentType = "application/zip"
      ))
    },
    
    #'@description Uploads an ArcGrid file targeting a workspace (\code{ws}) and datastore (\code{cs}). The \code{endpoint} takes a value among
    #'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the ArcGrid file to
    #'    upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param endpoint endpoint. Default is "file"
    #'@param filename filename
    #'@param configure configure. Default is "first"
    #'@param update update. Default is "append"
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise 
    uploadArcGrid = function(ws, cs,
                             endpoint = "file", filename,
                             configure = "first", update = "append"){
      return(self$uploadCoverage(
        ws = ws, cs = cs, 
        endpoint = endpoint, extension = "arcgrid", filename = filename,
        configure = configure, update = update, 
        contentType = "text/plain"
      ))
    },
    
    #'@description Uploads an ImageMosaic file targeting a workspace (\code{ws}) and datastore (\code{cs}). The \code{endpoint} takes a value among
    #'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the ImageMosaic file to
    #'    upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
    #'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
    #'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
    #'    the first upload, \code{"overwrite"} in case the file should be overwriten.
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param endpoint endpoint. Default is "file"
    #'@param filename filename
    #'@param configure configure. Default is "first"
    #'@param update update. Default is "append"
    #'@return \code{TRUE} if uploaded, \code{FALSE} otherwise 
    uploadImageMosaic = function(ws, cs,
                                 endpoint = "file", filename,
                                 configure = "first", update = "append"){
      return(self$uploadCoverage(
        ws = ws, cs = cs, 
        endpoint = endpoint, extension = "imagemosaic", filename = filename,
        configure = configure, update = update, 
        contentType = "application/zip"
      ))
    }
    
  )
                              
)
