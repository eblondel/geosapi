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
      self$INFO(sprintf("Fetching list of coverage stores in workspace '%s'", ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores.xml", ws),
        verbose = self$verbose.debug)
      covList <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        covXMLList <- getNodeSet(covXML, "//coverageStore")
        covList <- lapply(covXMLList, function(x){
          xml <- xmlDoc(x)
          covType <-  xmlValue(xmlChildren(xmlRoot(xml))$type)
          coverageStore <- switch(covType,
            "GeoTIFF" = GSGeoTIFFCoverageStore$new(xml = xml),
            "WorldImage" = GSWorldImageCoverageStore$new(xml = xml),
            "ImageMosaic" = GSImageMosaicCoverageStore$new(xml = xml),
            "ArcGrid" = GSArcGridCoverageStore$new(xml = xml),
            GSAbstractCoverageStore$new(xml = xml)
          )
          return(coverageStore)
        })
        self$INFO(sprintf("Successfully fetched %s coverage stores!", length(covList)))
      }else{
        self$ERROR("Error while fetching list of datastores")
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
      self$INFO(sprintf("Fetching coverage store '%s' in workspace '%s'", cs, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores/%s.xml", ws, cs),
        verbose = self$verbose.debug)
      coverageStore <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        covType <-  xmlValue(xmlChildren(xmlRoot(covXML))$type)
        coverageStore <- switch(covType,
          "GeoTIFF" = GSGeoTIFFCoverageStore$new(xml = covXML),
          "WorldImage" = GSWorldImageCoverageStore$new(xml = covXML),
          "ImageMosaic" = GSImageMosaicCoverageStore$new(xml = covXML),
          "ArcGrid" = GSArcGridCoverageStore$new(xml = xml),
          GSAbstractCoverageStore$new(xml = covXML)
        )
        self$INFO("Successfully fetched coverage store!")
      }else{
        self$ERROR("Error while fetching coverage store")
      }
      return(coverageStore)
    },

    #'@description  Creates a new coverage store given a workspace, coverage store name. Abstract method used in below format-specific
    #'    methods to create coverage stores.
    #'@param ws workspace name
    #'@param coverageStore coverage store object
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createCoverageStore = function(ws, coverageStore){
      self$INFO(sprintf("Creating coverage store '%s' in workspace '%s'", coverageStore$name, ws))
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
        self$INFO("Successfully created coverage store!")
        created = TRUE
      }else{
        self$ERROR("Error while creating coverage store")
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
      self$INFO(sprintf("Updating coverage store '%s' in workspace '%s'", coverageStore$name, ws))
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/workspaces/%s/coveragestores/%s.xml", ws, coverageStore$name),
        content = GSUtils$getPayloadXML(coverageStore),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        self$INFO("Successfully updated coverage store!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating coverage store")
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
      self$INFO(sprintf("Deleting coverage store '%s' in workspace '%s'", cs, ws))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/coveragestores/%s.xml", ws, cs)
      if(recurse) path <- paste0(path, "?recurse=true")
      if(!is.null(purge)){
        allowedPurgeValues <- c("none","metadata","all")
        if(!(purge %in% allowedPurgeValues)){
          stop(sprintf("Purge value should be among allowed purge values [%s]",
                       paste(allowedPurgeValues, collapse=",")))
        }
        path <- paste0(path, ifelse(recurse,"&","?"), "purge=", purge)
      }
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully deleted coverage store!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting coverage store")
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
      self$INFO(sprintf("Fetching coverages for coverage store '%s' in workspace '%s'", cs, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user,
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores/%s/coverages.xml", ws, cs),
        verbose = self$verbose.debug)
      covList <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        covXMLList <- getNodeSet(covXML, "//coverages/coverage")
        covList <- lapply(covXMLList, function(x){
          xml <- xmlDoc(x)
          return(GSCoverage$new(xml = xml))
        })
        self$INFO(sprintf("Successfully fetched %s coverages!", length(covList)))
      }else{
        self$ERROR("Error while fetching list of coverages")
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
      self$INFO(sprintf("Fetching coverage '%s' in coverage store '%s' (workspace '%s')", cv, cs, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/workspaces/%s/coveragestores/%s/coverages/%s.xml", ws, cs, cv),
        verbose = self$verbose.debug)
      coverage <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        coverage <- GSCoverage$new(xml = covXML)
        self$INFO("Successfully fetched coverage!")
      }else{
        self$ERROR("Error while fetching coverage")
      }
      return(coverage)
    },
    
    #'@description  Creates a new coverage given a workspace, coverage store names and an object of class \code{\link{GSCoverage}}
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param coverage object of class \link{GSCoverage}
    #'@return \code{TRUE} if created, \code{FALSE} otherwise
    createCoverage = function(ws, cs, coverage){
      self$INFO(sprintf("Creating coverage '%s' in coverage store '%s' (workspace '%s')", coverage$name, cs, ws))
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
        self$INFO("Successfully created coverage!")
        created = TRUE
      }else{
        self$ERROR("Error while creating coverage")
      }
      return(created)
    },
    
    #'@description  Updates a coverage given a workspace, coverage store names and an object of class \code{\link{GSCoverage}}
    #'@param ws workspace name
    #'@param cs coverage store name
    #'@param coverage object of class \link{GSCoverage}
    #'@return \code{TRUE} if updated, \code{FALSE} otherwise
    updateCoverage = function(ws, cs, coverage){
      self$INFO(sprintf("Updating coverage '%s' in coverage store '%s' (workspace '%s')", coverage$name, cs, ws))
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
        self$INFO("Successfully updated coverage!")
        updated = TRUE
      }else{
        self$ERROR("Error while updating coverage")
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
      self$INFO(sprintf("Deleting coverage '%s' in coverage '%s' (workspace '%s')", cv, cs, ws))
      deleted <- FALSE
      path <- sprintf("/workspaces/%s/coveragestores/%s/coverages/%s.xml", ws, cs, cv)
      if(recurse) path <- paste0(path, "?recurse=true")
      req <- GSUtils$DELETE(self$getUrl(), private$user,
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfuly deleted coverage!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting coverage")
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
      self$INFO(sprintf("Uploading %s coverage in new datastore '%s' (workspace '%s')",
                        toupper(extension), cs, ws))
      
      uploaded <- FALSE
      
      supportedEndpoints <- c("file","url","external")
      if(!(endpoint %in% supportedEndpoints)){
        stop(sprintf("Unsupported endpoint '%s'. Possible values: [%s]",
                     endpoint, paste0(supportedEndpoints, collapse=",")))
      }
      
      supportedExtensions <- c("geotiff", "worldimage", "imagemosaic", "arcgrid")
      if(!(extension %in% supportedExtensions)){
        stop(sprintf("Unsupported extension '%s'. Possible values: [%s]",
                     extension, paste0(supportedExtensions, collapse=",")))
      }
      
      supportedConfigurations <- c("first", "none", "all")
      if(!(configure %in% supportedConfigurations)){
        stop(sprintf("Unsupported configure parameter '%s'. Possible values: [%s]",
                     configure, paste0(supportedConfigurations, collapse=",")))
      }
      
      supportedUpdates <- c("append","overwrite")
      if(!(update %in% supportedUpdates)){
        stop(sprintf("Unsupported update parameter '%s'. Possible values: [%s]",
                     update, paste0(supportedUpdates, collapse=",")))
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
        self$INFO("Successfull coverage upload!")
        uploaded = TRUE
      }
      if(!uploaded){
        self$ERROR("Error while uploading coverage")
        self$ERROR(http_status(req)$message)
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
