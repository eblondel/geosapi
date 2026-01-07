# Geoserver REST API Namespace Manager

Geoserver REST API Namespace Manager

Geoserver REST API Namespace Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing the namespaces of a GeoServer instance.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSNamespaceManager`

## Methods

### Public methods

- [`GSNamespaceManager$getNamespaces()`](#method-GSNamespaceManager-getNamespaces)

- [`GSNamespaceManager$getNamespaceNames()`](#method-GSNamespaceManager-getNamespaceNames)

- [`GSNamespaceManager$getNamespace()`](#method-GSNamespaceManager-getNamespace)

- [`GSNamespaceManager$createNamespace()`](#method-GSNamespaceManager-createNamespace)

- [`GSNamespaceManager$updateNamespace()`](#method-GSNamespaceManager-updateNamespace)

- [`GSNamespaceManager$deleteNamespace()`](#method-GSNamespaceManager-deleteNamespace)

- [`GSNamespaceManager$clone()`](#method-GSNamespaceManager-clone)

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

### Method `getNamespaces()`

Get the list of available namespace. Re

#### Usage

    GSNamespaceManager$getNamespaces()

#### Returns

an object of class `list` containing items of class
[`GSNamespace`](https://eblondel.github.io/geosapi/reference/GSNamespace.md)

------------------------------------------------------------------------

### Method `getNamespaceNames()`

Get the list of available namespace names.

#### Usage

    GSNamespaceManager$getNamespaceNames()

#### Returns

a vector of class `character`

------------------------------------------------------------------------

### Method [`getNamespace()`](https://rdrr.io/r/base/ns-reflect.html)

Get a
[`GSNamespace`](https://eblondel.github.io/geosapi/reference/GSNamespace.md)
object given a namespace name.

#### Usage

    GSNamespaceManager$getNamespace(ns)

#### Arguments

- `ns`:

  namespace

#### Returns

an object of class
[GSNamespace](https://eblondel.github.io/geosapi/reference/GSNamespace.md)

------------------------------------------------------------------------

### Method `createNamespace()`

Creates a GeoServer namespace given a prefix, and an optional URI.

#### Usage

    GSNamespaceManager$createNamespace(prefix, uri)

#### Arguments

- `prefix`:

  prefix

- `uri`:

  uri

#### Returns

`TRUE` if the namespace has been successfully created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateNamespace()`

Updates a GeoServer namespace given a prefix, and an optional URI.

#### Usage

    GSNamespaceManager$updateNamespace(prefix, uri)

#### Arguments

- `prefix`:

  prefix

- `uri`:

  uri

#### Returns

`TRUE` if the namespace has been successfully updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteNamespace()`

Deletes a GeoServer namespace given a name.

#### Usage

    GSNamespaceManager$deleteNamespace(name, recurse = FALSE)

#### Arguments

- `name`:

  name

- `recurse`:

  recurse

#### Returns

`TRUE` if the namespace has been successfully deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSNamespaceManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSNamespaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
# }
```
