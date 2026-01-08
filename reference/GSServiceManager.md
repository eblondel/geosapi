# Geoserver REST API Service Manager

Geoserver REST API Service Manager

Geoserver REST API Service Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing GeoServer services

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSServiceManager`

## Methods

### Public methods

- [`GSServiceManager$getServiceSettings()`](#method-GSServiceManager-getServiceSettings)

- [`GSServiceManager$getWmsSettings()`](#method-GSServiceManager-getWmsSettings)

- [`GSServiceManager$getWfsSettings()`](#method-GSServiceManager-getWfsSettings)

- [`GSServiceManager$getWcsSettings()`](#method-GSServiceManager-getWcsSettings)

- [`GSServiceManager$updateServiceSettings()`](#method-GSServiceManager-updateServiceSettings)

- [`GSServiceManager$deleteServiceSettings()`](#method-GSServiceManager-deleteServiceSettings)

- [`GSServiceManager$updateWmsSettings()`](#method-GSServiceManager-updateWmsSettings)

- [`GSServiceManager$updateWfsSettings()`](#method-GSServiceManager-updateWfsSettings)

- [`GSServiceManager$updateWcsSettings()`](#method-GSServiceManager-updateWcsSettings)

- [`GSServiceManager$enableWMS()`](#method-GSServiceManager-enableWMS)

- [`GSServiceManager$enableWFS()`](#method-GSServiceManager-enableWFS)

- [`GSServiceManager$enableWCS()`](#method-GSServiceManager-enableWCS)

- [`GSServiceManager$disableServiceSettings()`](#method-GSServiceManager-disableServiceSettings)

- [`GSServiceManager$disableWMS()`](#method-GSServiceManager-disableWMS)

- [`GSServiceManager$disableWFS()`](#method-GSServiceManager-disableWFS)

- [`GSServiceManager$disableWCS()`](#method-GSServiceManager-disableWCS)

- [`GSServiceManager$clone()`](#method-GSServiceManager-clone)

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

### Method `getServiceSettings()`

Get the service settings. To get the service settings for a specific
workspace, specify the workspace name as `ws` parameter, otherwise
global settings are retrieved.

#### Usage

    GSServiceManager$getServiceSettings(service, ws = NULL)

#### Arguments

- `service`:

  service

- `ws`:

  workspace name

#### Returns

an object of class
[GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

------------------------------------------------------------------------

### Method `getWmsSettings()`

Get WMS settings. To get the WMS settings for a specific workspace,
specify the workspace name as `ws` parameter, otherwise global settings
are retrieved.

#### Usage

    GSServiceManager$getWmsSettings(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

an object of class
[GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

------------------------------------------------------------------------

### Method `getWfsSettings()`

Get WFS settings. To get the WFS settings for a specific workspace,
specify the workspace name as `ws` parameter, otherwise global settings
are retrieved.

#### Usage

    GSServiceManager$getWfsSettings(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

an object of class
[GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

------------------------------------------------------------------------

### Method `getWcsSettings()`

Get WCS settings. To get the WCS settings for a specific workspace,
specify the workspace name as `ws` parameter, otherwise global settings
are retrieved.

#### Usage

    GSServiceManager$getWcsSettings(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

an object of class
[GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

------------------------------------------------------------------------

### Method `updateServiceSettings()`

Updates the service settings with an object of class
`GSServiceSettings`. An optional workspace name `ws` can be specified to
update service settings applying to a workspace.

#### Usage

    GSServiceManager$updateServiceSettings(serviceSettings, service, ws = NULL)

#### Arguments

- `serviceSettings`:

  serviceSettings object of class
  [GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

- `service`:

  service

- `ws`:

  workspace name

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteServiceSettings()`

Deletes the service settings. This method is used internally by geosapi
for disabling a service setting at workspace level.

#### Usage

    GSServiceManager$deleteServiceSettings(service, ws = NULL)

#### Arguments

- `service`:

  service

- `ws`:

  workspace name

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateWmsSettings()`

Updates the WMS settings with an object of class `GSServiceSettings`. An
optional workspace name `ws` can be specified to update WMS settings
applying to a workspace.

#### Usage

    GSServiceManager$updateWmsSettings(serviceSettings, ws = NULL)

#### Arguments

- `serviceSettings`:

  service settings object of class
  [GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

- `ws`:

  workspace name

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateWfsSettings()`

Updates the WFS settings with an object of class `GSServiceSettings`. An
optional workspace name `ws` can be specified to update WFS settings
applying to a workspace.

#### Usage

    GSServiceManager$updateWfsSettings(serviceSettings, ws = NULL)

#### Arguments

- `serviceSettings`:

  service settings object of class
  [GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

- `ws`:

  workspace name

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateWcsSettings()`

Updates the WCS settings with an object of class `GSServiceSettings`. An
optional workspace name `ws` can be specified to update WCS settings
applying to a workspace.

#### Usage

    GSServiceManager$updateWcsSettings(serviceSettings, ws = NULL)

#### Arguments

- `serviceSettings`:

  service settings object of class
  [GSServiceSettings](https://eblondel.github.io/geosapi/reference/GSServiceSettings.md)

- `ws`:

  workspace name

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `enableWMS()`

Enables WMS service settings

#### Usage

    GSServiceManager$enableWMS(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

`TRUE` if enabled, `FALSE` otherwise

------------------------------------------------------------------------

### Method `enableWFS()`

Enables WFS service settings

#### Usage

    GSServiceManager$enableWFS(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

`TRUE` if enabled, `FALSE` otherwise

------------------------------------------------------------------------

### Method `enableWCS()`

Enables WCS service settings

#### Usage

    GSServiceManager$enableWCS(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

`TRUE` if enabled, `FALSE` otherwise

------------------------------------------------------------------------

### Method `disableServiceSettings()`

Disables service settings

#### Usage

    GSServiceManager$disableServiceSettings(service, ws = NULL)

#### Arguments

- `service`:

  service

- `ws`:

  workspace name

#### Returns

`TRUE` if disabled, `FALSE` otherwise

------------------------------------------------------------------------

### Method `disableWMS()`

Disables WMS service settings

#### Usage

    GSServiceManager$disableWMS(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

`TRUE` if disabled, `FALSE` otherwise

------------------------------------------------------------------------

### Method `disableWFS()`

Disables WFS service settings

#### Usage

    GSServiceManager$disableWFS(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

`TRUE` if disabled, `FALSE` otherwise

------------------------------------------------------------------------

### Method `disableWCS()`

Disables WCS service settings

#### Usage

    GSServiceManager$disableWCS(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

`TRUE` if disabled, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSServiceManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSServiceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> <GSServiceManager>
#>   Inherits from: <GSManager>
#>   Public:
#>     ERROR: function (text) 
#>     INFO: function (text) 
#>     WARN: function (text) 
#>     clone: function (deep = FALSE) 
#>     connect: function () 
#>     deleteServiceSettings: function (service, ws = NULL) 
#>     disableServiceSettings: function (service, ws = NULL) 
#>     disableWCS: function (ws = NULL) 
#>     disableWFS: function (ws = NULL) 
#>     disableWMS: function (ws = NULL) 
#>     enableWCS: function (ws = NULL) 
#>     enableWFS: function (ws = NULL) 
#>     enableWMS: function (ws = NULL) 
#>     getClassName: function () 
#>     getCoverageStoreManager: function () 
#>     getDataStoreManager: function () 
#>     getNamespaceManager: function () 
#>     getServiceManager: function () 
#>     getServiceSettings: function (service, ws = NULL) 
#>     getStyleManager: function () 
#>     getSystemStatus: function () 
#>     getUrl: function () 
#>     getWcsSettings: function (ws = NULL) 
#>     getWfsSettings: function (ws = NULL) 
#>     getWmsSettings: function (ws = NULL) 
#>     getWorkspaceManager: function () 
#>     initialize: function (url, user, pwd, logger = NULL, keyring_backend = "env") 
#>     logger: function (type, text) 
#>     loggerType: NULL
#>     monitor: function (file = NULL, append = FALSE, sleep = 1) 
#>     reload: function () 
#>     updateServiceSettings: function (serviceSettings, service, ws = NULL) 
#>     updateWcsSettings: function (serviceSettings, ws = NULL) 
#>     updateWfsSettings: function (serviceSettings, ws = NULL) 
#>     updateWmsSettings: function (serviceSettings, ws = NULL) 
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
