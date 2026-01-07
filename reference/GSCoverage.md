# A GeoServer coverage

This class models a GeoServer coverage. This class is to be used for
manipulating representations of vector data with GeoServer.

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer coverage

## Details

Geoserver REST API Resource

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSResource`](https://eblondel.github.io/geosapi/reference/GSResource.md)
-\> `GSCoverage`

## Public fields

- `cqlFilter`:

  CQL filter

## Methods

### Public methods

- [`GSCoverage$new()`](#method-GSCoverage-new)

- [`GSCoverage$decode()`](#method-GSCoverage-decode)

- [`GSCoverage$setView()`](#method-GSCoverage-setView)

- [`GSCoverage$delView()`](#method-GSCoverage-delView)

- [`GSCoverage$clone()`](#method-GSCoverage-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSResource$addKeyword()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-addKeyword)
- [`geosapi::GSResource$addMetadataLink()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-addMetadataLink)
- [`geosapi::GSResource$delKeyword()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-delKeyword)
- [`geosapi::GSResource$delMetadata()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-delMetadata)
- [`geosapi::GSResource$deleteMetadataLink()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-deleteMetadataLink)
- [`geosapi::GSResource$setAbstract()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setAbstract)
- [`geosapi::GSResource$setDescription()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setDescription)
- [`geosapi::GSResource$setEnabled()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setEnabled)
- [`geosapi::GSResource$setKeywords()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setKeywords)
- [`geosapi::GSResource$setLatLonBoundingBox()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setLatLonBoundingBox)
- [`geosapi::GSResource$setMetadata()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setMetadata)
- [`geosapi::GSResource$setMetadataDimension()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setMetadataDimension)
- [`geosapi::GSResource$setMetadataLinks()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setMetadataLinks)
- [`geosapi::GSResource$setName()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setName)
- [`geosapi::GSResource$setNativeBoundingBox()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setNativeBoundingBox)
- [`geosapi::GSResource$setNativeCRS()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setNativeCRS)
- [`geosapi::GSResource$setNativeName()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setNativeName)
- [`geosapi::GSResource$setProjectionPolicy()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setProjectionPolicy)
- [`geosapi::GSResource$setSrs()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setSrs)
- [`geosapi::GSResource$setTitle()`](https://eblondel.github.io/geosapi/reference/GSResource.html#method-setTitle)

------------------------------------------------------------------------

### Method `new()`

Initializes a GSCoverage from XML

#### Usage

    GSCoverage$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes coverage from XML

#### Usage

    GSCoverage$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setView()`

Set view

#### Usage

    GSCoverage$setView(cv)

#### Arguments

- `cv`:

  cv, object of class
  [GSCoverageView](https://eblondel.github.io/geosapi/reference/GSCoverageView.md)

#### Returns

`TRUE` if set, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delView()`

Deletes view

#### Usage

    GSCoverage$delView()

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSCoverage$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
gt <- GSCoverage$new()
```
