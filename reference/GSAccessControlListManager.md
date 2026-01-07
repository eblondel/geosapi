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
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
 # }
```
