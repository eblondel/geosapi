# Geoserver REST API DataStore Manager

Geoserver REST API DataStore Manager

Geoserver REST API DataStore Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing GeoServer DataStores (i.e. stores of vector data)

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSDataStoreManager`

## Methods

### Public methods

- [`GSDataStoreManager$getDataStores()`](#method-GSDataStoreManager-getDataStores)

- [`GSDataStoreManager$getDataStoreNames()`](#method-GSDataStoreManager-getDataStoreNames)

- [`GSDataStoreManager$getDataStore()`](#method-GSDataStoreManager-getDataStore)

- [`GSDataStoreManager$createDataStore()`](#method-GSDataStoreManager-createDataStore)

- [`GSDataStoreManager$updateDataStore()`](#method-GSDataStoreManager-updateDataStore)

- [`GSDataStoreManager$deleteDataStore()`](#method-GSDataStoreManager-deleteDataStore)

- [`GSDataStoreManager$getFeatureTypes()`](#method-GSDataStoreManager-getFeatureTypes)

- [`GSDataStoreManager$getFeatureTypeNames()`](#method-GSDataStoreManager-getFeatureTypeNames)

- [`GSDataStoreManager$getFeatureType()`](#method-GSDataStoreManager-getFeatureType)

- [`GSDataStoreManager$createFeatureType()`](#method-GSDataStoreManager-createFeatureType)

- [`GSDataStoreManager$updateFeatureType()`](#method-GSDataStoreManager-updateFeatureType)

- [`GSDataStoreManager$deleteFeatureType()`](#method-GSDataStoreManager-deleteFeatureType)

- [`GSDataStoreManager$publishLayer()`](#method-GSDataStoreManager-publishLayer)

- [`GSDataStoreManager$unpublishLayer()`](#method-GSDataStoreManager-unpublishLayer)

- [`GSDataStoreManager$uploadData()`](#method-GSDataStoreManager-uploadData)

- [`GSDataStoreManager$uploadShapefile()`](#method-GSDataStoreManager-uploadShapefile)

- [`GSDataStoreManager$uploadProperties()`](#method-GSDataStoreManager-uploadProperties)

- [`GSDataStoreManager$uploadH2()`](#method-GSDataStoreManager-uploadH2)

- [`GSDataStoreManager$uploadSpatialite()`](#method-GSDataStoreManager-uploadSpatialite)

- [`GSDataStoreManager$uploadAppschema()`](#method-GSDataStoreManager-uploadAppschema)

- [`GSDataStoreManager$uploadGeoPackage()`](#method-GSDataStoreManager-uploadGeoPackage)

- [`GSDataStoreManager$clone()`](#method-GSDataStoreManager-clone)

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

### Method `getDataStores()`

Get the list of available dataStores.

#### Usage

    GSDataStoreManager$getDataStores(ws)

#### Arguments

- `ws`:

  workspace name

#### Returns

an object of class `list` giving items of class
[`GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)

------------------------------------------------------------------------

### Method `getDataStoreNames()`

Get the list of available dataStore names.

#### Usage

    GSDataStoreManager$getDataStoreNames(ws)

#### Arguments

- `ws`:

  workspace name

#### Returns

a vector of class `character`

------------------------------------------------------------------------

### Method `getDataStore()`

Get an object of class
[`GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)
given a workspace and datastore names.

#### Usage

    GSDataStoreManager$getDataStore(ws, ds)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

#### Returns

the datastore

------------------------------------------------------------------------

### Method `createDataStore()`

Creates a datastore given a workspace and an object of class
[`GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md).

#### Usage

    GSDataStoreManager$createDataStore(ws, dataStore)

#### Arguments

- `ws`:

  workspace name

- `dataStore`:

  datastore object of class
  [GSAbstractDataStore](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateDataStore()`

Updates a datastore given a workspace and an object of class
[`GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md).

#### Usage

    GSDataStoreManager$updateDataStore(ws, dataStore)

#### Arguments

- `ws`:

  workspace name

- `dataStore`:

  datastore object of class
  [GSAbstractDataStore](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteDataStore()`

Deletes a datastore given workspace and datastore names. By defaut, the
option `recurse` is set to FALSE, ie datastore layers are not removed.
To remove all datastore layers, set this option to TRUE.

#### Usage

    GSDataStoreManager$deleteDataStore(ws, ds, recurse = FALSE)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `recurse`:

  recurse

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getFeatureTypes()`

Get the list of available feature types for given workspace and
datastore.

#### Usage

    GSDataStoreManager$getFeatureTypes(ws, ds, list = "configured")

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `list`:

  list type value, among "configured", "available",
  "available_with_geom", "all"

#### Returns

an object of class `list` giving items of class
[`GSFeatureType`](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)

------------------------------------------------------------------------

### Method `getFeatureTypeNames()`

Get the list of available feature type names for given workspace and
datastore.

#### Usage

    GSDataStoreManager$getFeatureTypeNames(ws, ds)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

#### Returns

a vector of class`character`

------------------------------------------------------------------------

### Method `getFeatureType()`

Get an object of class
[`GSFeatureType`](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)
given a workspace, datastore and feature type names.

#### Usage

    GSDataStoreManager$getFeatureType(ws, ds, ft)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `ft`:

  feature type name

#### Returns

an object of class
[GSFeatureType](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)

------------------------------------------------------------------------

### Method `createFeatureType()`

Creates a new featureType given a workspace, datastore names and an
object of class
[`GSFeatureType`](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)

#### Usage

    GSDataStoreManager$createFeatureType(ws, ds, featureType)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `featureType`:

  feature type

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateFeatureType()`

Updates a featureType given a workspace, datastore names and an object
of class
[`GSFeatureType`](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)

#### Usage

    GSDataStoreManager$updateFeatureType(ws, ds, featureType)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `featureType`:

  feature type

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteFeatureType()`

Deletes a featureType given a workspace, datastore names, and an object
of class
[`GSFeatureType`](https://eblondel.github.io/geosapi/reference/GSFeatureType.md).
By defaut, the option `recurse` is set to FALSE, ie datastore layers are
not removed.

#### Usage

    GSDataStoreManager$deleteFeatureType(ws, ds, ft, recurse = FALSE)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `ft`:

  feature type name

- `recurse`:

  recurse

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `publishLayer()`

Publish a feature type/layer pair given a workspace and datastore. The
name 'layer' here encompasses both
[GSFeatureType](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)
and [GSLayer](https://eblondel.github.io/geosapi/reference/GSLayer.md)
resources.

#### Usage

    GSDataStoreManager$publishLayer(ws, ds, featureType, layer)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `featureType`:

  object of class
  [GSFeatureType](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)

- `layer`:

  object of class
  [GSLayer](https://eblondel.github.io/geosapi/reference/GSLayer.md)

#### Returns

`TRUE` if published, `FALSE` otherwise

------------------------------------------------------------------------

### Method `unpublishLayer()`

Unpublish a feature type/layer pair given a workspace and datastore. The
name 'layer' here encompasses both
[GSFeatureType](https://eblondel.github.io/geosapi/reference/GSFeatureType.md)
and [GSLayer](https://eblondel.github.io/geosapi/reference/GSLayer.md)
resources.

#### Usage

    GSDataStoreManager$unpublishLayer(ws, ds, lyr)

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `lyr`:

  layer name

#### Returns

`TRUE` if published, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadData()`

Uploads features data. The `extension` corresponds to the format/type of
features to be uploaded among "shp", "spatialite", "h2", "gpkg". The
`endpoint` takes a value among `"file"` (default), `"url"` or
`"external"`. The `filename` is the name of the coverage file to upload
and set for the newly created datastore. The `configure` parameter can
take a value among values `"none"` (indicates to configure only the
datastore but no layer configuration) or `"first"` (configure both
datastore and layer). The `update` defines the strategy for the upload:
`"append"` (default value) for the first upload, `"overwrite"` in case
the file should be overwriten.

#### Usage

    GSDataStoreManager$uploadData(
      ws,
      ds,
      endpoint = "file",
      extension,
      configure = "first",
      update = "append",
      filename,
      charset,
      contentType
    )

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `endpoint`:

  endpoint

- `extension`:

  extension

- `configure`:

  configure strategy among values: "first" or "none"

- `update`:

  update strategy, among values: "append", "overwrite"

- `filename`:

  file name of the resource to upload

- `charset`:

  charset

- `contentType`:

  content type

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadShapefile()`

Uploads zipped shapefile. The `endpoint` takes a value among `"file"`
(default), `"url"` or `"external"`. The `filename` is the name of the
coverage file to upload and set for the newly created datastore. The
`configure` parameter can take a value among values `"none"` (indicates
to configure only the datastore but no layer configuration) or `"first"`
(configure both datastore and layer). The `update` defines the strategy
for the upload: `"append"` (default value) for the first upload,
`"overwrite"` in case the file should be overwriten.

#### Usage

    GSDataStoreManager$uploadShapefile(
      ws,
      ds,
      endpoint = "file",
      configure = "first",
      update = "append",
      filename,
      charset = "UTF-8"
    )

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `endpoint`:

  endpoint

- `configure`:

  configure strategy among values: "first" or "none"

- `update`:

  update strategy, among values: "append", "overwrite"

- `filename`:

  file name of the resource to upload

- `charset`:

  charset

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadProperties()`

Uploads properties. The `endpoint` takes a value among `"file"`
(default), `"url"` or `"external"`. The `filename` is the name of the
coverage file to upload and set for the newly created datastore. The
`configure` parameter can take a value among values `"none"` (indicates
to configure only the datastore but no layer configuration) or `"first"`
(configure both datastore and layer). The `update` defines the strategy
for the upload: `"append"` (default value) for the first upload,
`"overwrite"` in case the file should be overwriten.

#### Usage

    GSDataStoreManager$uploadProperties(
      ws,
      ds,
      endpoint = "file",
      configure = "first",
      update = "append",
      filename,
      charset = "UTF-8"
    )

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `endpoint`:

  endpoint

- `configure`:

  configure strategy among values: "first" or "none"

- `update`:

  update strategy, among values: "append", "overwrite"

- `filename`:

  file name of the resource to upload

- `charset`:

  charset

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadH2()`

Uploads H2 database. The `endpoint` takes a value among `"file"`
(default), `"url"` or `"external"`. The `filename` is the name of the
coverage file to upload and set for the newly created datastore. The
`configure` parameter can take a value among values `"none"` (indicates
to configure only the datastore but no layer configuration) or `"first"`
(configure both datastore and layer). The `update` defines the strategy
for the upload: `"append"` (default value) for the first upload,
`"overwrite"` in case the file should be overwriten.

#### Usage

    GSDataStoreManager$uploadH2(
      ws,
      ds,
      endpoint = "file",
      configure = "first",
      update = "append",
      filename,
      charset = "UTF-8"
    )

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `endpoint`:

  endpoint

- `configure`:

  configure strategy among values: "first" or "none"

- `update`:

  update strategy, among values: "append", "overwrite"

- `filename`:

  file name of the resource to upload

- `charset`:

  charset

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadSpatialite()`

Uploads spatialite file. The `endpoint` takes a value among `"file"`
(default), `"url"` or `"external"`. The `filename` is the name of the
coverage file to upload and set for the newly created datastore. The
`configure` parameter can take a value among values `"none"` (indicates
to configure only the datastore but no layer configuration) or `"first"`
(configure both datastore and layer). The `update` defines the strategy
for the upload: `"append"` (default value) for the first upload,
`"overwrite"` in case the file should be overwriten.

#### Usage

    GSDataStoreManager$uploadSpatialite(
      ws,
      ds,
      endpoint = "file",
      configure = "first",
      update = "append",
      filename,
      charset = "UTF-8"
    )

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `endpoint`:

  endpoint

- `configure`:

  configure strategy among values: "first" or "none"

- `update`:

  update strategy, among values: "append", "overwrite"

- `filename`:

  file name of the resource to upload

- `charset`:

  charset

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadAppschema()`

Uploads App schema. The `endpoint` takes a value among `"file"`
(default), `"url"` or `"external"`. The `filename` is the name of the
coverage file to upload and set for the newly created datastore. The
`configure` parameter can take a value among values `"none"` (indicates
to configure only the datastore but no layer configuration) or `"first"`
(configure both datastore and layer). The `update` defines the strategy
for the upload: `"append"` (default value) for the first upload,
`"overwrite"` in case the file should be overwriten.

#### Usage

    GSDataStoreManager$uploadAppschema(
      ws,
      ds,
      endpoint = "file",
      configure = "first",
      update = "append",
      filename,
      charset = "UTF-8"
    )

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `endpoint`:

  endpoint

- `configure`:

  configure strategy among values: "first" or "none"

- `update`:

  update strategy, among values: "append", "overwrite"

- `filename`:

  file name of the resource to upload

- `charset`:

  charset

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadGeoPackage()`

Uploads GeoPackage. The `endpoint` takes a value among `"file"`
(default), `"url"` or `"external"`. The `filename` is the name of the
coverage file to upload and set for the newly created datastore. The
`configure` parameter can take a value among values `"none"` (indicates
to configure only the datastore but no layer configuration) or `"first"`
(configure both datastore and layer). The `update` defines the strategy
for the upload: `"append"` (default value) for the first upload,
`"overwrite"` in case the file should be overwriten.

#### Usage

    GSDataStoreManager$uploadGeoPackage(
      ws,
      ds,
      endpoint = "file",
      configure = "first",
      update = "append",
      filename,
      charset = "UTF-8"
    )

#### Arguments

- `ws`:

  workspace name

- `ds`:

  datastore name

- `endpoint`:

  endpoint

- `configure`:

  configure strategy among values: "first" or "none"

- `update`:

  update strategy, among values: "append", "overwrite"

- `filename`:

  file name of the resource to upload

- `charset`:

  charset

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSDataStoreManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSDataStoreManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
 # }
```
