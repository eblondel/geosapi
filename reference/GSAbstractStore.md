# Geoserver REST API Store

Geoserver REST API Store

Geoserver REST API Store

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer store

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSAbstractStore`

## Public fields

- `full`:

  whether store object is fully described

- `name`:

  store name

- `enabled`:

  if the store is enabled or not

- `description`:

  store description

- `type`:

  store type

- `workspace`:

  workspace name

## Methods

### Public methods

- [`GSAbstractStore$new()`](#method-GSAbstractStore-new)

- [`GSAbstractStore$decode()`](#method-GSAbstractStore-decode)

- [`GSAbstractStore$setType()`](#method-GSAbstractStore-setType)

- [`GSAbstractStore$setEnabled()`](#method-GSAbstractStore-setEnabled)

- [`GSAbstractStore$setDescription()`](#method-GSAbstractStore-setDescription)

- [`GSAbstractStore$clone()`](#method-GSAbstractStore-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

initializes an abstract store

#### Usage

    GSAbstractStore$new(
      xml = NULL,
      storeType,
      type = NULL,
      name = NULL,
      description = "",
      enabled = TRUE
    )

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md) to
  create object from XML

- `storeType`:

  store type

- `type`:

  the type of coverage store

- `name`:

  coverage store name

- `description`:

  coverage store description

- `enabled`:

  whether the store should be enabled or not. Default is `TRUE`

------------------------------------------------------------------------

### Method `decode()`

Decodes store from XML

#### Usage

    GSAbstractStore$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setType()`

Set type

#### Usage

    GSAbstractStore$setType(type)

#### Arguments

- `type`:

  type

------------------------------------------------------------------------

### Method `setEnabled()`

Set enabled

#### Usage

    GSAbstractStore$setEnabled(enabled)

#### Arguments

- `enabled`:

  enabled

------------------------------------------------------------------------

### Method `setDescription()`

Set description

#### Usage

    GSAbstractStore$setDescription(description)

#### Arguments

- `description`:

  description

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSAbstractStore$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
