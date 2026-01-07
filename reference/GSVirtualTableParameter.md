# Geoserver REST API GSVirtualTableParameter

Geoserver REST API GSVirtualTableParameter

Geoserver REST API GSVirtualTableParameter

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer virtual table parameter

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSVirtualTableParameter`

## Public fields

- `name`:

  parameter name

- `defaultValue`:

  parameter default value

- `regexpValidator`:

  parameter regexp validator

## Methods

### Public methods

- [`GSVirtualTableParameter$new()`](#method-GSVirtualTableParameter-new)

- [`GSVirtualTableParameter$decode()`](#method-GSVirtualTableParameter-decode)

- [`GSVirtualTableParameter$clone()`](#method-GSVirtualTableParameter-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSVirtualTableParameter

#### Usage

    GSVirtualTableParameter$new(xml = NULL, name, defaultValue, regexpValidator)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `name`:

  name

- `defaultValue`:

  default value

- `regexpValidator`:

  regexp validator

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSVirtualTableParameter$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSVirtualTableParameter$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
GSVirtualTableParameter$new(name = "fieldname", defaultValue = "default_value",
                            regexpValidator = "someregexp")
#> <GSVirtualTableParameter>
#> ....|-- name: fieldname
#> ....|-- defaultValue: default_value
#> ....|-- regexpValidator: someregexp
```
