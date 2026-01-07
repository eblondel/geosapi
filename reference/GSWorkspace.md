# Geoserver REST API Workspace

Geoserver REST API Workspace

Geoserver REST API Workspace

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer workspace

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSWorkspace`

## Public fields

- `name`:

  name

## Methods

### Public methods

- [`GSWorkspace$new()`](#method-GSWorkspace-new)

- [`GSWorkspace$decode()`](#method-GSWorkspace-decode)

- [`GSWorkspace$clone()`](#method-GSWorkspace-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

initializes a GSWorkspace

#### Usage

    GSWorkspace$new(xml = NULL, name)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `name`:

  name

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSWorkspace$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSWorkspace$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  GSWorkspace$new(name = "work")
#> <GSWorkspace>
#> ....|-- name: work
```
