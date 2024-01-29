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
#'   lyr <- GSLayerGroup$new()
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSLayerGroup <- R6Class("GSLayerGroup",
   inherit = GSRESTResource,
   
   public = list(
     #'@field full full
     full = TRUE,
     #'@field name name
     name = NULL,
     #'@field mode mode
     mode = NULL,
     #'@field title title
     title = NULL,
     #'@field abstractTxt abstract
     abstractTxt = NULL,
     #'@field workspace workspace
     workspace = NULL,
     #'@field publishables publishables
     publishables = list(),
     #'@field styles styles
     styles = list(),
     #'@field metadataLinks metadata links
     metadataLinks = list(),
     #'@field bounds bounds
     bounds = list(minx = NA, miny = NA, maxx = NA, maxy = NA, crs = NA),
     
     #'@description Initializes an object of class \link{GSLayerGroup}
     #'@param xml object of class \link{xml_node-class}
     initialize = function(xml = NULL){
       super$initialize(rootName = "layerGroup")
       if(!missing(xml) & !is.null(xml)){
         self$decode(xml)
       }
     },
     
     #'@description Decodes from XML
     #'@param xml object of class \link{xml_node-class}
     decode = function(xml){
       xml = xml2::as_xml_document(xml)
       self$name <- xml2::xml_find_first(xml, "//name") %>% xml2::xml_text()
       
       if(self$full){
         
         titles <- xml2::xml_find_first(xml, "//title")
         if(length(titles)>0) self$title <- xml2::xml_text(titles)
         abstracts <- xml2::xml_find_first(xml, "//abstractTxt")
         if(length(abstracts)>0) self$abstractTxt <- xml2::xml_text(abstracts)
         modes <- xml2::xml_find_first(xml, "//mode")
         if(length(modes)>0) self$mode <- xml2::xml_text(modes)
         workspaces <- xml2::xml_find_first(xml, "//workspace")
         if(length(workspaces)>0){
           self$workspace <- GSWorkspace$new(name = xml2::xml_text(workspaces))
         }
         
         #publishables
         publishables <- as(xml2::xml_find_all(xml, "//publishables/published"), "list")
         if(length(publishables)>0){
           self$publishables <- lapply(publishables, GSPublishable$new)
         }
         
         #styles
         styles <- as(xml2::xml_find_all(xml, "//styles/style"), "list")
         if(length(styles)>0){
           styles <- lapply(styles, GSStyle$new)
           self$setStyles(styles)
         }
         
         #metadataLinks
         metadataLinksXML <- as(xml2::xml_find_all(xml, "//metadataLinks/metadataLink"), "list")
         if(length(metadataLinksXML)>0){
           for(metadataLinkXML in metadataLinksXML){
             md <- GSMetadataLink$new(xml = metadataLinkXML)
             self$addMetadataLink(md)
           }
         }
         
         #bounds
         boundsXML <- as(xml2::xml_find_all(xml, "//bounds/*"), "list")
         self$bounds <- lapply(boundsXML, xml2::xml_text)
         names(self$bounds) <-  lapply(boundsXML, xml2::xml_name)
       }
     },
     
     #'@description Set name
     #'@param name name
     setName = function(name){
       self$name = name
     },
     
     #'@description Set mode
     #'@param mode a mode value among "SINGLE", "NAMED", "CONTAINER", "EO"
     setMode = function(mode){
       allowedModes <- c("SINGLE", "NAMED", "CONTAINER", "EO")
       if(!(mode %in% allowedModes)){
         stop(sprintf("Mode should one among values [%s]", paste(allowedModes, collapse=",")))
       }
       self$mode = mode
     },
     
     #'@description Set title
     #'@param title title
     setTitle = function(title){
       self$title = title
     },
     
     #'@description Set abstract
     #'@param abstract abstract
     setAbstract = function(abstract){
       self$abstractTxt = abstract
     },
     
     #'@description Set workspace
     #'@param workspace workspace name, object of class \link{GSWorkspace} or \code{character}
     setWorkspace = function(workspace){
       if(!is(workspace, "GSWorkspace")){
         workspace <- GSWorkspace$new(name = workspace)
       }
       self$workspace = workspace
     },
     
     #'@description Adds layer
     #'@param layer layer name
     #'@param style style name
     addLayer = function(layer, style){
       ps <- GSPublishable$new(name = layer, type = "layer")
       self$addPublishable(ps)
       self$addStyle(style)
     },
     
     #'@description Adds layer group
     #'@param layerGroup layer group
     addLayerGroup = function(layerGroup){
       ps <- GSPublishable$new(name = layer, type = "layerGroup")
       self$addPublishable(ps)
       self$addStyle(NA)
     },
     
     #'@description Adds publishable
     #'@param publishable publishable
     #'@return \code{TRUE} if added, \code{FALSE} otherwise
     addPublishable = function(publishable){
       startNb = length(self$publishables)
       add <- TRUE
       invisible(sapply(self$publishables, function(x){
         if(publishable$name == x$name & publishable$attr_type == x$attr_type){
           add <<- FALSE
         }
       }))
       if(add){
         self$publishables = c(self$publishables, publishable)
       }
       endNb = length(self$publishables)
       return(endNb == startNb+1)
     },
     
     #'@description Set styles
     #'@param styles styles
     setStyles = function(styles){
       if(!is.list(styles)) styles = list(styles)
       self$styles = styles
       return(TRUE)
     },
     
     #'@description Adds a style
     #'@param style style
     #'@return \code{TRUE} if added, \code{FALSE} otherwise
     addStyle = function(style){
        if(is(style, "character")) style <- GSStyle$new(xml=NULL, name = style)
        startNb = length(self$styles)
        self$styles = c(self$styles, style)
        endNb = length(self$styles)
        return(endNb == startNb+1)
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
     
     #'@description Set bounds
     #'@param minx minx
     #'@param miny miny
     #'@param maxx maxx
     #'@param maxy maxy
     #'@param bbox bbox
     #'@param crs crs
     setBounds = function(minx, miny, maxx, maxy, bbox = NULL, crs){
       self$bounds <- GSUtils$setBbox(minx, miny, maxx, maxy, bbox, crs)
     }
     
   )                       
)