# Geoserver REST API GSVirtualTableGeometry

Geoserver REST API GSVirtualTableGeometry

Geoserver REST API GSVirtualTableGeometry

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer virtual table geometry

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSVirtualTableGeometry`

## Public fields

- `name`:

  geometry name

- `type`:

  geometry type

- `srid`:

  geometry SRID

## Methods

### Public methods

- [`GSVirtualTableGeometry$new()`](#method-GSVirtualTableGeometry-new)

- [`GSVirtualTableGeometry$decode()`](#method-GSVirtualTableGeometry-decode)

- [`GSVirtualTableGeometry$clone()`](#method-GSVirtualTableGeometry-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSVirtualTableGeometry

#### Usage

    GSVirtualTableGeometry$new(xml = NULL, name, type, srid)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `name`:

  name

- `type`:

  type

- `srid`:

  srid

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSVirtualTableGeometry$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSVirtualTableGeometry$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
GSVirtualTableGeometry$new(name = "work", type = "MultiPolygon", srid = 4326)
#> <GSVirtualTableGeometry>
#> ....|-- name: work
#> ....|-- type: MultiPolygon
#> ....|-- srid: 4326
```
