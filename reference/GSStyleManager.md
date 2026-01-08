# Geoserver REST API Style Manager

Geoserver REST API Style Manager

Geoserver REST API Style Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing the styles of a GeoServer instance.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSStyleManager`

## Methods

### Public methods

- [`GSStyleManager$getStyles()`](#method-GSStyleManager-getStyles)

- [`GSStyleManager$getStyleNames()`](#method-GSStyleManager-getStyleNames)

- [`GSStyleManager$getStyle()`](#method-GSStyleManager-getStyle)

- [`GSStyleManager$createStyle()`](#method-GSStyleManager-createStyle)

- [`GSStyleManager$updateStyle()`](#method-GSStyleManager-updateStyle)

- [`GSStyleManager$deleteStyle()`](#method-GSStyleManager-deleteStyle)

- [`GSStyleManager$getSLDVersion()`](#method-GSStyleManager-getSLDVersion)

- [`GSStyleManager$getSLDBody()`](#method-GSStyleManager-getSLDBody)

- [`GSStyleManager$clone()`](#method-GSStyleManager-clone)

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

### Method `getStyles()`

Get the list of available styles.

#### Usage

    GSStyleManager$getStyles(ws = NULL)

#### Arguments

- `ws`:

  an optional workspace name

#### Returns

an object of class `list` containing items of class
[`GSStyle`](https://eblondel.github.io/geosapi/reference/GSLayer.md)

------------------------------------------------------------------------

### Method `getStyleNames()`

Get the list of available style names

#### Usage

    GSStyleManager$getStyleNames(ws = NULL)

#### Arguments

- `ws`:

  an optional workspace name

#### Returns

a vector of class `character`

------------------------------------------------------------------------

### Method `getStyle()`

Get a
[`GSStyle`](https://eblondel.github.io/geosapi/reference/GSLayer.md)
object given a style name.

#### Usage

    GSStyleManager$getStyle(style, ws = NULL)

#### Arguments

- `style`:

  style name

- `ws`:

  workspace name. Optional

#### Returns

object of class
[GSStyle](https://eblondel.github.io/geosapi/reference/GSLayer.md)

------------------------------------------------------------------------

### Method `createStyle()`

Creates a GeoServer style given a name.

#### Usage

    GSStyleManager$createStyle(file, sldBody = NULL, name, raw = FALSE, ws = NULL)

#### Arguments

- `file`:

  file

- `sldBody`:

  SLD body

- `name`:

  name

- `raw`:

  raw

- `ws`:

  workspace name

#### Returns

`TRUE` if the style has been successfully created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateStyle()`

Updates a GeoServer style given a name.

#### Usage

    GSStyleManager$updateStyle(file, sldBody = NULL, name, raw = FALSE, ws = NULL)

#### Arguments

- `file`:

  file

- `sldBody`:

  SLD body

- `name`:

  name

- `raw`:

  raw

- `ws`:

  workspace name

#### Returns

`TRUE` if the style has been successfully updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteStyle()`

Deletes a style given a name. By defaut, the option `recurse` is set to
FALSE, ie datastore layers are not removed. To remove all coverage store
layers, set this option to TRUE. The `purge` parameter is used to
customize the delete of files on disk (in case the underlying reader
implements a delete method).

#### Usage

    GSStyleManager$deleteStyle(name, recurse = FALSE, purge = FALSE, ws = NULL)

#### Arguments

- `name`:

  name

- `recurse`:

  recurse

- `purge`:

  purge

- `ws`:

  workspace name

#### Returns

`TRUE` if the style has been successfully deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getSLDVersion()`

Get SLD version

#### Usage

    GSStyleManager$getSLDVersion(sldBody)

#### Arguments

- `sldBody`:

  SLD body

------------------------------------------------------------------------

### Method `getSLDBody()`

Get SLD body

#### Usage

    GSStyleManager$getSLDBody(style, ws = NULL)

#### Arguments

- `style`:

  style name

- `ws`:

  workspace name

#### Returns

an object of class
[xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSStyleManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSStyleManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> <GSStyleManager>
#>   Inherits from: <GSManager>
#>   Public:
#>     ERROR: function (text) 
#>     INFO: function (text) 
#>     WARN: function (text) 
#>     clone: function (deep = FALSE) 
#>     connect: function () 
#>     createStyle: function (file, sldBody = NULL, name, raw = FALSE, ws = NULL) 
#>     deleteStyle: function (name, recurse = FALSE, purge = FALSE, ws = NULL) 
#>     getClassName: function () 
#>     getCoverageStoreManager: function () 
#>     getDataStoreManager: function () 
#>     getNamespaceManager: function () 
#>     getSLDBody: function (style, ws = NULL) 
#>     getSLDVersion: function (sldBody) 
#>     getServiceManager: function () 
#>     getStyle: function (style, ws = NULL) 
#>     getStyleManager: function () 
#>     getStyleNames: function (ws = NULL) 
#>     getStyles: function (ws = NULL) 
#>     getSystemStatus: function () 
#>     getUrl: function () 
#>     getWorkspaceManager: function () 
#>     initialize: function (url, user, pwd, logger = NULL, keyring_backend = "env") 
#>     logger: function (type, text) 
#>     loggerType: NULL
#>     monitor: function (file = NULL, append = FALSE, sleep = 1) 
#>     reload: function () 
#>     updateStyle: function (file, sldBody = NULL, name, raw = FALSE, ws = NULL) 
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
