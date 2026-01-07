# Geoserver REST API GeoPackageDataStore

Geoserver REST API GeoPackageDataStore

Geoserver REST API GeoPackageDataStore

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer GeoPackage dataStore

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSAbstractStore`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.md)
-\>
[`geosapi::GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)
-\>
[`geosapi::GSAbstractDBDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.md)
-\> `GSGeoPackageDataStore`

## Methods

### Public methods

- [`GSGeoPackageDataStore$new()`](#method-GSGeoPackageDataStore-new)

- [`GSGeoPackageDataStore$clone()`](#method-GSGeoPackageDataStore-clone)

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
- [`geosapi::GSAbstractDBDataStore$setConnectionTimeout()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setConnectionTimeout)
- [`geosapi::GSAbstractDBDataStore$setDatabase()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setDatabase)
- [`geosapi::GSAbstractDBDataStore$setDatabaseType()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setDatabaseType)
- [`geosapi::GSAbstractDBDataStore$setDefautConnectionParameters()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setDefautConnectionParameters)
- [`geosapi::GSAbstractDBDataStore$setEstimatedExtends()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setEstimatedExtends)
- [`geosapi::GSAbstractDBDataStore$setExposePrimaryKeys()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setExposePrimaryKeys)
- [`geosapi::GSAbstractDBDataStore$setFetchSize()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setFetchSize)
- [`geosapi::GSAbstractDBDataStore$setHost()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setHost)
- [`geosapi::GSAbstractDBDataStore$setJndiReferenceName()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setJndiReferenceName)
- [`geosapi::GSAbstractDBDataStore$setLooseBBox()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setLooseBBox)
- [`geosapi::GSAbstractDBDataStore$setMaxConnections()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setMaxConnections)
- [`geosapi::GSAbstractDBDataStore$setMaxOpenPreparedStatements()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setMaxOpenPreparedStatements)
- [`geosapi::GSAbstractDBDataStore$setMinConnections()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setMinConnections)
- [`geosapi::GSAbstractDBDataStore$setNamespace()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setNamespace)
- [`geosapi::GSAbstractDBDataStore$setPassword()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setPassword)
- [`geosapi::GSAbstractDBDataStore$setPort()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setPort)
- [`geosapi::GSAbstractDBDataStore$setPreparedStatements()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setPreparedStatements)
- [`geosapi::GSAbstractDBDataStore$setPrimaryKeyMetadataTable()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setPrimaryKeyMetadataTable)
- [`geosapi::GSAbstractDBDataStore$setSchema()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setSchema)
- [`geosapi::GSAbstractDBDataStore$setUser()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setUser)
- [`geosapi::GSAbstractDBDataStore$setValidateConnections()`](https://eblondel.github.io/geosapi/reference/GSAbstractDBDataStore.html#method-setValidateConnections)

------------------------------------------------------------------------

### Method `new()`

initializes an GeoPackage data store

#### Usage

    GSGeoPackageDataStore$new(
      xml = NULL,
      name = NULL,
      description = "",
      enabled = TRUE,
      database = NULL
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

- `database`:

  database

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSGeoPackageDataStore$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
ds <- GSGeoPackageDataStore$new(
 name = "ds", description = "des", 
 enabled = TRUE, database = NULL
)
```
