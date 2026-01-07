# Geoserver REST API ArcGridCoverageStore

Geoserver REST API ArcGridCoverageStore

Geoserver REST API ArcGridCoverageStore

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer ArcGrid CoverageStore

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSAbstractStore`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.md)
-\>
[`geosapi::GSAbstractCoverageStore`](https://eblondel.github.io/geosapi/reference/GSAbstractCoverageStore.md)
-\> `GSArcGridCoverageStore`

## Public fields

- `url`:

  url

## Methods

### Public methods

- [`GSArcGridCoverageStore$new()`](#method-GSArcGridCoverageStore-new)

- [`GSArcGridCoverageStore$clone()`](#method-GSArcGridCoverageStore-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSAbstractStore$setDescription()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setDescription)
- [`geosapi::GSAbstractStore$setEnabled()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setEnabled)
- [`geosapi::GSAbstractStore$setType()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setType)
- [`geosapi::GSAbstractCoverageStore$decode()`](https://eblondel.github.io/geosapi/reference/GSAbstractCoverageStore.html#method-decode)
- [`geosapi::GSAbstractCoverageStore$setUrl()`](https://eblondel.github.io/geosapi/reference/GSAbstractCoverageStore.html#method-setUrl)

------------------------------------------------------------------------

### Method `new()`

initializes an abstract ArcGrid coverage store

#### Usage

    GSArcGridCoverageStore$new(
      xml = NULL,
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

- `name`:

  coverage store name

- `description`:

  coverage store description

- `enabled`:

  whether the store should be enabled or not. Default is `TRUE`

- `url`:

  url

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSArcGridCoverageStore$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
