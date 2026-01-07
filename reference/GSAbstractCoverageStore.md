# Geoserver REST API CoverageStore

Geoserver REST API CoverageStore

Geoserver REST API CoverageStore

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer CoverageStore

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSAbstractStore`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.md)
-\> `GSAbstractCoverageStore`

## Public fields

- `url`:

  URL of the abstract coverage store

## Methods

### Public methods

- [`GSAbstractCoverageStore$new()`](#method-GSAbstractCoverageStore-new)

- [`GSAbstractCoverageStore$decode()`](#method-GSAbstractCoverageStore-decode)

- [`GSAbstractCoverageStore$setUrl()`](#method-GSAbstractCoverageStore-setUrl)

- [`GSAbstractCoverageStore$clone()`](#method-GSAbstractCoverageStore-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSAbstractStore$setDescription()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setDescription)
- [`geosapi::GSAbstractStore$setEnabled()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setEnabled)
- [`geosapi::GSAbstractStore$setType()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setType)

------------------------------------------------------------------------

### Method `new()`

initializes an abstract coverage store

#### Usage

    GSAbstractCoverageStore$new(
      xml = NULL,
      type = NULL,
      name = NULL,
      description = "",
      enabled = TRUE,
      url = NULL
    )

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md) to
  create object from XML

- `type`:

  the type of coverage store

- `name`:

  coverage store name

- `description`:

  coverage store description

- `enabled`:

  whether the store should be enabled or not. Default is `TRUE`

- `url`:

  URL of the store

------------------------------------------------------------------------

### Method `decode()`

Decodes a coverage store from XML

#### Usage

    GSAbstractCoverageStore$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

#### Returns

an object of class GSAbstractCoverageStore

------------------------------------------------------------------------

### Method `setUrl()`

set coverage store URL

#### Usage

    GSAbstractCoverageStore$setUrl(url)

#### Arguments

- `url`:

  the store URL to set

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSAbstractCoverageStore$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
