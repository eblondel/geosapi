#' Geoserver REST API Access Control List Manager
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver rest api access control list ACL
#' @return Object of \code{\link[R6]{R6Class}} with methods for managing GeoServer
#' Access Control List (ACL) operations.
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    GSAccessControlListManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#'  }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSAccessControlListManager <- R6Class("GSAccessControlListManager",
  inherit = GSManager,
  
  public = list(
    
    #'@description Set the catalog mode
    #'@param mode mode
    #'@return \code{TRUE} if set, \code{FALSE} otherwise
    setCatalogMode = function(mode = c("HIDE","MIXED","CHALLENGE")){
      mode = match.arg(mode)
      msg = sprintf("Setting catalog mode '%s'", mode)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      
      created <- FALSE
      
      catalogXml = xml2::xml_new_root("catalog")
      modeXml = xml2::xml_new_root("mode")
      xml2::xml_set_text(modeXml, mode)
      xml2::xml_add_child(catalogXml, modeXml)
      
      req <- GSUtils$PUT(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = "/security/acl/catalog.xml",
        content = as(catalogXml, "character"),
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfuly set catalog mode!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while setting catalog mode"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(created)
    },
    
    #'@description Get the catalog mode
    #'@return the mode either \code{HIDE}, \code{MIXED} or \code{CHALLENGE}
    getCatalogMode = function(){
      msg = "Fetching catalog mode"
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        "/security/acl/catalog.xml", verbose = self$verbose.debug)
      catalogMode <- NULL
      if(status_code(req) == 200){
        ctXML <- GSUtils$parseResponseXML(req)
        catalogMode = xml2::xml_find_first(ctXML, "//catalog/mode") %>% xml2::xml_contents() %>% as.character()
        msg = "Successfuly fetched catalog mode!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = "Error while fetching catalog mode"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(catalogMode)
    }
    
    
  )
)