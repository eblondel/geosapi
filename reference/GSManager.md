# Geoserver REST API Manager

Geoserver REST API Manager

Geoserver REST API Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for communication with the REST API of a GeoServer instance.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Public fields

- `verbose.info`:

  if geosapi logs have to be printed

- `verbose.debug`:

  if curl logs have to be printed

- `loggerType`:

  the type of logger

- `url`:

  the Base url of GeoServer

- `version`:

  the version of Geoserver. Handled as `GSVersion` object

## Methods

### Public methods

- [`GSManager$logger()`](#method-GSManager-logger)

- [`GSManager$INFO()`](#method-GSManager-INFO)

- [`GSManager$WARN()`](#method-GSManager-WARN)

- [`GSManager$ERROR()`](#method-GSManager-ERROR)

- [`GSManager$new()`](#method-GSManager-new)

- [`GSManager$getUrl()`](#method-GSManager-getUrl)

- [`GSManager$connect()`](#method-GSManager-connect)

- [`GSManager$reload()`](#method-GSManager-reload)

- [`GSManager$getSystemStatus()`](#method-GSManager-getSystemStatus)

- [`GSManager$monitor()`](#method-GSManager-monitor)

- [`GSManager$getClassName()`](#method-GSManager-getClassName)

- [`GSManager$getWorkspaceManager()`](#method-GSManager-getWorkspaceManager)

- [`GSManager$getNamespaceManager()`](#method-GSManager-getNamespaceManager)

- [`GSManager$getDataStoreManager()`](#method-GSManager-getDataStoreManager)

- [`GSManager$getCoverageStoreManager()`](#method-GSManager-getCoverageStoreManager)

- [`GSManager$getServiceManager()`](#method-GSManager-getServiceManager)

- [`GSManager$getStyleManager()`](#method-GSManager-getStyleManager)

- [`GSManager$clone()`](#method-GSManager-clone)

------------------------------------------------------------------------

### Method `logger()`

Prints a log message

#### Usage

    GSManager$logger(type, text)

#### Arguments

- `type`:

  type of log, "INFO", "WARN", "ERROR"

- `text`:

  text

------------------------------------------------------------------------

### Method `INFO()`

Prints an INFO log message

#### Usage

    GSManager$INFO(text)

#### Arguments

- `text`:

  text

------------------------------------------------------------------------

### Method `WARN()`

Prints an WARN log message

#### Usage

    GSManager$WARN(text)

#### Arguments

- `text`:

  text

------------------------------------------------------------------------

### Method `ERROR()`

Prints an ERROR log message

#### Usage

    GSManager$ERROR(text)

#### Arguments

- `text`:

  text

------------------------------------------------------------------------

### Method `new()`

This method is used to instantiate a GSManager with the `url` of the
GeoServer and credentials to authenticate (`user`/`pwd`).

By default, the `logger` argument will be set to `NULL` (no logger).
This argument accepts two possible values: `INFO`: to print only geosapi
logs, `DEBUG`: to print geosapi and CURL logs.

The `keyring_backend` can be set to use a different backend for storing
the Geoserver user password with keyring (Default value is 'env').

#### Usage

    GSManager$new(url, user, pwd, logger = NULL, keyring_backend = "env")

#### Arguments

- `url`:

  url

- `user`:

  user

- `pwd`:

  pwd

- `logger`:

  logger

- `keyring_backend`:

  keyring backend. Default is 'env'

------------------------------------------------------------------------

### Method `getUrl()`

Get URL

#### Usage

    GSManager$getUrl()

#### Returns

the Geoserver URL

------------------------------------------------------------------------

### Method `connect()`

Connects to geoServer

#### Usage

    GSManager$connect()

#### Returns

`TRUE` if connected, raises an error otherwise

------------------------------------------------------------------------

### Method `reload()`

Reloads the GeoServer catalog

#### Usage

    GSManager$reload()

#### Returns

`TRUE` if reloaded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getSystemStatus()`

Get system status

#### Usage

    GSManager$getSystemStatus()

#### Returns

an object of class `data.frame` given the date time and metrics value

------------------------------------------------------------------------

### Method `monitor()`

Monitors the Geoserver by launching a small shiny monitoring application

#### Usage

    GSManager$monitor(file = NULL, append = FALSE, sleep = 1)

#### Arguments

- `file`:

  file where to store monitoring results

- `append`:

  whether to append results to existing files

- `sleep`:

  sleeping interval to trigger a system status call

------------------------------------------------------------------------

### Method `getClassName()`

Get class name

#### Usage

    GSManager$getClassName()

#### Returns

the self class name, as `character`

------------------------------------------------------------------------

### Method `getWorkspaceManager()`

Get Workspace manager

#### Usage

    GSManager$getWorkspaceManager()

#### Returns

an object of class
[GSWorkspaceManager](https://eblondel.github.io/geosapi/reference/GSWorkspaceManager.md)

------------------------------------------------------------------------

### Method `getNamespaceManager()`

Get Namespace manager

#### Usage

    GSManager$getNamespaceManager()

#### Returns

an object of class
[GSNamespaceManager](https://eblondel.github.io/geosapi/reference/GSNamespaceManager.md)

------------------------------------------------------------------------

### Method `getDataStoreManager()`

Get Datastore manager

#### Usage

    GSManager$getDataStoreManager()

#### Returns

an object of class
[GSDataStoreManager](https://eblondel.github.io/geosapi/reference/GSDataStoreManager.md)

------------------------------------------------------------------------

### Method `getCoverageStoreManager()`

Get Coverage store manager

#### Usage

    GSManager$getCoverageStoreManager()

#### Returns

an object of class
[GSCoverageStoreManager](https://eblondel.github.io/geosapi/reference/GSCoverageStoreManager.md)

------------------------------------------------------------------------

### Method `getServiceManager()`

Get service manager

#### Usage

    GSManager$getServiceManager()

#### Returns

an object of class
[GSServiceManager](https://eblondel.github.io/geosapi/reference/GSServiceManager.md)

------------------------------------------------------------------------

### Method `getStyleManager()`

Get style manager

#### Usage

    GSManager$getStyleManager()

#### Returns

an object of class
[GSStyleManager](https://eblondel.github.io/geosapi/reference/GSStyleManager.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
# }
```
