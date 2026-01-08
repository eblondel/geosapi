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
    },
    
    #'@description Get rules
    #'@param domain the access control domain
    #'@return the list of rules for a given domain
    getRules = function(domain = c("layers", "services", "rest")){
      domain = match.arg(domain)
      msg = sprintf("Fetching rules for %s", domain)
      cli::cli_alert_info(msg)
      self$INFO(msg)
      req <- GSUtils$GET(
        self$getUrl(), private$user, 
        private$keyring_backend$get(service = private$keyring_service, username = private$user),
        sprintf("/security/acl/%s.xml", domain), verbose = self$verbose.debug)
      rules <- NULL
      if(status_code(req) == 200){
        rXML <- GSUtils$parseResponseXML(req)
        rXMLList <- as(xml2::xml_find_all(rXML, "//rules/rule"), "list")
        
        GSRuleClass <- switch(domain,
          "layers" = GSLayerRule,
          "services" = GSServiceRule,
          "rest" = GSRestRule
        )
        
        rules <- lapply(rXMLList, GSRuleClass$new)
        msg = sprintf("Successfuly fetched rules for %s!", domain)
        cli::cli_alert_success(msg)
        self$INFO(msg)
      }else{
        err = sprintf("Error while fetching %s rules", domain)
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(rules)
    },
    
    #'@description Generic method to add an access control rule
    #'@param rule object of class \link{GSRule}
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
    addRule = function(rule){

      if(!is(rule, "GSRule")){
        msg = "Argument 'rule' should be an object of class 'GSLayerRule', 'GSServiceRule', or 'GSRestRule'"
        cli::cli_alert_danger(msg)
        self$ERROR(msg)
        stop(msg)
      }
      
      domain <- switch(class(rule)[1],
        "GSLayerRule" = "layers",
        "GSServiceRule" = "services",
        "GSRestRule" = "rest"
      )
      
      msg = sprintf("Adding %s rule for resource '%s'", domain, rule$attrs$resource)
      cli::cli_alert_info(msg)
      self$INFO(msg)

      created <- FALSE
      req <- GSUtils$POST(
        url = self$getUrl(), user = private$user,
        pwd = private$keyring_backend$get(service = private$keyring_service, username = private$user),
        path = sprintf("/security/acl/%s.xml", domain),
        content = {
          xml = xml2::xml_new_root("rules")
          xml2::xml_add_child(xml, rule$encode())
          gsub("[\r\n ] ", "", as(xml, "character"))
        },
        contentType = "application/xml",
        verbose = self$verbose.debug
      )
      if(status_code(req) == 200){
        msg = "Successfuly added access control rule!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        created = TRUE
      }else{
        err = "Error while adding access control rule"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(created)
    },
    
    #'@description Adds an access control layer rule
    #'@param ws the resource workspace. Default is \code{NULL}
    #'@param lyr the target layer to which the access control should be added
    #'@param permission the rule permission, either \code{r} (read), \code{w} (write) or \code{a} (administer)
    #'@param roles one or more roles to add for the rule
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
    addLayerRule = function(
      ws = NULL, lyr,
      permission = c("r","w","a"), 
      roles){
      
      permission = match.arg(permission)
      
      #checks on workspace (if any) and layer
      if(!is.null(self$getWorkspace)){ #assumes parent GSManager is used
        if(!is.null(ws)){
          ws_obj = self$getWorkspace(ws)
          if(is.null(ws_obj)){
            err = sprintf("No workspace '%s'", ws)
            cli::cli_alert_danger(err)
            self$ERROR(err)
            return(FALSE)
          }
        }
        
        lyr_obj = self$getLayer(lyr = lyr)
        if(is.null(lyr_obj)){
          err = sprintf("No layer '%s.'", lyr)
          cli::cli_alert_danger(err)
          self$ERROR(err)
          return(FALSE)
        }
      }
      
      rule <- GSLayerRule$new(
        ws = ws, target = lyr,
        permission = permission,
        roles = roles
      )
      
      self$addRule(rule)
      
    },
    
    #'@description Adds an access control service rule
    #'@param service service subject to the access control rule, eg. 'wfs'
    #'@param method service method subject to the access control rule, eg. 'GetFeature'
    #'@param permission the rule permission, either \code{r} (read), \code{w} (write) or \code{a} (administer)
    #'@param roles one or more roles to add for the rule
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
    addServiceRule = function(
      service, method,
      permission = c("r","w","a"), 
      roles){
      
      permission = match.arg(permission)
      
      rule <- GSServiceRule$new(
        service = service, method = method,
        permission = permission,
        roles = roles
      )
      
      self$addRule(rule)
      
    },
    
    #'@description Adds an access control rest rule
    #'@param pattern a URL Ant pattern, only applicable for domain \code{rest}. Default is \code{/**}
    #'@param methods HTTP method(s)
    #'@param permission the rule permission, either \code{r} (read), \code{w} (write) or \code{a} (administer)
    #'@param roles one or more roles to add for the rule
    #'@return \code{TRUE} if added, \code{FALSE} otherwise
    addRestRule = function(
      pattern, methods,
      permission = c("r","w","a"), 
      roles){
      
      permission = match.arg(permission)
      
      rule <- GSRestRule$new(
        pattern = pattern, methods = methods,
        permission = permission,
        roles = roles
      )
      
      self$addRule(rule)
      
    },
    
    #'@description Generic method to delete an access control rule
    #'@param rule object of class \link{GSRule}
    #'@return \code{TRUE} if deleted, \code{FALSE} otherwise
    deleteRule = function(rule){

      if(!is(rule, "GSRule")){
        msg = "Argument 'rule' should be an object of class 'GSLayerRule', 'GSServiceRule', or 'GSRestRule'"
        cli::cli_alert_danger(msg)
        self$ERROR(msg)
        stop(msg)
      }
      
      domain <- switch(class(rule)[1],
                       "GSLayerRule" = "layers",
                       "GSServiceRule" = "services",
                       "GSRestRule" = "rest"
      )
      
      resource = rule$attrs$resource
      
      msg = sprintf("Deleting access control rule for '%s'", resource)
      cli::cli_alert_info(msg)
      self$INFO(msg)
     
      deleted <- FALSE
      if(domain == "rest"){
        resource = gsub("/", URLencode("/",reserved = T), resource)
      }
      path <- sprintf("/security/acl/%s/%s", domain, resource)
      req <- GSUtils$DELETE(self$getUrl(), private$user, 
                            private$keyring_backend$get(service = private$keyring_service, username = private$user),
                            path = path, verbose = self$verbose.debug)
      if(status_code(req) == 200){
        msg = "Successfuly deleted access control rule!"
        cli::cli_alert_success(msg)
        self$INFO(msg)
        deleted = TRUE
      }else{
        err = "Error while deleting access control rule"
        cli::cli_alert_danger(err)
        self$ERROR(err)
      }
      return(deleted)
    }
  )
)