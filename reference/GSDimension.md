# A GeoServer dimension

This class models a GeoServer resource dimension.

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer dimension

## Details

Geoserver REST API Dimension

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSDimension`

## Public fields

- `enabled`:

  true/false

- `presentation`:

  dimension presentation

- `resolution`:

  dimension resolution

- `units`:

  dimension units

- `unitSymbol`:

  dimension unitsSymbol

## Methods

### Public methods

- [`GSDimension$new()`](#method-GSDimension-new)

- [`GSDimension$decode()`](#method-GSDimension-decode)

- [`GSDimension$setEnabled()`](#method-GSDimension-setEnabled)

- [`GSDimension$setPresentation()`](#method-GSDimension-setPresentation)

- [`GSDimension$setUnit()`](#method-GSDimension-setUnit)

- [`GSDimension$setUnitSymbol()`](#method-GSDimension-setUnitSymbol)

- [`GSDimension$clone()`](#method-GSDimension-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSDimension

#### Usage

    GSDimension$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSDimension$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setEnabled()`

Set enabled

#### Usage

    GSDimension$setEnabled(enabled)

#### Arguments

- `enabled`:

  enabled

------------------------------------------------------------------------

### Method `setPresentation()`

Set presentation

#### Usage

    GSDimension$setPresentation(presentation, interval = NULL)

#### Arguments

- `presentation`:

  presentation. Possible values: "LIST", "CONTINUOUS_INTERVAL",
  "DISCRETE_INTERVAL"

- `interval`:

  interval

------------------------------------------------------------------------

### Method `setUnit()`

Set unit

#### Usage

    GSDimension$setUnit(unit)

#### Arguments

- `unit`:

  unit

------------------------------------------------------------------------

### Method `setUnitSymbol()`

Set unit symbol

#### Usage

    GSDimension$setUnitSymbol(unitSymbol)

#### Arguments

- `unitSymbol`:

  unit symbol

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSDimension$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  dim <- GSDimension$new()
```
