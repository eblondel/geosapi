# Geoserver REST API DataStore

Geoserver REST API DataStore

Geoserver REST API DataStore

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer dataStore

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSAbstractStore`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.md)
-\> `GSAbstractDataStore`

## Public fields

- `connectionParameters`:

  the list of connection parameters

## Methods

### Public methods

- [`GSAbstractDataStore$new()`](#method-GSAbstractDataStore-new)

- [`GSAbstractDataStore$decode()`](#method-GSAbstractDataStore-decode)

- [`GSAbstractDataStore$setConnectionParameters()`](#method-GSAbstractDataStore-setConnectionParameters)

- [`GSAbstractDataStore$addConnectionParameter()`](#method-GSAbstractDataStore-addConnectionParameter)

- [`GSAbstractDataStore$setConnectionParameter()`](#method-GSAbstractDataStore-setConnectionParameter)

- [`GSAbstractDataStore$delConnectionParameter()`](#method-GSAbstractDataStore-delConnectionParameter)

- [`GSAbstractDataStore$clone()`](#method-GSAbstractDataStore-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSAbstractStore$setDescription()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setDescription)
- [`geosapi::GSAbstractStore$setEnabled()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setEnabled)
- [`geosapi::GSAbstractStore$setType()`](https://eblondel.github.io/geosapi/reference/GSAbstractStore.html#method-setType)

------------------------------------------------------------------------

### Method `new()`

initializes an abstract data store

#### Usage

    GSAbstractDataStore$new(
      xml = NULL,
      type = NULL,
      name = NULL,
      description = "",
      enabled = TRUE,
      connectionParameters
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

- `connectionParameters`:

  the list of connection parameters

------------------------------------------------------------------------

### Method `decode()`

Decodes a data store from XML

#### Usage

    GSAbstractDataStore$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

#### Returns

an object of class GSAbstractDataStore

------------------------------------------------------------------------

### Method `setConnectionParameters()`

Set list connection parameters. The argument should be an object of
class `GSRESTEntrySet` giving a list of key/value parameter entries.

#### Usage

    GSAbstractDataStore$setConnectionParameters(parameters)

#### Arguments

- `parameters`:

  an object of class
  [GSRESTEntrySet](https://eblondel.github.io/geosapi/reference/GSRESTEntrySet.md)

------------------------------------------------------------------------

### Method `addConnectionParameter()`

Adds a connection parameter

#### Usage

    GSAbstractDataStore$addConnectionParameter(key, value)

#### Arguments

- `key`:

  connection parameter key

- `value`:

  connection parameter value

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setConnectionParameter()`

Sets a connection parameter

#### Usage

    GSAbstractDataStore$setConnectionParameter(key, value)

#### Arguments

- `key`:

  connection parameter key

- `value`:

  connection parameter value

------------------------------------------------------------------------

### Method `delConnectionParameter()`

Removes a connection parameter

#### Usage

    GSAbstractDataStore$delConnectionParameter(key)

#### Arguments

- `key`:

  connection parameter key

- `value`:

  connection parameter value

#### Returns

`TRUE` if removed, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSAbstractDataStore$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
