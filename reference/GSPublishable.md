# A GeoServer layer group publishable

This class models a GeoServer layer. This class is to be used internally
by geosapi for configuring layers or layer groups within an object of
class `GSLayerGroup`

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer layer group publishable

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSPublishable`

## Public fields

- `full`:

  full

- `name`:

  name

- `attr_type`:

  type of attribute

## Methods

### Public methods

- [`GSPublishable$new()`](#method-GSPublishable-new)

- [`GSPublishable$decode()`](#method-GSPublishable-decode)

- [`GSPublishable$setName()`](#method-GSPublishable-setName)

- [`GSPublishable$setType()`](#method-GSPublishable-setType)

- [`GSPublishable$clone()`](#method-GSPublishable-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes a GSPublishable

#### Usage

    GSPublishable$new(xml = NULL, name, type)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `name`:

  name

- `type`:

  type

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSPublishable$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setName()`

set name

#### Usage

    GSPublishable$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setType()`

Set type

#### Usage

    GSPublishable$setType(type)

#### Arguments

- `type`:

  type

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSPublishable$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  publishable <- GSPublishable$new(name = "name", type = "layer")
```
