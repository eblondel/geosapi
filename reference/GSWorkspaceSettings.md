# Geoserver REST API Workspace Setting

Geoserver REST API Workspace Setting

Geoserver REST API Workspace Setting

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer workspace settings

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSWorkspaceSettings`

## Public fields

- `contact`:

  contact

- `charset`:

  charset

- `numDecimals`:

  number of decimal

- `onlineResource`:

  online resource

- `verbose`:

  verbose

- `verboseExceptions`:

  verbose exceptions

- `localWorkspaceIncludesPrefix`:

  local workspace includes prefix

## Methods

### Public methods

- [`GSWorkspaceSettings$new()`](#method-GSWorkspaceSettings-new)

- [`GSWorkspaceSettings$decode()`](#method-GSWorkspaceSettings-decode)

- [`GSWorkspaceSettings$setCharset()`](#method-GSWorkspaceSettings-setCharset)

- [`GSWorkspaceSettings$setNumDecimals()`](#method-GSWorkspaceSettings-setNumDecimals)

- [`GSWorkspaceSettings$setOnlineResource()`](#method-GSWorkspaceSettings-setOnlineResource)

- [`GSWorkspaceSettings$setVerbose()`](#method-GSWorkspaceSettings-setVerbose)

- [`GSWorkspaceSettings$setVerboseExceptions()`](#method-GSWorkspaceSettings-setVerboseExceptions)

- [`GSWorkspaceSettings$setLocalWorkspaceIncludesPrefix()`](#method-GSWorkspaceSettings-setLocalWorkspaceIncludesPrefix)

- [`GSWorkspaceSettings$clone()`](#method-GSWorkspaceSettings-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

This method is used to instantiate a `GSWorkspaceSettings`. This
settings object is required to activate a workspace configuration, using
the method `GSManager$createWorkspaceSettings`. Supported from GeoServer
2.12

#### Usage

    GSWorkspaceSettings$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSWorkspaceSettings$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setCharset()`

Set charset

#### Usage

    GSWorkspaceSettings$setCharset(charset)

#### Arguments

- `charset`:

  charset

------------------------------------------------------------------------

### Method `setNumDecimals()`

Set number of decimals

#### Usage

    GSWorkspaceSettings$setNumDecimals(numDecimals)

#### Arguments

- `numDecimals`:

  number of decimals

------------------------------------------------------------------------

### Method `setOnlineResource()`

Set online resource

#### Usage

    GSWorkspaceSettings$setOnlineResource(onlineResource)

#### Arguments

- `onlineResource`:

  online resource

------------------------------------------------------------------------

### Method `setVerbose()`

Set verbose

#### Usage

    GSWorkspaceSettings$setVerbose(verbose)

#### Arguments

- `verbose`:

  verbose

------------------------------------------------------------------------

### Method `setVerboseExceptions()`

Set verbose exceptions

#### Usage

    GSWorkspaceSettings$setVerboseExceptions(verboseExceptions)

#### Arguments

- `verboseExceptions`:

  verbose exceptions

------------------------------------------------------------------------

### Method `setLocalWorkspaceIncludesPrefix()`

Set local workspace includes prefix

#### Usage

    GSWorkspaceSettings$setLocalWorkspaceIncludesPrefix(includesPrefix)

#### Arguments

- `includesPrefix`:

  includes prefix

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSWorkspaceSettings$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  settings <- GSWorkspaceSettings$new()
  settings$setCharset("UTF-8")
  settings$setNumDecimals(5)
```
