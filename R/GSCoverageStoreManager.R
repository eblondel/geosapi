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
#' @section Constructor:
#' \describe{
#'  \item{\code{new(url, user, pwd, logger)}}{
#'    This method is used to instantiate a GSManager with the \code{url} of the
#'    GeoServer and credentials to authenticate (\code{user}/\code{pwd}). By default,
#'    the \code{logger} argument will be set to \code{NULL} (no logger). This argument
#'    accepts two possible values: \code{INFO}: to print only geosapi logs,
#'    \code{DEBUG}: to print geosapi and CURL logs
#'  }
#' }
#' 
#' @section \code{CoverageStore} methods:
#' \describe{ 
#'  \item{\code{getCoverageStores(ws)}}{
#'    Get the list of available coverage stores. Returns an object of class \code{list}
#'    giving items of class \code{\link{GSAbstractCoverageStore}}
#'  }
#'  \item{\code{getCoverageStoreNames(ws)}}{
#'    Get the list of available coverage store names. Returns an vector of class \code{character}
#'  }
#'  \item{\code{getCoverageStore(ws, cs)}}{
#'    Get an object of class \code{\link{GSAbstractDataStore}} given a workspace and coverage store names.
#'  }
#'  \item{\code{createCoverageStore(ws, cs, endpoint, extension, filename, configure, update,contentType)}}{
#'    Creates a new coverage given a workspace, coverage store name. Abstract method used in below format-specific
#'    methods to create coverage stores.
#'  }
#'  \item{\code{createGeoTIFFCoverageStore(ws, cs, endpoint, filename, configure, update)}}{
#'    Creates a new GeoTIFF coverage given a workspace, coverage store name. The \code{endpoint} takes a value among
#'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the GeoTIFF file to
#'    upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
#'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
#'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
#'    the first upload, \code{"overwrite"} in case the file should be overwriten.
#'  }
#'  \item{\code{createWorldImageCoverageStore(ws, cs, endpoint, filename, configure, update)}}{
#'    Creates a new WorldImage coverage store given a workspace, coverage store name. The \code{endpoint} takes a value among
#'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the zipped file to
#'    upload and set for the newly created datastore. It is assumed the zip archive contains the .prj file to set the SRS. 
#'    The \code{configure} parameter can take a value among values  \code{"none"} (indicates to configure only the datastore 
#'    but no layer configuration) or \code{"first"} (configure both datastore and layer). The \code{update} defines the strategy
#'    for the upload: \code{"append"} (default value) for the first upload, \code{"overwrite"} in case the file should be overwriten.
#'  }
#'  \item{\code{createArcGridCoverageStore(ws, cs, endpoint, filename, configure, update)}}{
#'    Creates a new ArcGrid coverage store given a workspace, coverage store name. The \code{endpoint} takes a value among
#'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the ArcGrid file to
#'    upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
#'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
#'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
#'    the first upload, \code{"overwrite"} in case the file should be overwriten.
#'  }
#'  \item{\code{createImageMosaicCoverageStore(ws, cs, endpoint, filename, configure, update)}}{
#'    Creates a new ImageMosaic coverage store given a workspace, coverage store name. The \code{endpoint} takes a value among
#'    \code{"file"} (default), \code{"url"} or \code{"external"}. The \code{filename} is the name of the ImageMosaic file to
#'    upload and set for the newly created datastore. The \code{configure} parameter can take a value among values 
#'    \code{"none"} (indicates to configure only the datastore but no layer configuration) or \code{"first"} (configure 
#'    both datastore and layer). The \code{update} defines the strategy for the upload: \code{"append"} (default value) for 
#'    the first upload, \code{"overwrite"} in case the file should be overwriten.
#'  }
#'  \item{\code{updateCoverageStore(ws, coverageStore)}}{
#'    Updates an existing coverage store given a workspace and an object of class \code{\link{GSAbstractCoverageStore}}
#'  }
#'  \item{\code{deleteCoverageStore(ws, cs, recurse, purge)}}{
#'    Deletes a coverage store given a workspace and an object of class \code{\link{GSCoverageStore}}.
#'    By defaut, the option \code{recurse} is set to FALSE, ie datastore layers are not removed.
#'    To remove all coverage store layers, set this option to TRUE. The \code{purge} parameter is used 
#'    to customize the delete of files on disk (in case the underlying reader implements a delete method). 
#'    It can take one of the three values: none, metadata, all. For more details see \link{https://docs.geoserver.org/stable/en/user/rest/api/coveragestores.html#purge}
#'  }
#' }
#' 
#' @section \code{Coverages} methods:
#' \describe{
#'  \item{\code{publishGeoTIFF(ws, cs, filename, update)}}{
#'    Configure an GeoTIFF coverage store, upload the GeoTIFF file and publish it as layer. The \code{update} defines 
#'    the strategy for the upload: \code{"append"} (default value) for the first upload, \code{"overwrite"} in case the file 
#'    should be overwriten.
#'  }
#'  \item{\code{publishWorldImage(ws, cs, filename, update)}}{
#'    Configure an WorldImage coverage store, upload the WorldImage file and publish it as layer. The \code{update} defines 
#'    the strategy for the upload: \code{"append"} (default value) for the first upload, \code{"overwrite"} in case the file 
#'    should be overwriten. It is assumed the file should be an zipped archive containing the .prj file to define the SRS.
#'  }
#'  \item{\code{publishArcGrid(ws, cs, filename, update)}}{
#'    Configure an ArcGrid coverage store, upload the ArcGrid file and publish it as layer. The \code{update} defines 
#'    the strategy for the upload: \code{"append"} (default value) for the first upload, \code{"overwrite"} in case the file 
#'    should be overwriten.
#'  }
#'  \item{\code{publishImageMosaic(ws, cs, filename, update)}}{
#'    Configure an ImageMosaic coverage store, upload the ImageMosaic zip file and publish it as layer. The \code{update} defines 
#'    the strategy for the upload: \code{"append"} (default value) for the first upload, \code{"overwrite"} in case the file 
#'    should be overwriten.
#'  }
#' 
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSCoverageStoreManager <- R6Class("GSCoverageStoreManager",
  inherit = GSManager,
  
  public = list(   
    
    #CoverageStore generic CRUD methods
    #===========================================================================
    
    #getCoverageStores
    #---------------------------------------------------------------------------
    getCoverageStores = function(ws){
      self$INFO(sprintf("Fetching list of coverage stores in workspace '%s'", ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
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
    
    #getCoverageStoreNames
    #---------------------------------------------------------------------------
    getCoverageStoreNames = function(ws){
      covList <- sapply(self$getCoverageStores(ws), function(x){x$name})
      return(covList)
    },
    
    #getCoverageStore
    #---------------------------------------------------------------------------
    getCoverageStore = function(ws, cs){
      self$INFO(sprintf("Fetching coverage store '%s' in workspace '%s'", cs, ws))
      req <- GSUtils$GET(
        self$getUrl(), private$user, private$pwd,
        sprintf("/workspaces/%s/coveragestores/%s.xml", ws, cs),
        verbose = self$verbose.debug)
      dataStore <- NULL
      if(status_code(req) == 200){
        covXML <- GSUtils$parseResponseXML(req)
        covType <-  xmlValue(xmlChildren(xmlRoot(covXML))$type)
        coverageStore <- switch(covType,
          "GeoTIFF" = GSGeoTIFFCoverageStore$new(xml = covXML),
          "WorldImage" = GSWorldImageCoverageStore$new(xml = covXML),
          "ImageMosaic" = GSImageMosaicCoverageStore$new(xml = covXML),
          GSAbstractCoverageStore$new(xml = covXML)
        )
        self$INFO("Successfully fetched coverage store!")
      }else{
        self$ERROR("Error while fetching coverage store")
      }
      return(coverageStore)
    },
    
    #createCoverageStore
    #---------------------------------------------------------------------------
    createCoverageStore = function(ws, cs,
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
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #createGeoTIFFCoverageStore
    createGeoTIFFCoverageStore = function(ws, cs,
                                   endpoint = "file", filename,
                                   configure = "first", update = "append"){
      return(self$createCoverageStore(ws = ws, cs = cs, 
                                      endpoint = endpoint, extension = "geotiff", filename = filename,
                                      configure = configure, update = update, 
                                      contentType = "image/geotiff"))
    },
    
    #createWorldImageCoverageStore
    createWorldImageCoverageStore = function(ws, cs,
                                          endpoint = "file", filename,
                                          configure = "first", update = "append"){
      return(self$createCoverageStore(ws = ws, cs = cs, 
                                      endpoint = endpoint, extension = "worldimage", filename = filename,
                                      configure = configure, update = update, 
                                      contentType = "application/zip"))
    },
    
    #createArcGridCoverageStore
    createArcGridCoverageStore = function(ws, cs,
                                          endpoint = "file", filename,
                                          configure = "first", update = "append"){
      return(self$createCoverageStore(ws = ws, cs = cs, 
                                      endpoint = endpoint, extension = "arcgrid", filename = filename,
                                      configure = configure, update = update, 
                                      contentType = "image/arcgrid"))
    },
    
    #createImageMosaicCoverageStore
    createImageMosaicCoverageStore = function(ws, cs,
                                          endpoint = "file", filename,
                                          configure = "first", update = "append"){
      return(self$createCoverageStore(ws = ws, cs = cs, 
                                      endpoint = endpoint, extension = "imagemosaic", filename = filename,
                                      configure = configure, update = update, 
                                      contentType = "application/zip"))
    },
    
    #updatCoverageStore
    #---------------------------------------------------------------------------
    updateCoverageStore = function(ws, coverageStore){
      updated <- FALSE
      self$INFO(sprintf("Updating coverage store '%s' in workspace '%s'", coverageStore$name, ws))
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user, pwd = private$pwd,
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
    
    #deleteCoverageStore
    #---------------------------------------------------------------------------
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
      req <- GSUtils$DELETE(self$getUrl(), private$user, private$pwd,
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        self$INFO("Successfully deleted coverage store!")
        deleted = TRUE
      }else{
        self$ERROR("Error while deleting coverage store")
      }
      return(deleted)  
    },
    
    #publication methods
    #---------------------------------------------------------------------------------
    #publishGeoTIFF
    publishGeoTIFF = function(ws, cs, filename, update = "append"){
      return(self$createGeoTIFFCoverageStore(ws = ws, cs = cs,
              endpoint = "file", filename = filename, configure = "first", update = update))
    },
    
    #publishWorldImage
    publishWorldImage = function(ws, cs, filename, update = "append"){
      return(self$createWorldImageCoverageStore(ws = ws, cs = cs,
              endpoint = "file", filename = filename, configure = "first", update = update))
    },
    
    #publishArcGrid
    publishArcGrid = function(ws, cs, filename, update = "append"){
      return(self$createArcGridCoverageStore(ws = ws, cs = cs,
              endpoint = "file", filename = filename, configure = "first", update = update))
    },
    
    #publishImageMosaic
    publishImageMosaic = function(ws, cs, filename, update = "append"){
      return(self$createImageMosaicCoverageStore(ws = ws, cs = cs,
              endpoint = "file", filename = filename, configure = "first", update = update))
    }
    
  )
                              
)
