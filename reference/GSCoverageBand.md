# Geoserver REST API GSCoverageBand

Geoserver REST API GSCoverageBand

Geoserver REST API GSCoverageBand

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer coverage band

## Methods

- `new(xml)`:

  This method is used to instantiate a `GSCoverageBand`

- `decode(xml)`:

  This method is used to decode a `GSCoverageBand` from XML

- `encode()`:

  This method is used to encode a `GSCoverageBand` to XML

- `setDefinition(definition)`:

  Sets the coverage band definition

- `setIndex(index)`:

  Sets the coverage band index

- `setCompositionType`:

  Sets the composition type. Only 'BAND_SELECT' is supported by
  GeoServer for now.

- `addInputBand(band)`:

  Adds a input coverage band, object of class `GSInputCoverageBand`

- `delInputBand(band)`:

  Removes a input coverage band, object of class `GSInputCoverageBand`

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSCoverageBand`

## Public fields

- `inputCoverageBands`:

  list of input coverage bands

- `definition`:

  coverage band definition

- `index`:

  coverage band index

- `compositionType`:

  coverage band composition type

## Methods

### Public methods

- [`GSCoverageBand$new()`](#method-GSCoverageBand-new)

- [`GSCoverageBand$decode()`](#method-GSCoverageBand-decode)

- [`GSCoverageBand$setName()`](#method-GSCoverageBand-setName)

- [`GSCoverageBand$setDefinition()`](#method-GSCoverageBand-setDefinition)

- [`GSCoverageBand$setIndex()`](#method-GSCoverageBand-setIndex)

- [`GSCoverageBand$setCompositionType()`](#method-GSCoverageBand-setCompositionType)

- [`GSCoverageBand$addInputBand()`](#method-GSCoverageBand-addInputBand)

- [`GSCoverageBand$delInputBand()`](#method-GSCoverageBand-delInputBand)

- [`GSCoverageBand$clone()`](#method-GSCoverageBand-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initalizes a GSCoverageBand

#### Usage

    GSCoverageBand$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSCoverageBand$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setName()`

Set name

#### Usage

    GSCoverageBand$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setDefinition()`

Set definition

#### Usage

    GSCoverageBand$setDefinition(definition)

#### Arguments

- `definition`:

  definition

------------------------------------------------------------------------

### Method `setIndex()`

Set index

#### Usage

    GSCoverageBand$setIndex(index)

#### Arguments

- `index`:

  index

------------------------------------------------------------------------

### Method `setCompositionType()`

Set composition type

#### Usage

    GSCoverageBand$setCompositionType(compositionType)

#### Arguments

- `compositionType`:

  composition type

------------------------------------------------------------------------

### Method `addInputBand()`

Adds an input band

#### Usage

    GSCoverageBand$addInputBand(band)

#### Arguments

- `band`:

  object of class
  [GSInputCoverageBand](https://eblondel.github.io/geosapi/reference/GSInputCoverageBand.md)

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delInputBand()`

Deletes an input band

#### Usage

    GSCoverageBand$delInputBand(band)

#### Arguments

- `band`:

  object of class
  [GSInputCoverageBand](https://eblondel.github.io/geosapi/reference/GSInputCoverageBand.md)

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSCoverageBand$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
GSCoverageBand$new()
#> <GSCoverageBand>
#> ....|-- compositionType: BAND_SELECT

```
