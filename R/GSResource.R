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
#' @field name
#' @field nativeName
#' @field title
#' @field description
#' @field abstract
#' @field keywords
#' @field metadataLinks
#' @field projectionPolicy
#' @field srs
#' @field nativeCRS
#' @field latLonBoundingBox
#' @field nativeBoundingBox
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
     allowedProjectionPolicies = c("NONE", "FORCE_DECLARED", "REPROJECT_TO_DECLARED"),
     
     setBbox = function(minx, miny, maxx, maxy, bbox = NULL, crs){
       
       if(!missing(bbox) & !is.null(bbox)){
         if(class(bbox) != "matrix") stop("Bbox is not a valid bounding box matrix")
         if(all(dim(bbox) != c(2,2))) stop("Bbox is not a valid bounding box matrix")
         minx = bbox[1L,1L]
         miny = bbox[2L,1L]
         maxx = bbox[1L,2L]
         maxy = bboc[2L,2L]
       }
       
       out <- list()
       out[["minx"]] = minx
       out[["miny"]] = miny
       out[["maxx"]] = maxx
       out[["maxy"]] = maxy
       out[["crs"]] = crs
       return(out)
     }
     
   ),
   
   public = list(
     full = TRUE,
     name = NULL,
     nativeName = NULL,
     title = NULL,
     description = NULL,
     abstract = NULL,
     keywords = list(),
     metadataLinks = list(),
     nativeCRS = NULL,
     srs = NULL,
     nativeBoundingBox = list(minx = NA, miny = NA, maxx = NA, maxy = NA, crs = NA),
     latLonBoundingBox = list(minx = NA, miny = NA, maxx = NA, maxy = NA, crs = NA),
     projectionPolicy = NULL,
     enabled = TRUE,
     metadata = NULL,
     
     initialize = function(rootName = NULL, xml = NULL){
        super$initialize(rootName = rootName)
        if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
        }
     },
     
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
         self$nativeCRS <- xmlValue(nativeCRS[[1]])
         
         srs <- getNodeSet(xml, "//srs")
         self$srs <- xmlValue(srs[[1]])
         
         latLonBboxXML <- getNodeSet(xml, "//latLonBoundingBox/*")
         self$latLonBoundingBox <- lapply(latLonBboxXML, xmlValue)
         names(self$latLonBoundingBox) <-  lapply(latLonBboxXML, xmlName)
         
         nativeBboxXML <- getNodeSet(xml, "//nativeBoundingBox/*")
         self$nativeBoundingBox <- lapply(nativeBboxXML, xmlValue)
         names(self$nativeBoundingBox) <-  lapply(nativeBboxXML, xmlName)
         
         projPolicies <- getNodeSet(xml, "//projectionPolicy")
         self$projectionPolicy <- xmlValue(projPolicies[[1]])
         
         metadata <- getNodeSet(xml, "//metadata/entry")
         if(length(metadata)>0){
           for(md in metadata){
              key <- xmlGetAttr(md, "key")
              child <- xmlChildren(md)
              if(names(child) == "dimensionInfo"){
                if(any(class(self) == "GSFeatureType")){
                  dim <- GSFeatureDimension$new(xml = child$dimensionInfo)
                }else{
                  dim <- GSDimension$new(xml = child$dimensionInfo)
                }
                self$setMetadata(key, dim)   
              }
           }
         }
       }
     },
     
     setEnabled = function(enabled){
       self$enabled = enabled
     },
     
     setName = function(name){
       self$name = name
     },
     
     setNativeName = function(nativeName){
       self$nativeName = nativeName
     },
     
     setTitle = function(title){
       self$title = title
     },
     
     setDescription = function(description){
       self$description = description
     },
     
     setAbstract = function(abstract){
       self$abstract = abstract
     },
     
     setKeywords = function(keywords){
       if(!is.list(keywords)) keywords = list(keywords)
       self$keywords = keywords
       return(TRUE)
     },
     
     addKeyword = function(keyword){
       startNb = length(self$keywords)
       if(length(which(self$keywords == keyword)) == 0){
         self$keywords = c(self$keywords, keyword)
       }
       endNb = length(self$keywords)
       return(endNb == startNb+1)
     },
     
     delKeyword = function(keyword){
       startNb = length(self$keywords)
       self$keywords = self$keywords[which(self$keywords != keyword)]
       endNb = length(self$keywords)
       return(endNb == startNb-1)
     },
     
     setMetadataLinks = function(metadataLinks){
       self$metadataLinks <- metadataLinks
     },
     
     addMetadataLink = function(metadataLink){
       startNb = length(self$metadataLinks)
       links <- lapply(self$metadataLinks, function(x){x$content})
       if(length(which(links == metadataLink$content)) == 0){
         self$metadataLinks = c(self$metadataLinks, metadataLink)
       }
       endNb = length(self$metadataLinks)
       return(endNb == startNb+1)
     },
     
     deleteMetadataLink = function(metadataLink){
       startNb = length(self$metadataLinks)
       links <- lapply(self$metadataLinks, function(x){x$content})
       self$metadataLinks = self$metadataLinks[which(links != metadataLink$content)]
       endNb = length(self$metadataLinks)
       return(endNb == startNb-1)
     },
     
     setProjectionPolicy = function(projectionPolicy){
       if(!(projectionPolicy %in% private$allowedProjectionPolicies)){
        stop(sprintf("'%s' is not a valid projection policy", projectionPolicy))
       }
       self$projectionPolicy = projectionPolicy
     },
     
     setSrs = function(srs){
       self$srs = srs
     },
     
     setNativeCRS = function(nativeCRS){
       self$nativeCRS = nativeCRS
     },

     setLatLonBoundingBox = function(minx, miny, maxx, maxy, bbox = NULL, crs){
       self$latLonBoundingBox <- private$setBbox(minx, miny, maxx, maxy, bbox, crs)
     },
     
     setNativeBoundingBox = function(minx, miny, maxx, maxy, bbox = NULL, crs){
       self$nativeBoundingBox <- private$setBbox(minx, miny, maxx, maxy, bbox, crs)
     },
     
     setMetadata = function(key, metadata){
       if(is.null(self$metadata)){
         self$metadata = GSRESTEntrySet$new(rootName = "metadata")
       }
       added <- self$metadata$addEntry(key, metadata)
       return(added)
     },
     
     delMetadata = function(key){
       deleted <- FALSE
       if(!is.null(self$metadata)){
        deleted <- self$metadata$delEntry(key)
        if(length(self$metadataentryset)==0) self$metadata = NULL
       }
       return(deleted)
     },
     
     setMetadataDimension = function(key, dimension, custom = FALSE){
      if(custom) key <- paste0("custom_dimension_", toupper(key))
      added <- self$setMetadata(key, dimension)
      return(added)
     }
   )                     
)