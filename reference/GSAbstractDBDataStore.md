# Geoserver REST API AbstractDBDataStore

Geoserver REST API AbstractDBDataStore

Geoserver REST API AbstractDBDataStore

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer abstract DB dataStore

## Note

Internal abstract class used for setting DB stores

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSAbstractStore`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.md)
-\>
[`geosapi::GSAbstractDataStore`](https://eblondel.github.io/geosapi/reference/GSAbstractDataStore.md)
-\> `GSAbstractDBDataStore`

## Methods

### Public methods

- [`GSAbstractDBDataStore$new()`](#method-GSAbstractDBDataStore-new)

- [`GSAbstractDBDataStore$setDatabaseType()`](#method-GSAbstractDBDataStore-setDatabaseType)

- [`GSAbstractDBDataStore$setNamespace()`](#method-GSAbstractDBDataStore-setNamespace)

- [`GSAbstractDBDataStore$setHost()`](#method-GSAbstractDBDataStore-setHost)

- [`GSAbstractDBDataStore$setPort()`](#method-GSAbstractDBDataStore-setPort)

- [`GSAbstractDBDataStore$setDatabase()`](#method-GSAbstractDBDataStore-setDatabase)

- [`GSAbstractDBDataStore$setSchema()`](#method-GSAbstractDBDataStore-setSchema)

- [`GSAbstractDBDataStore$setUser()`](#method-GSAbstractDBDataStore-setUser)

- [`GSAbstractDBDataStore$setPassword()`](#method-GSAbstractDBDataStore-setPassword)

- [`GSAbstractDBDataStore$setJndiReferenceName()`](#method-GSAbstractDBDataStore-setJndiReferenceName)

- [`GSAbstractDBDataStore$setExposePrimaryKeys()`](#method-GSAbstractDBDataStore-setExposePrimaryKeys)

- [`GSAbstractDBDataStore$setMinConnections()`](#method-GSAbstractDBDataStore-setMinConnections)

- [`GSAbstractDBDataStore$setMaxConnections()`](#method-GSAbstractDBDataStore-setMaxConnections)

- [`GSAbstractDBDataStore$setFetchSize()`](#method-GSAbstractDBDataStore-setFetchSize)

- [`GSAbstractDBDataStore$setConnectionTimeout()`](#method-GSAbstractDBDataStore-setConnectionTimeout)

- [`GSAbstractDBDataStore$setValidateConnections()`](#method-GSAbstractDBDataStore-setValidateConnections)

- [`GSAbstractDBDataStore$setPrimaryKeyMetadataTable()`](#method-GSAbstractDBDataStore-setPrimaryKeyMetadataTable)

- [`GSAbstractDBDataStore$setLooseBBox()`](#method-GSAbstractDBDataStore-setLooseBBox)

- [`GSAbstractDBDataStore$setPreparedStatements()`](#method-GSAbstractDBDataStore-setPreparedStatements)

- [`GSAbstractDBDataStore$setMaxOpenPreparedStatements()`](#method-GSAbstractDBDataStore-setMaxOpenPreparedStatements)

- [`GSAbstractDBDataStore$setEstimatedExtends()`](#method-GSAbstractDBDataStore-setEstimatedExtends)

- [`GSAbstractDBDataStore$setDefautConnectionParameters()`](#method-GSAbstractDBDataStore-setDefautConnectionParameters)

- [`GSAbstractDBDataStore$clone()`](#method-GSAbstractDBDataStore-clone)

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

initializes an abstract DB data store

#### Usage

    GSAbstractDBDataStore$new(
      xml = NULL,
      type = NULL,
      dbType = NULL,
      name = NULL,
      description = "",
      enabled = TRUE
    )

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md) to
  create object from XML

- `type`:

  the type of DB data store

- `dbType`:

  DB type

- `name`:

  coverage store name

- `description`:

  coverage store description

- `enabled`:

  whether the store should be enabled or not. Default is `TRUE`

------------------------------------------------------------------------

### Method `setDatabaseType()`

Set database type

#### Usage

    GSAbstractDBDataStore$setDatabaseType(dbtype)

#### Arguments

- `dbtype`:

  DB type

------------------------------------------------------------------------

### Method `setNamespace()`

Set namespace

#### Usage

    GSAbstractDBDataStore$setNamespace(namespace)

#### Arguments

- `namespace`:

  namespace

------------------------------------------------------------------------

### Method `setHost()`

Set host

#### Usage

    GSAbstractDBDataStore$setHost(host)

#### Arguments

- `host`:

  host

------------------------------------------------------------------------

### Method `setPort()`

Set port

#### Usage

    GSAbstractDBDataStore$setPort(port)

#### Arguments

- `port`:

  port

------------------------------------------------------------------------

### Method `setDatabase()`

Set database

#### Usage

    GSAbstractDBDataStore$setDatabase(database)

#### Arguments

- `database`:

  database

------------------------------------------------------------------------

### Method `setSchema()`

Set schema

#### Usage

    GSAbstractDBDataStore$setSchema(schema)

#### Arguments

- `schema`:

  schema

------------------------------------------------------------------------

### Method `setUser()`

Set user

#### Usage

    GSAbstractDBDataStore$setUser(user)

#### Arguments

- `user`:

  user

------------------------------------------------------------------------

### Method `setPassword()`

Set password

#### Usage

    GSAbstractDBDataStore$setPassword(password)

#### Arguments

- `password`:

  password

------------------------------------------------------------------------

### Method `setJndiReferenceName()`

Set JNDI reference name

#### Usage

    GSAbstractDBDataStore$setJndiReferenceName(jndiReferenceName)

#### Arguments

- `jndiReferenceName`:

  JNDI reference name

------------------------------------------------------------------------

### Method `setExposePrimaryKeys()`

Set expose primary keyws

#### Usage

    GSAbstractDBDataStore$setExposePrimaryKeys(exposePrimaryKeys)

#### Arguments

- `exposePrimaryKeys`:

  expose primary keys

------------------------------------------------------------------------

### Method `setMinConnections()`

Set min connections

#### Usage

    GSAbstractDBDataStore$setMinConnections(minConnections = 1)

#### Arguments

- `minConnections`:

  min connections. Default is 11

------------------------------------------------------------------------

### Method `setMaxConnections()`

Set max connections

#### Usage

    GSAbstractDBDataStore$setMaxConnections(maxConnections = 10)

#### Arguments

- `maxConnections`:

  max connections. Default is 10

------------------------------------------------------------------------

### Method `setFetchSize()`

Set fetch size

#### Usage

    GSAbstractDBDataStore$setFetchSize(fetchSize = 1000)

#### Arguments

- `fetchSize`:

  fetch size. Default is 1000

------------------------------------------------------------------------

### Method `setConnectionTimeout()`

Set connection timeout

#### Usage

    GSAbstractDBDataStore$setConnectionTimeout(seconds = 20)

#### Arguments

- `seconds`:

  timeout (in seconds). Default is 20

------------------------------------------------------------------------

### Method `setValidateConnections()`

Set validate connection

#### Usage

    GSAbstractDBDataStore$setValidateConnections(validateConnections)

#### Arguments

- `validateConnections`:

  Validate connections

------------------------------------------------------------------------

### Method `setPrimaryKeyMetadataTable()`

Set primary key metadata table

#### Usage

    GSAbstractDBDataStore$setPrimaryKeyMetadataTable(primaryKeyMetadataTable)

#### Arguments

- `primaryKeyMetadataTable`:

  primary key metadata table

------------------------------------------------------------------------

### Method `setLooseBBox()`

Set loose bbox

#### Usage

    GSAbstractDBDataStore$setLooseBBox(looseBBox = TRUE)

#### Arguments

- `looseBBox`:

  loose bbox. Default is `TRUE`

------------------------------------------------------------------------

### Method `setPreparedStatements()`

Set prepared statemnts

#### Usage

    GSAbstractDBDataStore$setPreparedStatements(preparedStatements = FALSE)

#### Arguments

- `preparedStatements`:

  prepared Statements. Default is `FALSE`

------------------------------------------------------------------------

### Method `setMaxOpenPreparedStatements()`

Set max open prepared statements

#### Usage

    GSAbstractDBDataStore$setMaxOpenPreparedStatements(
      maxOpenPreparedStatements = 50
    )

#### Arguments

- `maxOpenPreparedStatements`:

  max open preepared statements. Default is 50

------------------------------------------------------------------------

### Method `setEstimatedExtends()`

Set estimatedExtends

#### Usage

    GSAbstractDBDataStore$setEstimatedExtends(estimatedExtends = FALSE)

#### Arguments

- `estimatedExtends`:

  estimated extends. Default is `FALSE`

------------------------------------------------------------------------

### Method `setDefautConnectionParameters()`

Set default connection parameters

#### Usage

    GSAbstractDBDataStore$setDefautConnectionParameters()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSAbstractDBDataStore$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
