#' Geoserver REST API Resource
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSResource
#' @title A GeoServer abstract resource
#' @description This class models an abstract GeoServer resource. This class is
#' used internally for modelling instances of class \code{GSFeatureType} or
#' \code{GSCoverage}
#' @keywords geoserver rest api resource
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer resource
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' res <- GSResource$new(rootName = "featureType")
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(rootName, xml)}}{
#'    This method is used to instantiate a GSResource
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSResource from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSResource to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setEnabled(enabled)}}{
#'    Sets if the resource is enabled or not in GeoServer
#'  }
#'  \item{\code{setName(name)}}{
#'    Sets the resource name
#'  }
#'  \item{\code{setNativeName(nativeName)}}{
#'    Sets the resource native name
#'  }
#'  \item{\code{setTitle(title)}}{
#'    Sets the resource title
#'  }
#'  \item{\code{setDescription(description)}}{
#'    Sets the resource description
#'  }
#'  \item{\code{setAbstract(abstract)}}{
#'    Sets the resource abstract
#'  }
#'  \item{\code{setKeywords(keywords)}}{
#'    Sets a list of keywords
#'  }
#'  \item{\code{addKeyword(keyword)}}{
#'    Sets a keyword. Returns TRUE if set, FALSE otherwise
#'  }
#'  \item{\code{delKeyword(keyword)}}{
#'    Deletes a keyword. Returns TRUE if deleted, FALSE otherwise
#'  }
#'  \item{\code{setMetadataLinks(metadataLinks)}}{
#'    Sets a list of \code{GSMetadataLinks}
#'  }
#'  \item{\code{addMetadataLink(metadataLink)}}{
#'    Adds a metadataLink
#'  }
#'  \item{\code{delMetadataLink(metadataLink)}}{
#'    Deletes a metadataLink
#'  }
#'  \item{\code{setNativeCRS(nativeCRS)}}{
#'    Sets the resource nativeCRS
#'  }
#'  \item{\code{setSrs(srs)}}{
#'    Sets the resource srs
#'  }
#'  \item{\code{setNativeBoundingBox(minx, miny, maxx, maxy, bbox, crs)}}{
#'    Sets the resource nativeBoundingBox. Either from coordinates or from
#'    a \code{bbox} object (matrix).
#'  }
#'  \item{\code{setLatLonBoundingBox(minx, miny, maxx, maxy, bbox, crs)}}{
#'    Sets the resource latLonBoundingBox. Either from coordinates or from
#'    a \code{bbox} object (matrix).
#'  }
#'  \item{\code{setProjectionPolicy(policy)}}{
#'    Sets the resource projection policy
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSResource <- R6Class("GSResource",
   inherit = GSRESTResource,
   
   private = list(
     allowedProjectionPolicies = c("NONE", "FORCE_DECLARED", "REPROJECT_TO_DECLARED")
   ),
   
   public = list(
     #'@field full full
     full = TRUE,
     #' @field name resource name
     name = NULL,
     #' @field nativeName resource native name
     nativeName = NULL,
     #' @field title resource title
     title = NULL,
     #' @field description resource description
     description = NULL,
     #' @field abstract resource abstract
     abstract = NULL,
     #' @field keywords resource keywords
     keywords = list(),
     #' @field metadataLinks resource metadata links
     metadataLinks = list(),
     #' @field nativeCRS resource native CRS
     nativeCRS = NULL,
     #' @field srs resource srs
     srs = NULL,
     #' @field nativeBoundingBox resource lat/lon native bounding box
     nativeBoundingBox = list(minx = NA, miny = NA, maxx = NA, maxy = NA, crs = NA),
     #' @field latLonBoundingBox resource lat/lon bounding box
     latLonBoundingBox = list(minx = NA, miny = NA, maxx = NA, maxy = NA, crs = NA),
     #' @field projectionPolicy resource projection policy
     projectionPolicy = NULL,
     #'@field enabled enabled
     enabled = TRUE,
     #'@field metadata metadata
     metadata = NULL,
     
     #'@description Initializes a \link{GSResource}
     #'@param rootName root name
     #'@param xml object of class \link{XMLInternalNode-class}
     initialize = function(rootName = NULL, xml = NULL){
        super$initialize(rootName = rootName)
        if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
        }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link{XMLInternalNode-class}
     decode = function(xml){
       names <- getNodeSet(xml, "//name")
       self$name <- xmlValue(names[[1]])
       enabled <- getNodeSet(xml, "//enabled")
       if(length(enabled)==0) self$full <- FALSE
       
       if(self$full){
         self$enabled <- as.logical(xmlValue(enabled[[1]]))
         nativeNames <- getNodeSet(xml, "//nativeName")
         if(length(nativeNames)>0) self$nativeName <- xmlValue(nativeNames[[1]])
         titles <- getNodeSet(xml, "//title")
         if(length(titles)>0) self$title <- xmlValue(titles[[1]])
         descriptions <- getNodeSet(xml, "//description")
         if(length(descriptions)>0) self$description <- xmlValue(descriptions[[1]])
         abstracts <- getNodeSet(xml, "//abstract")
         if(length(abstracts)>0) self$abstract <- xmlValue(abstracts[[1]])
         self$keywords <- lapply(getNodeSet(xml, "//keywords/string"), xmlValue)
         
         metadataLinksXML <- getNodeSet(xml, "//metadataLinks/metadataLink")
         if(length(metadataLinksXML)>0){
           for(metadataLinkXML in metadataLinksXML){
             md <- GSMetadataLink$new(xml = metadataLinkXML)
             self$addMetadataLink(md)
           }
         }
         
         nativeCRS <- getNodeSet(xml, "//nativeCRS")
         if(length(nativeCRS)>0){
           self$nativeCRS <- xmlValue(nativeCRS[[1]])
         }
         
         
         srs <- getNodeSet(xml, "//srs")
         if(length(srs)>0){
           self$srs <- xmlValue(srs[[1]])
         }

         latLonBboxXML <- getNodeSet(xml, "//latLonBoundingBox/*")
         self$latLonBoundingBox <- lapply(latLonBboxXML, xmlValue)
         names(self$latLonBoundingBox) <-  lapply(latLonBboxXML, xmlName)
         
         nativeBboxXML <- getNodeSet(xml, "//nativeBoundingBox/*")
         self$nativeBoundingBox <- lapply(nativeBboxXML, xmlValue)
         names(self$nativeBoundingBox) <-  lapply(nativeBboxXML, xmlName)
         
         projPolicies <- getNodeSet(xml, "//projectionPolicy")
         if(length(projPolicies)>0){
           self$projectionPolicy <- xmlValue(projPolicies[[1]])
         }
         
         md_entries <- getNodeSet(xml, "//metadata/entry")
         if(length(md_entries)>0){
           for(md_entry in md_entries){
              key <- xmlGetAttr(md_entry, "key")
              child <- xmlChildren(md_entry)
              meta <- NULL
              if(is(self, "GSFeatureType")){
                meta <- switch(names(child),
                  "dimensionInfo" = GSFeatureDimension$new(xml = child$dimensionInfo),
                  "virtualTable" = GSVirtualTable$new(xml = child$virtualTable)
                )
              }
              if(is(self, "GSCoverage")){
                meta <- switch(names(child),
                  "dimensionInfo" = GSDimension$new(xml = child$dimensionInfo),
                  "coverageView" = GSCoverageView$new(xml = child$coverageView)
                )
              }
              if(!is.null(meta)) self$setMetadata(key, meta)
           }
         }
       }
     },
     
     #'@description Set enabled
     #'@param enabled enabled
     setEnabled = function(enabled){
       self$enabled = enabled
     },
     
     #'@description Set name
     #'@param name name
     setName = function(name){
       self$name = name
     },
     
     #'@description Set native name
     #'@param nativeName native name
     setNativeName = function(nativeName){
       self$nativeName = nativeName
     },
     
     #'@description Set title
     #'@param title title
     setTitle = function(title){
       self$title = title
     },
     
     #'@description Set description
     #'@param description description
     setDescription = function(description){
       self$description = description
     },
     
     #'@description Set abstract
     #'@param abstract abstract
     setAbstract = function(abstract){
       self$abstract = abstract
     },
     
     #'@description Set keyword(s)
     #'@param keywords keywords
     setKeywords = function(keywords){
       if(!is.list(keywords)) keywords = list(keywords)
       self$keywords = keywords
       return(TRUE)
     },
     
     #'@description Adds keyword
     #'@param keyword keyword
     #'@return \code{TRUE} if added, \code{FALSE} otherwise
     addKeyword = function(keyword){
       startNb = length(self$keywords)
       if(length(which(self$keywords == keyword)) == 0){
         self$keywords = c(self$keywords, keyword)
       }
       endNb = length(self$keywords)
       return(endNb == startNb+1)
     },
     
     #'@description Deletes keyword
     #'@param keyword keyword
     #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
     delKeyword = function(keyword){
       startNb = length(self$keywords)
       self$keywords = self$keywords[which(self$keywords != keyword)]
       endNb = length(self$keywords)
       return(endNb == startNb-1)
     },
     
     #'@description Set metadata links
     #'@param metadataLinks metadata links
     setMetadataLinks = function(metadataLinks){
       self$metadataLinks <- metadataLinks
     },
     
     #'@description Adds metadata link
     #'@param metadataLink object of class \link{GSMetadataLink}
     #'@return \code{TRUE} if added, \code{FALSE} otherwise
     addMetadataLink = function(metadataLink){
       startNb = length(self$metadataLinks)
       links <- lapply(self$metadataLinks, function(x){x$content})
       if(length(which(links == metadataLink$content)) == 0){
         self$metadataLinks = c(self$metadataLinks, metadataLink)
       }
       endNb = length(self$metadataLinks)
       return(endNb == startNb+1)
     },
     
     #'@description Deletes metadata link
     #'@param metadataLink object of class \link{GSMetadataLink}
     #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
     deleteMetadataLink = function(metadataLink){
       startNb = length(self$metadataLinks)
       links <- lapply(self$metadataLinks, function(x){x$content})
       self$metadataLinks = self$metadataLinks[which(links != metadataLink$content)]
       endNb = length(self$metadataLinks)
       return(endNb == startNb-1)
     },
     
     #'@description Set projection policy
     #'@param projectionPolicy projection policy
     setProjectionPolicy = function(projectionPolicy){
       if(!(projectionPolicy %in% private$allowedProjectionPolicies)){
        stop(sprintf("'%s' is not a valid projection policy", projectionPolicy))
       }
       self$projectionPolicy = projectionPolicy
     },
     
     #'@description Set SRS
     #'@param srs srs
     setSrs = function(srs){
       self$srs = srs
     },
     
     #'@description Set native CRS
     #'@param nativeCRS native crs
     setNativeCRS = function(nativeCRS){
       self$nativeCRS = nativeCRS
     },

     #'@description Set LatLon bounding box
     #'@param minx minx
     #'@param miny miny
     #'@param maxx maxx
     #'@param maxy maxy
     #'@param bbox bbox
     #'@param crs crs
     setLatLonBoundingBox = function(minx, miny, maxx, maxy, bbox = NULL, crs){
       self$latLonBoundingBox <- GSUtils$setBbox(minx, miny, maxx, maxy, bbox, crs)
     },
     
     #'@description Set native bounding box
     #'@param minx minx
     #'@param miny miny
     #'@param maxx maxx
     #'@param maxy maxy
     #'@param bbox bbox
     #'@param crs crs
     setNativeBoundingBox = function(minx, miny, maxx, maxy, bbox = NULL, crs){
       self$nativeBoundingBox <- GSUtils$setBbox(minx, miny, maxx, maxy, bbox, crs)
     },
     
     #'@description Set metadata
     #'@param key key
     #'@param metadata metadata
     #'@return \code{TRUE} if added, \code{FALSE} otherwise
     setMetadata = function(key, metadata){
       if(is.null(self$metadata)){
         self$metadata = GSRESTEntrySet$new(rootName = "metadata")
       }
       added <- self$metadata$addEntry(key, metadata)
       return(added)
     },
     
     #'@description Deletes metadata
     #'@param key key
     #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
     delMetadata = function(key){
       deleted <- FALSE
       if(!is.null(self$metadata)){
        deleted <- self$metadata$delEntry(key)
        if(length(self$metadataentryset)==0) self$metadata = NULL
       }
       return(deleted)
     },
     
     #'@description Set metadata dimension
     #'@param key key
     #'@param dimension dimension
     #'@param custom custom
     setMetadataDimension = function(key, dimension, custom = FALSE){
      if(custom) key <- paste0("custom_dimension_", toupper(key))
      added <- self$setMetadata(key, dimension)
      return(added)
     }
   )                     
)
