# A GeoServer access control list rule

This class models a GeoServer access control list rule

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer access control list rule

## Details

Geoserver REST API Access Control List Rule

## Note

Abstract class

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSRule`

## Methods

### Public methods

- [`GSRule$new()`](#method-GSRule-new)

- [`GSRule$encode()`](#method-GSRule-encode)

- [`GSRule$decode()`](#method-GSRule-decode)

- [`GSRule$clone()`](#method-GSRule-clone)

Inherited methods

- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes a GSRule

#### Usage

    GSRule$new(xml = NULL, domain = c("layers", "services", "rest"))

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `domain`:

  the access control domain

------------------------------------------------------------------------

### Method `encode()`

Encodes as XML

#### Usage

    GSRule$encode()

#### Returns

an object of class
[xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSRule$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSRule$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
