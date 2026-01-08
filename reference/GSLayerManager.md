# Geoserver REST API Layer Manager

Geoserver REST API Layer Manager

Geoserver REST API Layer Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing GeoServer Layers as results of published feature
types or coverages

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSLayerManager`

## Methods

### Public methods

- [`GSLayerManager$getLayers()`](#method-GSLayerManager-getLayers)

- [`GSLayerManager$getLayerNames()`](#method-GSLayerManager-getLayerNames)

- [`GSLayerManager$getLayer()`](#method-GSLayerManager-getLayer)

- [`GSLayerManager$createLayer()`](#method-GSLayerManager-createLayer)

- [`GSLayerManager$updateLayer()`](#method-GSLayerManager-updateLayer)

- [`GSLayerManager$deleteLayer()`](#method-GSLayerManager-deleteLayer)

- [`GSLayerManager$getLayerGroups()`](#method-GSLayerManager-getLayerGroups)

- [`GSLayerManager$getLayerGroupNames()`](#method-GSLayerManager-getLayerGroupNames)

- [`GSLayerManager$getLayerGroup()`](#method-GSLayerManager-getLayerGroup)

- [`GSLayerManager$createLayerGroup()`](#method-GSLayerManager-createLayerGroup)

- [`GSLayerManager$updateLayerGroup()`](#method-GSLayerManager-updateLayerGroup)

- [`GSLayerManager$deleteLayerGroup()`](#method-GSLayerManager-deleteLayerGroup)

- [`GSLayerManager$clone()`](#method-GSLayerManager-clone)

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

### Method `getLayers()`

Get the list of layers.

#### Usage

    GSLayerManager$getLayers()

#### Returns

an object of class `list` giving items of class
[`GSLayer`](https://eblondel.github.io/geosapi/reference/GSLayer.md)

------------------------------------------------------------------------

### Method `getLayerNames()`

Get the list of layer names.

#### Usage

    GSLayerManager$getLayerNames()

#### Returns

a vector of class `character`

------------------------------------------------------------------------

### Method `getLayer()`

Get layer by name

#### Usage

    GSLayerManager$getLayer(lyr)

#### Arguments

- `lyr`:

  layer name

#### Returns

an object of class
[GSLayer](https://eblondel.github.io/geosapi/reference/GSLayer.md)

------------------------------------------------------------------------

### Method `createLayer()`

Creates a new layer given an object of class
[`GSLayer`](https://eblondel.github.io/geosapi/reference/GSLayer.md)

#### Usage

    GSLayerManager$createLayer(layer)

#### Arguments

- `layer`:

  object of class
  [GSLayer](https://eblondel.github.io/geosapi/reference/GSLayer.md)

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateLayer()`

Updates a layer given an object of class
[`GSLayer`](https://eblondel.github.io/geosapi/reference/GSLayer.md)

#### Usage

    GSLayerManager$updateLayer(layer)

#### Arguments

- `layer`:

  object of class
  [GSLayer](https://eblondel.github.io/geosapi/reference/GSLayer.md)

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteLayer()`

Deletes layer given an object of class
[`GSLayer`](https://eblondel.github.io/geosapi/reference/GSLayer.md)

#### Usage

    GSLayerManager$deleteLayer(lyr)

#### Arguments

- `lyr`:

  layer name

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getLayerGroups()`

Get layer groups

#### Usage

    GSLayerManager$getLayerGroups(ws = NULL)

#### Arguments

- `ws`:

  workspace name. Optional

#### Returns

a list of objects of class
[GSLayerGroup](https://eblondel.github.io/geosapi/reference/GSLayerGroup.md)

------------------------------------------------------------------------

### Method `getLayerGroupNames()`

Get layer group names

#### Usage

    GSLayerManager$getLayerGroupNames(ws = NULL)

#### Arguments

- `ws`:

  workspace name

#### Returns

a list of layer group names, as vector of class `character`

------------------------------------------------------------------------

### Method `getLayerGroup()`

Get layer group

#### Usage

    GSLayerManager$getLayerGroup(lyr, ws = NULL)

#### Arguments

- `lyr`:

  lyr

- `ws`:

  workspace name

#### Returns

an object of class
[GSLayerGroup](https://eblondel.github.io/geosapi/reference/GSLayerGroup.md)

------------------------------------------------------------------------

### Method `createLayerGroup()`

Creates a layer group

#### Usage

    GSLayerManager$createLayerGroup(layerGroup, ws = NULL)

#### Arguments

- `layerGroup`:

  object of class
  [GSLayerGroup](https://eblondel.github.io/geosapi/reference/GSLayerGroup.md)

- `ws`:

  workspace name. Optional

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateLayerGroup()`

Updates a layer group

#### Usage

    GSLayerManager$updateLayerGroup(layerGroup, ws = NULL)

#### Arguments

- `layerGroup`:

  object of class
  [GSLayerGroup](https://eblondel.github.io/geosapi/reference/GSLayerGroup.md)

- `ws`:

  workspace name. Optional

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteLayerGroup()`

Deletes a layer group

#### Usage

    GSLayerManager$deleteLayerGroup(lyr, ws = NULL)

#### Arguments

- `lyr`:

  layer group name

- `ws`:

  workspace name. Optional

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSLayerManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSLayerManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> <GSLayerManager>
#>   Inherits from: <GSManager>
#>   Public:
#>     ERROR: function (text) 
#>     INFO: function (text) 
#>     WARN: function (text) 
#>     clone: function (deep = FALSE) 
#>     connect: function () 
#>     createLayer: function (layer) 
#>     createLayerGroup: function (layerGroup, ws = NULL) 
#>     deleteLayer: function (lyr) 
#>     deleteLayerGroup: function (lyr, ws = NULL) 
#>     getClassName: function () 
#>     getCoverageStoreManager: function () 
#>     getDataStoreManager: function () 
#>     getLayer: function (lyr) 
#>     getLayerGroup: function (lyr, ws = NULL) 
#>     getLayerGroupNames: function (ws = NULL) 
#>     getLayerGroups: function (ws = NULL) 
#>     getLayerNames: function () 
#>     getLayers: function () 
#>     getNamespaceManager: function () 
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
#>     updateLayer: function (layer) 
#>     updateLayerGroup: function (layerGroup, ws = NULL) 
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
