# Geoserver REST API Workspace Manager

Geoserver REST API Workspace Manager

Geoserver REST API Workspace Manager

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for managing the workspaces of a GeoServer instance.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSManager`](https://eblondel.github.io/geosapi/reference/GSManager.md)
-\> `GSWorkspaceManager`

## Methods

### Public methods

- [`GSWorkspaceManager$getWorkspaces()`](#method-GSWorkspaceManager-getWorkspaces)

- [`GSWorkspaceManager$getWorkspaceNames()`](#method-GSWorkspaceManager-getWorkspaceNames)

- [`GSWorkspaceManager$getWorkspace()`](#method-GSWorkspaceManager-getWorkspace)

- [`GSWorkspaceManager$createWorkspace()`](#method-GSWorkspaceManager-createWorkspace)

- [`GSWorkspaceManager$updateWorkspace()`](#method-GSWorkspaceManager-updateWorkspace)

- [`GSWorkspaceManager$deleteWorkspace()`](#method-GSWorkspaceManager-deleteWorkspace)

- [`GSWorkspaceManager$getWorkspaceSettings()`](#method-GSWorkspaceManager-getWorkspaceSettings)

- [`GSWorkspaceManager$createWorkspaceSettings()`](#method-GSWorkspaceManager-createWorkspaceSettings)

- [`GSWorkspaceManager$updateWorkspaceSettings()`](#method-GSWorkspaceManager-updateWorkspaceSettings)

- [`GSWorkspaceManager$deleteWorkspaceSettings()`](#method-GSWorkspaceManager-deleteWorkspaceSettings)

- [`GSWorkspaceManager$clone()`](#method-GSWorkspaceManager-clone)

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

### Method `getWorkspaces()`

Get the list of available workspace. Returns an object of class `list`
containing items of class
[`GSWorkspace`](https://eblondel.github.io/geosapi/reference/GSWorkspace.md)

#### Usage

    GSWorkspaceManager$getWorkspaces()

#### Arguments

- `a`:

  list of
  [GSWorkspace](https://eblondel.github.io/geosapi/reference/GSWorkspace.md)

------------------------------------------------------------------------

### Method `getWorkspaceNames()`

Get the list of available workspace names. Returns an vector of class
`character`

#### Usage

    GSWorkspaceManager$getWorkspaceNames()

#### Returns

a list of workspace names

------------------------------------------------------------------------

### Method `getWorkspace()`

Get a
[`GSWorkspace`](https://eblondel.github.io/geosapi/reference/GSWorkspace.md)
object given a workspace name.

#### Usage

    GSWorkspaceManager$getWorkspace(ws)

#### Arguments

- `ws`:

  workspace name

#### Returns

an object of class
[GSWorkspace](https://eblondel.github.io/geosapi/reference/GSWorkspace.md)

------------------------------------------------------------------------

### Method `createWorkspace()`

Creates a GeoServer workspace given a name, and an optional URI. If the
URI is not specified, GeoServer will automatically create an associated
Namespace with the URI built from the workspace name. If the URI is
specified, the method invokes the method `createNamespace(ns, uri)` of
the
[`GSNamespaceManager`](https://eblondel.github.io/geosapi/reference/GSNamespaceManager.md).
Returns `TRUE` if the workspace has been successfully created, `FALSE`
otherwise

#### Usage

    GSWorkspaceManager$createWorkspace(name, uri)

#### Arguments

- `name`:

  name

- `uri`:

  uri

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateWorkspace()`

Updates a GeoServer workspace given a name, and an optional URI. If the
URI is not specified, GeoServer will automatically update the associated
Namespace with the URI built from the workspace name. If the URI is
specified, the method invokes the method `updateNamespace(ns, uri)` of
the
[`GSNamespaceManager`](https://eblondel.github.io/geosapi/reference/GSNamespaceManager.md).
Returns `TRUE` if the workspace has been successfully updated, `FALSE`
otherwise

#### Usage

    GSWorkspaceManager$updateWorkspace(name, uri)

#### Arguments

- `name`:

  name

- `uri`:

  uri

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteWorkspace()`

Deletes a GeoServer workspace given a name.

#### Usage

    GSWorkspaceManager$deleteWorkspace(name, recurse = FALSE)

#### Arguments

- `name`:

  name

- `recurse`:

  recurse

#### Returns

`TRUE` if the workspace has been successfully deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getWorkspaceSettings()`

Updates workspace settings

#### Usage

    GSWorkspaceManager$getWorkspaceSettings(ws)

#### Arguments

- `ws`:

  workspace name

#### Returns

an object of class
[GSWorkspaceSettings](https://eblondel.github.io/geosapi/reference/GSWorkspaceSettings.md)

------------------------------------------------------------------------

### Method `createWorkspaceSettings()`

Creates workspace settings

#### Usage

    GSWorkspaceManager$createWorkspaceSettings(ws, workspaceSettings)

#### Arguments

- `ws`:

  workspace name

- `workspaceSettings`:

  object of class
  [GSWorkspaceSettings](https://eblondel.github.io/geosapi/reference/GSWorkspaceSettings.md)

#### Returns

`TRUE` if created, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateWorkspaceSettings()`

Updates workspace settings

#### Usage

    GSWorkspaceManager$updateWorkspaceSettings(ws, workspaceSettings)

#### Arguments

- `ws`:

  workspace name

- `workspaceSettings`:

  object of class
  [GSWorkspaceSettings](https://eblondel.github.io/geosapi/reference/GSWorkspaceSettings.md)

#### Returns

`TRUE` if updated, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteWorkspaceSettings()`

Deletes workspace settings

#### Usage

    GSWorkspaceManager$deleteWorkspaceSettings(ws)

#### Arguments

- `ws`:

  workspace name

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSWorkspaceManager$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   GSWorkspaceManager$new("http://localhost:8080/geoserver", "admin", "geoserver")
#> <GSWorkspaceManager>
#>   Inherits from: <GSManager>
#>   Public:
#>     ERROR: function (text) 
#>     INFO: function (text) 
#>     WARN: function (text) 
#>     clone: function (deep = FALSE) 
#>     connect: function () 
#>     createWorkspace: function (name, uri) 
#>     createWorkspaceSettings: function (ws, workspaceSettings) 
#>     deleteWorkspace: function (name, recurse = FALSE) 
#>     deleteWorkspaceSettings: function (ws) 
#>     getClassName: function () 
#>     getCoverageStoreManager: function () 
#>     getDataStoreManager: function () 
#>     getNamespaceManager: function () 
#>     getServiceManager: function () 
#>     getStyleManager: function () 
#>     getSystemStatus: function () 
#>     getUrl: function () 
#>     getWorkspace: function (ws) 
#>     getWorkspaceManager: function () 
#>     getWorkspaceNames: function () 
#>     getWorkspaceSettings: function (ws) 
#>     getWorkspaces: function () 
#>     initialize: function (url, user, pwd, logger = NULL, keyring_backend = "env") 
#>     logger: function (type, text) 
#>     loggerType: NULL
#>     monitor: function (file = NULL, append = FALSE, sleep = 1) 
#>     reload: function () 
#>     updateWorkspace: function (name, uri) 
#>     updateWorkspaceSettings: function (ws, workspaceSettings) 
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
