# Geoserver REST API Namespace

Geoserver REST API Namespace

Geoserver REST API Namespace

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer namespace

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSNamespace`

## Public fields

- `name`:

  namespace name

- `prefix`:

  namespace prefix

- `uri`:

  namespace URI

- `full`:

  completeness of the namespace description

## Methods

### Public methods

- [`GSNamespace$new()`](#method-GSNamespace-new)

- [`GSNamespace$decode()`](#method-GSNamespace-decode)

- [`GSNamespace$clone()`](#method-GSNamespace-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSNamespace

#### Usage

    GSNamespace$new(xml = NULL, prefix, uri)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `prefix`:

  prefix

- `uri`:

  uri

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSNamespace$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSNamespace$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
GSNamespace$new(prefix = "my_ns", uri = "http://my_ns")
#> <GSNamespace>
#> ....|-- name: my_ns
#> ....|-- prefix: my_ns
#> ....|-- uri: http://my_ns
```
