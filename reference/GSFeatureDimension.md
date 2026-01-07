# A GeoServer dimension

This class models a GeoServer feature dimension.

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer feature dimension

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSDimension`](https://eblondel.github.io/geosapi/reference/GSDimension.md)
-\> `GSFeatureDimension`

## Public fields

- `attribute`:

  attribute

- `endAttribute`:

  end attribute

## Methods

### Public methods

- [`GSFeatureDimension$new()`](#method-GSFeatureDimension-new)

- [`GSFeatureDimension$decode()`](#method-GSFeatureDimension-decode)

- [`GSFeatureDimension$setAttribute()`](#method-GSFeatureDimension-setAttribute)

- [`GSFeatureDimension$setEndAttribute()`](#method-GSFeatureDimension-setEndAttribute)

- [`GSFeatureDimension$clone()`](#method-GSFeatureDimension-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSDimension$setEnabled()`](https://eblondel.github.io/geosapi/reference/GSDimension.html#method-setEnabled)
- [`geosapi::GSDimension$setPresentation()`](https://eblondel.github.io/geosapi/reference/GSDimension.html#method-setPresentation)
- [`geosapi::GSDimension$setUnit()`](https://eblondel.github.io/geosapi/reference/GSDimension.html#method-setUnit)
- [`geosapi::GSDimension$setUnitSymbol()`](https://eblondel.github.io/geosapi/reference/GSDimension.html#method-setUnitSymbol)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSFeatureDimension

#### Usage

    GSFeatureDimension$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSFeatureDimension$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setAttribute()`

Set attribute

#### Usage

    GSFeatureDimension$setAttribute(attribute)

#### Arguments

- `attribute`:

  attribute

------------------------------------------------------------------------

### Method `setEndAttribute()`

Set end attribute

#### Usage

    GSFeatureDimension$setEndAttribute(endAttribute)

#### Arguments

- `endAttribute`:

  end attribute

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSFeatureDimension$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  dim <- GSFeatureDimension$new()
```
