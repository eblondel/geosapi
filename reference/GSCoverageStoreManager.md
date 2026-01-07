# Geoserver REST API CoverageStore Manager

Geoserver REST API CoverageStore Manager

Geoserver REST API CoverageStore Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing GeoServer CoverageStores (i.e. stores of coverage
data)

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSCoverageStoreManager`

## Methods

### Public methods

- [`GSCoverageStoreManager$getCoverageStores()`](#method-GSCoverageStoreManager-getCoverageStores)

- [`GSCoverageStoreManager$getCoverageStoreNames()`](#method-GSCoverageStoreManager-getCoverageStoreNames)

- [`GSCoverageStoreManager$getCoverageStore()`](#method-GSCoverageStoreManager-getCoverageStore)

- [`GSCoverageStoreManager$createCoverageStore()`](#method-GSCoverageStoreManager-createCoverageStore)

- [`GSCoverageStoreManager$updateCoverageStore()`](#method-GSCoverageStoreManager-updateCoverageStore)

- [`GSCoverageStoreManager$deleteCoverageStore()`](#method-GSCoverageStoreManager-deleteCoverageStore)

- [`GSCoverageStoreManager$getCoverages()`](#method-GSCoverageStoreManager-getCoverages)

- [`GSCoverageStoreManager$getCoverageNames()`](#method-GSCoverageStoreManager-getCoverageNames)

- [`GSCoverageStoreManager$getCoverage()`](#method-GSCoverageStoreManager-getCoverage)

- [`GSCoverageStoreManager$createCoverage()`](#method-GSCoverageStoreManager-createCoverage)

- [`GSCoverageStoreManager$updateCoverage()`](#method-GSCoverageStoreManager-updateCoverage)

- [`GSCoverageStoreManager$deleteCoverage()`](#method-GSCoverageStoreManager-deleteCoverage)

- [`GSCoverageStoreManager$uploadCoverage()`](#method-GSCoverageStoreManager-uploadCoverage)

- [`GSCoverageStoreManager$uploadGeoTIFF()`](#method-GSCoverageStoreManager-uploadGeoTIFF)

- [`GSCoverageStoreManager$uploadWorldImage()`](#method-GSCoverageStoreManager-uploadWorldImage)

- [`GSCoverageStoreManager$uploadArcGrid()`](#method-GSCoverageStoreManager-uploadArcGrid)

- [`GSCoverageStoreManager$uploadImageMosaic()`](#method-GSCoverageStoreManager-uploadImageMosaic)

- [`GSCoverageStoreManager$clone()`](#method-GSCoverageStoreManager-clone)

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

### Method `getCoverageStores()`

Get the list of available coverage stores. Returns an object of class
`list` giving items of class
[`GSAbstractCoverageStore`](https://eblondel.github.io/geosapi/reference/GSAbstractCoverageStore.md)

#### Usage

    GSCoverageStoreManager$getCoverageStores(ws)

#### Arguments

- `ws`:

  workspace name

#### Returns

the list of coverage stores

------------------------------------------------------------------------

### Method `getCoverageStoreNames()`

Get the list of available coverage store names. Returns an vector of
class `character`

#### Usage

    GSCoverageStoreManager$getCoverageStoreNames(ws)

#### Arguments

- `ws`:

  workspace name

#### Returns

the list of coverage store names, as `character`

------------------------------------------------------------------------

### Method `getCoverageStore()`

Get an object of class
[`GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)
given a workspace and coverage store names.

#### Usage

    GSCoverageStoreManager$getCoverageStore(ws, cs)

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

#### Returns

the coverage store

------------------------------------------------------------------------

### Method `createCoverageStore()`

Creates a new coverage store given a workspace, coverage store name.
Abstract method used in below format-specific methods to create coverage
stores.

#### Usage

    GSCoverageStoreManager$createCoverageStore(ws, coverageStore)

#### Arguments

- `ws`:

  workspace name

- `coverageStore`:

  coverage store object

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateCoverageStore()`

Updates a coverage store given a workspace, coverage store name.
Abstract method used in below format-specific methods to create coverage
stores.

#### Usage

    GSCoverageStoreManager$updateCoverageStore(ws, coverageStore)

#### Arguments

- `ws`:

  workspace name

- `coverageStore`:

  coverage store object

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteCoverageStore()`

Deletes a coverage store given a workspace and an object of class
[`GSAbstractCoverageStore`](https://eblondel.github.io/geosapi/reference/GSAbstractCoverageStore.md).
By defaut, the option `recurse` is set to FALSE, ie datastore layers are
not removed. To remove all coverage store layers, set this option to
TRUE. The `purge` parameter is used to customize the delete of files on
disk (in case the underlying reader implements a delete method). It can
take one of the three values: none, metadata, all. For more details see
<https://docs.geoserver.org/stable/en/user/rest/api/coveragestores.html#purge>

#### Usage

    GSCoverageStoreManager$deleteCoverageStore(
      ws,
      cs,
      recurse = FALSE,
      purge = NULL
    )

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `recurse`:

  recurse

- `purge`:

  purge

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getCoverages()`

Get the list of available coverages for given workspace and coverage
store. Returns an object of class `list` giving items of class
[`GSCoverage`](https://eblondel.github.io/geosapi/reference/GSCoverage.md)

#### Usage

    GSCoverageStoreManager$getCoverages(ws, cs)

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

#### Returns

the list of
[GSCoverage](https://eblondel.github.io/geosapi/reference/GSCoverage.md)

------------------------------------------------------------------------

### Method `getCoverageNames()`

Get the list of available coverage names for given workspace and
coverage store. Returns an object of class `list` giving items of class
[`GSCoverage`](https://eblondel.github.io/geosapi/reference/GSCoverage.md)

#### Usage

    GSCoverageStoreManager$getCoverageNames(ws, cs)

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

#### Returns

the list of coverage names

------------------------------------------------------------------------

### Method `getCoverage()`

Get coverage

#### Usage

    GSCoverageStoreManager$getCoverage(ws, cs, cv)

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `cv`:

  coverage name

------------------------------------------------------------------------

### Method `createCoverage()`

Creates a new coverage given a workspace, coverage store names and an
object of class
[`GSCoverage`](https://eblondel.github.io/geosapi/reference/GSCoverage.md)

#### Usage

    GSCoverageStoreManager$createCoverage(ws, cs, coverage)

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `coverage`:

  object of class
  [GSCoverage](https://eblondel.github.io/geosapi/reference/GSCoverage.md)

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateCoverage()`

Updates a coverage given a workspace, coverage store names and an object
of class
[`GSCoverage`](https://eblondel.github.io/geosapi/reference/GSCoverage.md)

#### Usage

    GSCoverageStoreManager$updateCoverage(ws, cs, coverage)

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `coverage`:

  object of class
  [GSCoverage](https://eblondel.github.io/geosapi/reference/GSCoverage.md)

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteCoverage()`

Deletes a coverage given a workspace, coverage store names, and an
object of class
[`GSCoverage`](https://eblondel.github.io/geosapi/reference/GSCoverage.md).
By defaut, the option `recurse` is set to FALSE, ie coverage layers are
not removed.

#### Usage

    GSCoverageStoreManager$deleteCoverage(ws, cs, cv, recurse = FALSE)

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `cv`:

  coverage name

- `recurse`:

  recurse

------------------------------------------------------------------------

### Method `uploadCoverage()`

Abstract method to upload a coverage file targeting a workspace (`ws`)
and datastore (`cs`). The `extension` corresponds to the format/type of
coverage to be uploaded (among values 'geotiff', 'worldimage',
'arcgrid', or 'imagemosaic'). The `endpoint` takes a value among
`"file"` (default), `"url"` or `"external"`. The `filename` is the name
of the coverage file to upload and set for the newly created datastore.
The `configure` parameter can take a value among values `"none"`
(indicates to configure only the datastore but no layer configuration)
or `"first"` (configure both datastore and layer). The `update` defines
the strategy for the upload: `"append"` (default value) for the first
upload, `"overwrite"` in case the file should be overwriten.

#### Usage

    GSCoverageStoreManager$uploadCoverage(
      ws,
      cs,
      endpoint = "file",
      extension,
      filename,
      configure = "first",
      update = "append",
      contentType
    )

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `endpoint`:

  endpoint. Default is "file"

- `extension`:

  extension

- `filename`:

  filename

- `configure`:

  configure. Default is "first"

- `update`:

  update. Default is "append"

- `contentType`:

  content type

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadGeoTIFF()`

Uploads a GeoTIFF file targeting a workspace (`ws`) and datastore
(`cs`). The `endpoint` takes a value among `"file"` (default), `"url"`
or `"external"`. The `filename` is the name of the GeoTIFF file to
upload and set for the newly created datastore. The `configure`
parameter can take a value among values `"none"` (indicates to configure
only the datastore but no layer configuration) or `"first"` (configure
both datastore and layer). The `update` defines the strategy for the
upload: `"append"` (default value) for the first upload, `"overwrite"`
in case the file should be overwriten.

#### Usage

    GSCoverageStoreManager$uploadGeoTIFF(
      ws,
      cs,
      endpoint = "file",
      filename,
      configure = "first",
      update = "append"
    )

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `endpoint`:

  endpoint. Default is "file"

- `filename`:

  filename

- `configure`:

  configure. Default is "first"

- `update`:

  update. Default is "append"

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadWorldImage()`

Uploads a WorldImage file targeting a workspace (`ws`) and datastore
(`cs`). The `endpoint` takes a value among `"file"` (default), `"url"`
or `"external"`. The `filename` is the name of the zipped file to upload
and set for the newly created datastore. It is assumed the zip archive
contains the .prj file to set the SRS. The `configure` parameter can
take a value among values `"none"` (indicates to configure only the
datastore but no layer configuration) or `"first"` (configure both
datastore and layer). The `update` defines the strategy for the upload:
`"append"` (default value) for the first upload, `"overwrite"` in case
the file should be overwriten.

#### Usage

    GSCoverageStoreManager$uploadWorldImage(
      ws,
      cs,
      endpoint = "file",
      filename,
      configure = "first",
      update = "append"
    )

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `endpoint`:

  endpoint. Default is "file"

- `filename`:

  filename

- `configure`:

  configure. Default is "first"

- `update`:

  update. Default is "append"

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadArcGrid()`

Uploads an ArcGrid file targeting a workspace (`ws`) and datastore
(`cs`). The `endpoint` takes a value among `"file"` (default), `"url"`
or `"external"`. The `filename` is the name of the ArcGrid file to
upload and set for the newly created datastore. The `configure`
parameter can take a value among values `"none"` (indicates to configure
only the datastore but no layer configuration) or `"first"` (configure
both datastore and layer). The `update` defines the strategy for the
upload: `"append"` (default value) for the first upload, `"overwrite"`
in case the file should be overwriten.

#### Usage

    GSCoverageStoreManager$uploadArcGrid(
      ws,
      cs,
      endpoint = "file",
      filename,
      configure = "first",
      update = "append"
    )

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `endpoint`:

  endpoint. Default is "file"

- `filename`:

  filename

- `configure`:

  configure. Default is "first"

- `update`:

  update. Default is "append"

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `uploadImageMosaic()`

Uploads an ImageMosaic file targeting a workspace (`ws`) and datastore
(`cs`). The `endpoint` takes a value among `"file"` (default), `"url"`
or `"external"`. The `filename` is the name of the ImageMosaic file to
upload and set for the newly created datastore. The `configure`
parameter can take a value among values `"none"` (indicates to configure
only the datastore but no layer configuration) or `"first"` (configure
both datastore and layer). The `update` defines the strategy for the
upload: `"append"` (default value) for the first upload, `"overwrite"`
in case the file should be overwriten.

#### Usage

    GSCoverageStoreManager$uploadImageMosaic(
      ws,
      cs,
      endpoint = "file",
      filename,
      configure = "first",
      update = "append"
    )

#### Arguments

- `ws`:

  workspace name

- `cs`:

  coverage store name

- `endpoint`:

  endpoint. Default is "file"

- `filename`:

  filename

- `configure`:

  configure. Default is "first"

- `update`:

  update. Default is "append"

#### Returns

`TRUE` if uploaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSCoverageStoreManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSCoverageStoreManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
 # }
```
