# Geoserver REST API ShapeFileDirectoryDataStore

Geoserver REST API ShapeFileDirectoryDataStore

Geoserver REST API ShapeFileDirectoryDataStore

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer Shapefile directory dataStore

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSAbstractStore`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.md)
-\>
[`geosapi::GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)
-\>
[`geosapi::GSShapefileDataStore`](https://eblondel.github.io/geosapi/reference/GSShapefileDataStore.md)
-\> `GSShapefileDirectoryDataStore`

## Methods

### Public methods

- [`GSShapefileDirectoryDataStore$new()`](#method-GSShapefileDirectoryDataStore-new)

- [`GSShapefileDirectoryDataStore$setUrl()`](#method-GSShapefileDirectoryDataStore-setUrl)

- [`GSShapefileDirectoryDataStore$setCharset()`](#method-GSShapefileDirectoryDataStore-setCharset)

- [`GSShapefileDirectoryDataStore$setCreateSpatialIndex()`](#method-GSShapefileDirectoryDataStore-setCreateSpatialIndex)

- [`GSShapefileDirectoryDataStore$setMemoryMappedBuffer()`](#method-GSShapefileDirectoryDataStore-setMemoryMappedBuffer)

- [`GSShapefileDirectoryDataStore$setCacheReuseMemoryMaps()`](#method-GSShapefileDirectoryDataStore-setCacheReuseMemoryMaps)

- [`GSShapefileDirectoryDataStore$setDefautConnectionParameters()`](#method-GSShapefileDirectoryDataStore-setDefautConnectionParameters)

- [`GSShapefileDirectoryDataStore$clone()`](#method-GSShapefileDirectoryDataStore-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSAbstractStore$setDescription()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setDescription)
- [`geosapi::GSAbstractStore$setEnabled()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setEnabled)
- [`geosapi::GSAbstractStore$setType()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setType)
- [`geosapi::GSAbstractDataStore$addConnectionParameter()`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.html#method-addConnectionParameter)
- [`geosapi::GSAbstractDataStore$decode()`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.html#method-decode)
- [`geosapi::GSAbstractDataStore$delConnectionParameter()`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.html#method-delConnectionParameter)
- [`geosapi::GSAbstractDataStore$setConnectionParameter()`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.html#method-setConnectionParameter)
- [`geosapi::GSAbstractDataStore$setConnectionParameters()`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.html#method-setConnectionParameters)

------------------------------------------------------------------------

### Method `new()`

initializes a shapefile directory data store

#### Usage

    GSShapefileDirectoryDataStore$new(
      xml = NULL,
      name = NULL,
      description = "",
      enabled = TRUE,
      url
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

### Method `setUrl()`

Set the spatial files data URL

#### Usage

    GSShapefileDirectoryDataStore$setUrl(url)

#### Arguments

- `url`:

  url

------------------------------------------------------------------------

### Method `setCharset()`

Set the charset used for DBF file.

#### Usage

    GSShapefileDirectoryDataStore$setCharset(charset = "ISO-8859-1")

#### Arguments

- `charset`:

  charset. Default value is 'ISO-8859-1'

------------------------------------------------------------------------

### Method `setCreateSpatialIndex()`

Set the 'Create Spatial Index' option

#### Usage

    GSShapefileDirectoryDataStore$setCreateSpatialIndex(create = TRUE)

#### Arguments

- `create`:

  create. Default is `TRUE`

------------------------------------------------------------------------

### Method `setMemoryMappedBuffer()`

Set the 'Memory Mapped Buffer' option

#### Usage

    GSShapefileDirectoryDataStore$setMemoryMappedBuffer(buffer = FALSE)

#### Arguments

- `buffer`:

  buffer. Default is `FALSE`

------------------------------------------------------------------------

### Method `setCacheReuseMemoryMaps()`

Set the 'Cache & Reuse Memory Maps' option.

#### Usage

    GSShapefileDirectoryDataStore$setCacheReuseMemoryMaps(maps = TRUE)

#### Arguments

- `maps`:

  maps. Default is `TRUE`

------------------------------------------------------------------------

### Method `setDefautConnectionParameters()`

Set default connection parameters

#### Usage

    GSShapefileDirectoryDataStore$setDefautConnectionParameters()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSShapefileDirectoryDataStore$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
GSShapefileDirectoryDataStore$new(name = "ds", description = "des",
                         enabled = TRUE, url = "file://data")
#> <GSShapefileDirectoryDataStore>
#> ....|-- name: ds
#> ....|-- enabled: TRUE
#> ....|-- description: des
#> ....|-- type: Directory of spatial files (shapefiles)
#> ....|-- connectionParameters <GSRESTEntrySet>
#> ........|-- entryset
#> ............|-- url: file://data
#> ............|-- charset: ISO-8859-1
#> ............|-- create spatial index: TRUE
#> ............|-- memory mapped buffer: FALSE
#> ............|-- cache and reuse memory maps: TRUE
```
