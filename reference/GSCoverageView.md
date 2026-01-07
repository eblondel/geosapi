# Geoserver REST API GSCoverageView

Geoserver REST API GSCoverageView

Geoserver REST API GSCoverageView

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer coverage view

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSCoverageView`

## Public fields

- `name`:

  name

- `envelopeCompositionType`:

  envelope composition type

- `selectedResolution`:

  selected resolution

- `selectedResolutionIndex`:

  selected resolution index

- `coverageBands`:

  coverage bands

## Methods

### Public methods

- [`GSCoverageView$new()`](#method-GSCoverageView-new)

- [`GSCoverageView$decode()`](#method-GSCoverageView-decode)

- [`GSCoverageView$setName()`](#method-GSCoverageView-setName)

- [`GSCoverageView$setEnvelopeCompositionType()`](#method-GSCoverageView-setEnvelopeCompositionType)

- [`GSCoverageView$setSelectedResolution()`](#method-GSCoverageView-setSelectedResolution)

- [`GSCoverageView$setSelectedResolutionIndex()`](#method-GSCoverageView-setSelectedResolutionIndex)

- [`GSCoverageView$addBand()`](#method-GSCoverageView-addBand)

- [`GSCoverageView$delBand()`](#method-GSCoverageView-delBand)

- [`GSCoverageView$clone()`](#method-GSCoverageView-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSCoverageView

#### Usage

    GSCoverageView$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSCoverageView$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setName()`

Set name

#### Usage

    GSCoverageView$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setEnvelopeCompositionType()`

Sets the envelope composition type. Type of Envelope Composition, used
to expose the bounding box of the CoverageView, either 'UNION' or
'INTERSECTION'.

#### Usage

    GSCoverageView$setEnvelopeCompositionType(envelopeCompositionType)

#### Arguments

- `envelopeCompositionType`:

  envelope composition type

------------------------------------------------------------------------

### Method `setSelectedResolution()`

Set selected resolution

#### Usage

    GSCoverageView$setSelectedResolution(selectedResolution)

#### Arguments

- `selectedResolution`:

  selected resolution

------------------------------------------------------------------------

### Method `setSelectedResolutionIndex()`

Set selected resolution index

#### Usage

    GSCoverageView$setSelectedResolutionIndex(selectedResolutionIndex)

#### Arguments

- `selectedResolutionIndex`:

  selected resolution index

------------------------------------------------------------------------

### Method `addBand()`

Adds band

#### Usage

    GSCoverageView$addBand(band)

#### Arguments

- `band`:

  object of class
  [GSCoverageBand](https://eblondel.github.io/geosapi/reference/GSCoverageBand.md)

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delBand()`

Deletes band

#### Usage

    GSCoverageView$delBand(band)

#### Arguments

- `band`:

  object of class
  [GSCoverageBand](https://eblondel.github.io/geosapi/reference/GSCoverageBand.md)

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSCoverageView$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  GSCoverageView$new()
#> <GSCoverageView>
#> ....|-- name: NA
```
