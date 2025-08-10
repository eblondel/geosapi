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
#' @return Object of \code{\link[R6]{R6Class}} for modelling a GeoServer resource
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' res <- GSResource$new(rootName = "featureType")
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
     #'@param xml object of class \link[xml2]{xml_node-class}
     initialize = function(rootName = NULL, xml = NULL){
        super$initialize(rootName = rootName)
        if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
        }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link[xml2]{xml_node-class}
     decode = function(xml){
       xml = xml2::as_xml_document(xml)
       self$name <- xml2::xml_find_first(xml, "//name") %>% xml2::xml_text()
       enabled <- xml2::xml_find_first(xml, "//enabled")
       if(length(enabled)==0) self$full <- FALSE
       
       if(self$full){
         self$enabled <- as.logical(xml2::xml_text(enabled))
         nativeNames <- xml2::xml_find_first(xml, "//nativeName")
         if(length(nativeNames)>0) self$nativeName <- xml2::xml_text(nativeNames)
         titles <- xml2::xml_find_first(xml, "//title")
         if(length(titles)>0) self$title <- xml2::xml_text(titles)
         descriptions <- xml2::xml_find_first(xml, "//description")
         if(length(descriptions)>0) self$description <- xml2::xml_text(descriptions)
         abstracts <- xml2::xml_find_first(xml, "//abstract")
         if(length(abstracts)>0) self$abstract <- xml2::xml_text(abstracts)
         self$keywords <- lapply(as(xml2::xml_find_all(xml, "//keywords/string"), "list"), xml2::xml_text)
         
         metadataLinksXML <- as(xml2::xml_find_all(xml, "//metadataLinks/metadataLink"), "list")
         if(length(metadataLinksXML)>0){
           for(metadataLinkXML in metadataLinksXML){
             self$addMetadataLink(GSMetadataLink$new(xml = metadataLinkXML))
           }
         }
         
         nativeCRS <- xml2::xml_find_first(xml, "//nativeCRS")
         if(length(nativeCRS)>0){
           self$nativeCRS <- xml2::xml_text(nativeCRS)
         }
         
         
         srs <- xml2::xml_find_first(xml, "//srs")
         if(length(srs)>0){
           self$srs <- xml2::xml_text(srs)
         }

         latLonBboxXML <- as(xml2::xml_find_all(xml, "//latLonBoundingBox/*"), "list")
         self$latLonBoundingBox <- lapply(latLonBboxXML, xml2::xml_text)
         names(self$latLonBoundingBox) <-  lapply(latLonBboxXML, xml2::xml_name)
         
         nativeBboxXML <- as(xml2::xml_find_all(xml, "//nativeBoundingBox/*"), "list")
         self$nativeBoundingBox <- lapply(nativeBboxXML, xml2::xml_text)
         names(self$nativeBoundingBox) <-  lapply(nativeBboxXML, xml2::xml_name)
         
         projPolicies <- xml2::xml_find_first(xml, "//projectionPolicy")
         if(length(projPolicies)>0){
           self$projectionPolicy <- xml2::xml_text(projPolicies)
         }
         
         md_entries <- as(xml2::xml_find_all(xml, "//metadata/entry"), "list")
         if(length(md_entries)>0){
           for(md_entry in md_entries){
              key <- xml2::xml_attr(md_entry, "key")
              meta <- NULL
              child <- NULL
              if(length(xml2::xml_children(md_entry))>0){
                child = xml2::xml_child(md_entry)
              }else{
                meta = xml2::xml_text(md_entry)
              }
              if(!is.null(child)){
                if(is(self, "GSFeatureType")){
                  meta <- switch(xml2::xml_name(child),
                    "dimensionInfo" = GSFeatureDimension$new(xml = child),
                    "virtualTable" = GSVirtualTable$new(xml = child)
                  )
                }
                if(is(self, "GSCoverage")){
                  meta <- switch(xml2::xml_name(child),
                    "dimensionInfo" = GSDimension$new(xml = child),
                    "coverageView" = GSCoverageView$new(xml = child)
                  )
                }
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
       links <- sapply(self$metadataLinks, function(x){x$content})
       if(!metadataLink$content %in% links){
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
