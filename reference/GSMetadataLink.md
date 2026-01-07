# A GeoServer resource metadataLink

This class models a GeoServer resource metadataLink made of a type (free
text e.g. text/xml, text/html), a metadataType (Possible values are
ISO19115:2003, FGDC, TC211, 19139, other), and a content: an URL that
gives the metadataLink

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer resource metadataLink

## Details

Geoserver REST API Metadatalink

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSMetadataLink`

## Public fields

- `type`:

  type

- `metadataType`:

  metadata type

- `content`:

  content

## Methods

### Public methods

- [`GSMetadataLink$new()`](#method-GSMetadataLink-new)

- [`GSMetadataLink$decode()`](#method-GSMetadataLink-decode)

- [`GSMetadataLink$setType()`](#method-GSMetadataLink-setType)

- [`GSMetadataLink$setMetadataType()`](#method-GSMetadataLink-setMetadataType)

- [`GSMetadataLink$setContent()`](#method-GSMetadataLink-setContent)

- [`GSMetadataLink$clone()`](#method-GSMetadataLink-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSMetadataLink

#### Usage

    GSMetadataLink$new(xml = NULL, type, metadataType, content)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `type`:

  type

- `metadataType`:

  metadata type

- `content`:

  content

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSMetadataLink$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setType()`

Set type type

#### Usage

    GSMetadataLink$setType(type)

#### Arguments

- `type`:

  type

------------------------------------------------------------------------

### Method `setMetadataType()`

Set metadata type

#### Usage

    GSMetadataLink$setMetadataType(metadataType)

#### Arguments

- `metadataType`:

  metadata type. Supported values: "ISO19115:2003", "FGDC", "TC211",
  "19139", "other"

------------------------------------------------------------------------

### Method `setContent()`

Set content

#### Usage

    GSMetadataLink$setContent(content)

#### Arguments

- `content`:

  content

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSMetadataLink$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
