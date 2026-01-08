# Geoserver REST API REST Resource interface

Geoserver REST API REST Resource interface

Geoserver REST API REST Resource interface

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer REST resource interface

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Public fields

- `rootName`:

  root name

- `attrs`:

  attrs

## Methods

### Public methods

- [`GSRESTResource$new()`](#method-GSRESTResource-new)

- [`GSRESTResource$decode()`](#method-GSRESTResource-decode)

- [`GSRESTResource$encode()`](#method-GSRESTResource-encode)

- [`GSRESTResource$print()`](#method-GSRESTResource-print)

- [`GSRESTResource$getClassName()`](#method-GSRESTResource-getClassName)

- [`GSRESTResource$clone()`](#method-GSRESTResource-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSRESTResource

#### Usage

    GSRESTResource$new(xml, rootName)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `rootName`:

  root name

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML. Abstract method to be implemented by sub-classes

#### Usage

    GSRESTResource$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `encode()`

Encodes as XML

#### Usage

    GSRESTResource$encode()

#### Returns

an object of class
[xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method [`print()`](https://rdrr.io/r/base/print.html)

Provides a custom print output (as tree) of the current class

#### Usage

    GSRESTResource$print(..., depth = 1)

#### Arguments

- `...`:

  args

- `depth`:

  class nesting depth

------------------------------------------------------------------------

### Method `getClassName()`

Get class name

#### Usage

    GSRESTResource$getClassName()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSRESTResource$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
