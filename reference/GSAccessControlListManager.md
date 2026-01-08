# Geoserver REST API Access Control List Manager

Geoserver REST API Access Control List Manager

Geoserver REST API Access Control List Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing GeoServer Access Control List (ACL) operations.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSAccessControlListManager`

## Methods

### Public methods

- [`GSAccessControlListManager$setCatalogMode()`](#method-GSAccessControlListManager-setCatalogMode)

- [`GSAccessControlListManager$getCatalogMode()`](#method-GSAccessControlListManager-getCatalogMode)

- [`GSAccessControlListManager$getRules()`](#method-GSAccessControlListManager-getRules)

- [`GSAccessControlListManager$addRule()`](#method-GSAccessControlListManager-addRule)

- [`GSAccessControlListManager$addLayerRule()`](#method-GSAccessControlListManager-addLayerRule)

- [`GSAccessControlListManager$addServiceRule()`](#method-GSAccessControlListManager-addServiceRule)

- [`GSAccessControlListManager$addRestRule()`](#method-GSAccessControlListManager-addRestRule)

- [`GSAccessControlListManager$deleteRule()`](#method-GSAccessControlListManager-deleteRule)

- [`GSAccessControlListManager$clone()`](#method-GSAccessControlListManager-clone)

Inherited methods

- [`geosapi::GSManager$ERROR()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-ERROR)
- [`geosapi::GSManager$INFO()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-INFO)
- [`geosapi::GSManager$WARN()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-WARN)
- [`geosapi::GSManager$connect()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-connect)
- [`geosapi::GSManager$getClassName()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getClassName)
- [`geosapi::GSManager$getCoverageStoreManager()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getCoverageStoreManager)
- [`geosapi::GSManager$getDataStoreManager()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getDataStoreManager)
- [`geosapi::GSManager$getNamespaceManager()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getNamespaceManager)
- [`geosapi::GSManager$getServiceManager()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getServiceManager)
- [`geosapi::GSManager$getStyleManager()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getStyleManager)
- [`geosapi::GSManager$getSystemStatus()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getSystemStatus)
- [`geosapi::GSManager$getUrl()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getUrl)
- [`geosapi::GSManager$getWorkspaceManager()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-getWorkspaceManager)
- [`geosapi::GSManager$initialize()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-initialize)
- [`geosapi::GSManager$logger()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-logger)
- [`geosapi::GSManager$monitor()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-monitor)
- [`geosapi::GSManager$reload()`](https://eblondel.github.io/geosapi/reference/GSManager.html#method-reload)

------------------------------------------------------------------------

### Method `setCatalogMode()`

Set the catalog mode

#### Usage

    GSAccessControlListManager$setCatalogMode(
      mode = c("HIDE", "MIXED", "CHALLENGE")
    )

#### Arguments

- `mode`:

  mode

#### Returns

`TRUE` if set, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getCatalogMode()`

Get the catalog mode

#### Usage

    GSAccessControlListManager$getCatalogMode()

#### Returns

the mode either `HIDE`, `MIXED` or `CHALLENGE`

------------------------------------------------------------------------

### Method `getRules()`

Get rules

#### Usage

    GSAccessControlListManager$getRules(domain = c("layers", "services", "rest"))

#### Arguments

- `domain`:

  the access control domain

#### Returns

the list of rules for a given domain

------------------------------------------------------------------------

### Method `addRule()`

Generic method to add an access control rule

#### Usage

    GSAccessControlListManager$addRule(rule)

#### Arguments

- `rule`:

  object of class
  [GSRule](https://eblondel.github.io/geosapi/reference/GSRule.md)

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `addLayerRule()`

Adds an access control layer rule

#### Usage

    GSAccessControlListManager$addLayerRule(
      ws = NULL,
      lyr,
      permission = c("r", "w", "a"),
      roles
    )

#### Arguments

- `ws`:

  the resource workspace. Default is `NULL`

- `lyr`:

  the target layer to which the access control should be added

- `permission`:

  the rule permission, either `r` (read), `w` (write) or `a`
  (administer)

- `roles`:

  one or more roles to add for the rule

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `addServiceRule()`

Adds an access control service rule

#### Usage

    GSAccessControlListManager$addServiceRule(
      service,
      method,
      permission = c("r", "w", "a"),
      roles
    )

#### Arguments

- `service`:

  service subject to the access control rule, eg. 'wfs'

- `method`:

  service method subject to the access control rule, eg. 'GetFeature'

- `permission`:

  the rule permission, either `r` (read), `w` (write) or `a`
  (administer)

- `roles`:

  one or more roles to add for the rule

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `addRestRule()`

Adds an access control rest rule

#### Usage

    GSAccessControlListManager$addRestRule(
      pattern,
      methods,
      permission = c("r", "w", "a"),
      roles
    )

#### Arguments

- `pattern`:

  a URL Ant pattern, only applicable for domain `rest`. Default is `/**`

- `methods`:

  HTTP method(s)

- `permission`:

  the rule permission, either `r` (read), `w` (write) or `a`
  (administer)

- `roles`:

  one or more roles to add for the rule

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteRule()`

Generic method to delete an access control rule

#### Usage

    GSAccessControlListManager$deleteRule(rule)

#### Arguments

- `rule`:

  object of class
  [GSRule](https://eblondel.github.io/geosapi/reference/GSRule.md)

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSAccessControlListManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSAccessControlListManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> <GSAccessControlListManager>
#>   Inherits from: <GSManager>
#>   Public:
#>     ERROR: function (text) 
#>     INFO: function (text) 
#>     WARN: function (text) 
#>     addLayerRule: function (ws = NULL, lyr, permission = c("r", "w", "a"), roles) 
#>     addRestRule: function (pattern, methods, permission = c("r", "w", "a"), roles) 
#>     addRule: function (rule) 
#>     addServiceRule: function (service, method, permission = c("r", "w", "a"), roles) 
#>     clone: function (deep = FALSE) 
#>     connect: function () 
#>     deleteRule: function (rule) 
#>     getCatalogMode: function () 
#>     getClassName: function () 
#>     getCoverageStoreManager: function () 
#>     getDataStoreManager: function () 
#>     getNamespaceManager: function () 
#>     getRules: function (domain = c("layers", "services", "rest")) 
#>     getServiceManager: function () 
#>     getStyleManager: function () 
#>     getSystemStatus: function () 
#>     getUrl: function () 
#>     getWorkspaceManager: function () 
#>     initialize: function (url, user, pwd, logger = NULL, keyring_backend = "env") 
#>     logger: function (type, text) 
#>     loggerType: NULL
#>     monitor: function (file = NULL, append = FALSE, sleep = 1) 
#>     reload: function () 
#>     setCatalogMode: function (mode = c("HIDE", "MIXED", "CHALLENGE")) 
#>     url: http://localhost:8080/geoserver/rest
#>     verbose.debug: FALSE
#>     verbose.info: FALSE
#>     version: NULL
#>   Private:
#>     keyring_backend: backend_env, backend, R6
#>     keyring_service: geosapi@http://localhost:8080/geoserver
#>     user: admin
 # }
```
