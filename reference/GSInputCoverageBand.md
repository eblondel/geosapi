# Geoserver REST API GSInputCoverageBand

Geoserver REST API GSInputCoverageBand

Geoserver REST API GSInputCoverageBand

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer input coverage band

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSInputCoverageBand`

## Public fields

- `coverageName`:

  coverage name

- `band`:

  band

## Methods

### Public methods

- [`GSInputCoverageBand$new()`](#method-GSInputCoverageBand-new)

- [`GSInputCoverageBand$decode()`](#method-GSInputCoverageBand-decode)

- [`GSInputCoverageBand$setCoverageName()`](#method-GSInputCoverageBand-setCoverageName)

- [`GSInputCoverageBand$setBand()`](#method-GSInputCoverageBand-setBand)

- [`GSInputCoverageBand$clone()`](#method-GSInputCoverageBand-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSInputCoverageBand

#### Usage

    GSInputCoverageBand$new(xml = NULL, coverageName = NULL, band = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `coverageName`:

  coverage name

- `band`:

  band name

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSInputCoverageBand$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setCoverageName()`

Set coverage name

#### Usage

    GSInputCoverageBand$setCoverageName(coverageName)

#### Arguments

- `coverageName`:

  coverage name

------------------------------------------------------------------------

### Method `setBand()`

Set band

#### Usage

    GSInputCoverageBand$setBand(band)

#### Arguments

- `band`:

  band

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSInputCoverageBand$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  GSInputCoverageBand$new()
#> <GSInputCoverageBand>
```
