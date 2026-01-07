# Geoserver REST API XML entry set

Geoserver REST API XML entry set

Geoserver REST API XML entry set

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a entry set

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSRESTEntrySet`

## Public fields

- `entryset`:

  entryset

## Methods

### Public methods

- [`GSRESTEntrySet$new()`](#method-GSRESTEntrySet-new)

- [`GSRESTEntrySet$decode()`](#method-GSRESTEntrySet-decode)

- [`GSRESTEntrySet$setEntryset()`](#method-GSRESTEntrySet-setEntryset)

- [`GSRESTEntrySet$addEntry()`](#method-GSRESTEntrySet-addEntry)

- [`GSRESTEntrySet$setEntry()`](#method-GSRESTEntrySet-setEntry)

- [`GSRESTEntrySet$delEntry()`](#method-GSRESTEntrySet-delEntry)

- [`GSRESTEntrySet$clone()`](#method-GSRESTEntrySet-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSRESTEntrySet

#### Usage

    GSRESTEntrySet$new(rootName, xml = NULL, entryset)

#### Arguments

- `rootName`:

  root name

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `entryset`:

  entry set

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSRESTEntrySet$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setEntryset()`

Set entry set

#### Usage

    GSRESTEntrySet$setEntryset(entryset)

#### Arguments

- `entryset`:

  entry set

------------------------------------------------------------------------

### Method `addEntry()`

Adds entry set

#### Usage

    GSRESTEntrySet$addEntry(key, value)

#### Arguments

- `key`:

  key

- `value`:

  value

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setEntry()`

Sets entry set

#### Usage

    GSRESTEntrySet$setEntry(key, value)

#### Arguments

- `key`:

  key

- `value`:

  value

------------------------------------------------------------------------

### Method `delEntry()`

Deletes entry set

#### Usage

    GSRESTEntrySet$delEntry(key)

#### Arguments

- `key`:

  key

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSRESTEntrySet$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
