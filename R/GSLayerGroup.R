#' Geoserver REST API LayerGroup
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' 
#' @name GSLayerGroup
#' @title A GeoServer layergroup resource
#' @description This class models a GeoServer layer group. This class is to be
#' used for clustering layers into a group.
#' @keywords geoserver rest api resource featureType coverage layer layer group
#' @return Object of \code{\link{R6Class}} for modelling a GeoServer layergroup
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' lyr <- GSLayerGroup$new()
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(rootName, xml)}}{
#'    This method is used to instantiate a GSLayer
#'  }
#'  \item{\code{decode(xml)}}{
#'    This method is used to decode a GSLayer from XML
#'  }
#'  \item{\code{encode()}}{
#'    This method is used to encode a GSLayer to XML. Inherited from the
#'    generic \code{GSRESTResource} encoder
#'  }
#'  \item{\code{setName(name)}}{
#'    Sets the name.
#'  }
#'  \item{\code{setTitle(title)}}{
#'    Sets the title.
#'  }
#'  \item{\code{setAbstract(abstract)}}{
#'    Sets the abstract.
#'  }
#'  \item{\code{setMode(mode)}}{
#'    Sets the mode.
#'  }
#'  \item{\code{setWorkspace(ws)}}{
#'    Sets the worksapce
#'  }
#'  \item{\code{addLayer(layer)}}{
#'    Adds a layer
#'  }
#'  \item{\code{delLayer(layer)}}{
#'    Deletes a layer
#'  }
#'  \item{\code{addLayerGroup(layerGroup)}}{
#'    Adds a layer group
#'  }
#'  \item{\code{delLayerGroup(layerGroup)}}{
#'    Deletes a layer group
#'  }
#'  \item{\code{setStyles(styles)}}{
#'    Sets a list of optional styles
#'  }
#'  \item{\code{addStyle(style)}}{
#'    Sets an available style. Returns TRUE if set, FALSE otherwise
#'  }
#'  \item{\code{delStyle(name)}}{
#'    Deletes an available. Returns TRUE if deleted, FALSE otherwise
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
#'  \item{\code{setBounds(minx, miny, maxx, maxy, bbox, crs)}}{
#'    Sets the layer group bounds. Either from coordinates or from
#'    a \code{bbox} object (matrix).
#'  }
#'}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSLayerGroup <- R6Class("GSLayerGroup",
   inherit = GSRESTResource,
   
   public = list(
     full = TRUE,
     name = NULL,
     mode = NULL,
     title = NULL,
     abstractTxt = NULL,
     workspace = NULL,
     publishables = list(),
     styles = list(),
     metadataLinks = list(),
     bounds = list(minx = NA, miny = NA, maxx = NA, maxy = NA, crs = NA),
     
     
     initialize = function(xml = NULL){
       super$initialize(rootName = "layerGroup")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     decode = function(xml){
       names <- getNodeSet(xml, "//name")
       self$name <- xmlValue(names[[1]])
       
       if(self$full){
         
         titles <- getNodeSet(xml, "//title")
         if(length(titles)>0) self$title <- xmlValue(titles[[1]])
         abstracts <- getNodeSet(xml, "//abstractTxt")
         if(length(abstracts)>0) self$abstractTxt <- xmlValue(abstracts[[1]])
         modes <- getNodeSet(xml, "//mode")
         if(length(modes)>0) self$mode <- xmlValue(modes[[1]])
         workspaces <- getNodeSet(xml, "//workspace")
         if(length(workspaces)>0){
           self$workspace <- GSWorkspace$new(name = xmlValue(workspaces[[1]]))
         }
         
         #publishables
         publishables <-getNodeSet(xml, "//publishables/publishable")
         if(length(publishables)>0){
           self$publishables <- lapply(publishables, function(x){
             child <- xmlChildren(x)
             ps <- GSPublishable$new()
             ps$setName(xmlValue(child$name))
             ps$setType(xmlGetAttr(x, "type"))
             return(ps)
           })
         }
         
         #styles
         styles <- getNodeSet(xml, "//styles/style")
         if(length(styles)>0){
           styles <- lapply(styles, function(x){
             child <- xmlChildren(x)
             style <- GSStyle$new()
             style$setName(xmlValue(child$name))
             if("filename" %in% names(child)){
               style$setFilename(xmlValue(child$filename))
             }
             return(style)
           })
           self$setStyles(styles)
         }
         
         #metadataLinks
         metadataLinksXML <- getNodeSet(xml, "//metadataLinks/metadataLink")
         if(length(metadataLinksXML)>0){
           for(metadataLinkXML in metadataLinksXML){
             md <- GSMetadataLink$new(xml = metadataLinkXML)
             self$addMetadataLink(md)
           }
         }
         
         #bounds
         boundsXML <- getNodeSet(xml, "//bounds/*")
         self$bounds <- lapply(boundsXML, xmlValue)
         names(self$bounds) <-  lapply(boundsXML, xmlName)
       }
     },
     
     setName = function(name){
       self$name = name
     },
     
     setMode = function(mode){
       allowedModes <- c("SINGLE", "NAMED", "CONTAINER", "EO")
       if(!(mode %in% allowedModes)){
         stop(sprintf("Mode should one among values [%s]", paste(allowedModes, collapse=",")))
       }
       self$mode = mode
     },
     
     setTitle = function(title){
       self$title = title
     },
     
     setAbstract = function(abstract){
       self$abstractTxt = abstract
     },
     
     setWorkspace = function(workspace){
       if(!is(workspace, "GSWorkspace")){
         workspace <- GSWorkspace$new(name = workspace)
       }
       self$workspace = workspace
     },
     
     addLayer = function(layer, style){
       ps <- GSPublishable$new(name = layer, type = "layer")
       self$addPublishable(ps)
       self$addStyle(style)
     },
     
     addLayerGroup = function(layerGroup){
       ps <- GSPublishable$new(name = layer, type = "layerGroup")
       self$addPublishable(ps)
       self$addStyle(NA)
     },
     
     addPublishable = function(publishable){
       startNb = length(self$publishables)
       add <- TRUE
       invisible(sapply(self$publishables, function(x){
         if(publishable$name == x$name & publishable$type == x$type){
           add <<- FALSE
         }
       }))
       if(add){
         self$publishables = c(self$publishables, publishable)
       }
       endNb = length(self$publishables)
       return(endNb == startNb+1)
     },
     
     setStyles = function(styles){
       if(!is.list(styles)) styles = list(styles)
       self$styles = styles
       return(TRUE)
     },
     
     addStyle = function(style){
        if(class(style) == "character") style <- GSStyle$new(xml=NULL, name = style)
        startNb = length(self$styles)
        self$styles = c(self$styles, style)
        endNb = length(self$styles)
        return(endNb == startNb+1)
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
     
     setBounds = function(minx, miny, maxx, maxy, bbox = NULL, crs){
       self$bounds <- GSUtils$setBbox(minx, miny, maxx, maxy, bbox, crs)
     }
     
   )                       
)