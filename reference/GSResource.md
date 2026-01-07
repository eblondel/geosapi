# A GeoServer abstract resource

This class models an abstract GeoServer resource. This class is used
internally for modelling instances of class `GSFeatureType` or
`GSCoverage`

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer resource

## Details

Geoserver REST API Resource

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSResource`

## Public fields

- `full`:

  full

- `name`:

  resource name

- `nativeName`:

  resource native name

- `title`:

  resource title

- `description`:

  resource description

- `abstract`:

  resource abstract

- `keywords`:

  resource keywords

- `metadataLinks`:

  resource metadata links

- `nativeCRS`:

  resource native CRS

- `srs`:

  resource srs

- `nativeBoundingBox`:

  resource lat/lon native bounding box

- `latLonBoundingBox`:

  resource lat/lon bounding box

- `projectionPolicy`:

  resource projection policy

- `enabled`:

  enabled

- `metadata`:

  metadata

## Methods

### Public methods

- [`GSResource$new()`](#method-GSResource-new)

- [`GSResource$decode()`](#method-GSResource-decode)

- [`GSResource$setEnabled()`](#method-GSResource-setEnabled)

- [`GSResource$setName()`](#method-GSResource-setName)

- [`GSResource$setNativeName()`](#method-GSResource-setNativeName)

- [`GSResource$setTitle()`](#method-GSResource-setTitle)

- [`GSResource$setDescription()`](#method-GSResource-setDescription)

- [`GSResource$setAbstract()`](#method-GSResource-setAbstract)

- [`GSResource$setKeywords()`](#method-GSResource-setKeywords)

- [`GSResource$addKeyword()`](#method-GSResource-addKeyword)

- [`GSResource$delKeyword()`](#method-GSResource-delKeyword)

- [`GSResource$setMetadataLinks()`](#method-GSResource-setMetadataLinks)

- [`GSResource$addMetadataLink()`](#method-GSResource-addMetadataLink)

- [`GSResource$deleteMetadataLink()`](#method-GSResource-deleteMetadataLink)

- [`GSResource$setProjectionPolicy()`](#method-GSResource-setProjectionPolicy)

- [`GSResource$setSrs()`](#method-GSResource-setSrs)

- [`GSResource$setNativeCRS()`](#method-GSResource-setNativeCRS)

- [`GSResource$setLatLonBoundingBox()`](#method-GSResource-setLatLonBoundingBox)

- [`GSResource$setNativeBoundingBox()`](#method-GSResource-setNativeBoundingBox)

- [`GSResource$setMetadata()`](#method-GSResource-setMetadata)

- [`GSResource$delMetadata()`](#method-GSResource-delMetadata)

- [`GSResource$setMetadataDimension()`](#method-GSResource-setMetadataDimension)

- [`GSResource$clone()`](#method-GSResource-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes a GSResource

#### Usage

    GSResource$new(rootName = NULL, xml = NULL)

#### Arguments

- `rootName`:

  root name

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSResource$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setEnabled()`

Set enabled

#### Usage

    GSResource$setEnabled(enabled)

#### Arguments

- `enabled`:

  enabled

------------------------------------------------------------------------

### Method `setName()`

Set name

#### Usage

    GSResource$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setNativeName()`

Set native name

#### Usage

    GSResource$setNativeName(nativeName)

#### Arguments

- `nativeName`:

  native name

------------------------------------------------------------------------

### Method `setTitle()`

Set title

#### Usage

    GSResource$setTitle(title)

#### Arguments

- `title`:

  title

------------------------------------------------------------------------

### Method `setDescription()`

Set description

#### Usage

    GSResource$setDescription(description)

#### Arguments

- `description`:

  description

------------------------------------------------------------------------

### Method `setAbstract()`

Set abstract

#### Usage

    GSResource$setAbstract(abstract)

#### Arguments

- `abstract`:

  abstract

------------------------------------------------------------------------

### Method `setKeywords()`

Set keyword(s)

#### Usage

    GSResource$setKeywords(keywords)

#### Arguments

- `keywords`:

  keywords

------------------------------------------------------------------------

### Method `addKeyword()`

Adds keyword

#### Usage

    GSResource$addKeyword(keyword)

#### Arguments

- `keyword`:

  keyword

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delKeyword()`

Deletes keyword

#### Usage

    GSResource$delKeyword(keyword)

#### Arguments

- `keyword`:

  keyword

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setMetadataLinks()`

Set metadata links

#### Usage

    GSResource$setMetadataLinks(metadataLinks)

#### Arguments

- `metadataLinks`:

  metadata links

------------------------------------------------------------------------

### Method `addMetadataLink()`

Adds metadata link

#### Usage

    GSResource$addMetadataLink(metadataLink)

#### Arguments

- `metadataLink`:

  object of class
  [GSMetadataLink](https://eblondel.github.io/geosapi/reference/GSMetadataLink.md)

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteMetadataLink()`

Deletes metadata link

#### Usage

    GSResource$deleteMetadataLink(metadataLink)

#### Arguments

- `metadataLink`:

  object of class
  [GSMetadataLink](https://eblondel.github.io/geosapi/reference/GSMetadataLink.md)

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setProjectionPolicy()`

Set projection policy

#### Usage

    GSResource$setProjectionPolicy(projectionPolicy)

#### Arguments

- `projectionPolicy`:

  projection policy

------------------------------------------------------------------------

### Method `setSrs()`

Set SRS

#### Usage

    GSResource$setSrs(srs)

#### Arguments

- `srs`:

  srs

------------------------------------------------------------------------

### Method `setNativeCRS()`

Set native CRS

#### Usage

    GSResource$setNativeCRS(nativeCRS)

#### Arguments

- `nativeCRS`:

  native crs

------------------------------------------------------------------------

### Method `setLatLonBoundingBox()`

Set LatLon bounding box

#### Usage

    GSResource$setLatLonBoundingBox(minx, miny, maxx, maxy, bbox = NULL, crs)

#### Arguments

- `minx`:

  minx

- `miny`:

  miny

- `maxx`:

  maxx

- `maxy`:

  maxy

- `bbox`:

  bbox

- `crs`:

  crs

------------------------------------------------------------------------

### Method `setNativeBoundingBox()`

Set native bounding box

#### Usage

    GSResource$setNativeBoundingBox(minx, miny, maxx, maxy, bbox = NULL, crs)

#### Arguments

- `minx`:

  minx

- `miny`:

  miny

- `maxx`:

  maxx

- `maxy`:

  maxy

- `bbox`:

  bbox

- `crs`:

  crs

------------------------------------------------------------------------

### Method `setMetadata()`

Set metadata

#### Usage

    GSResource$setMetadata(key, metadata)

#### Arguments

- `key`:

  key

- `metadata`:

  metadata

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delMetadata()`

Deletes metadata

#### Usage

    GSResource$delMetadata(key)

#### Arguments

- `key`:

  key

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setMetadataDimension()`

Set metadata dimension

#### Usage

    GSResource$setMetadataDimension(key, dimension, custom = FALSE)

#### Arguments

- `key`:

  key

- `dimension`:

  dimension

- `custom`:

  custom

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSResource$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
res <- GSResource$new(rootName = "featureType")
```
