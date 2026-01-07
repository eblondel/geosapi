# Geoserver REST API GSVirtualTable

Geoserver REST API GSVirtualTable

Geoserver REST API GSVirtualTable

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer virtual table

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSVirtualTable`

## Public fields

- `name`:

  name

- `sql`:

  SQL statement

- `escapeSql`:

  escape SQL?

- `keyColumn`:

  key column

- `geometry`:

  geometry

- `parameters`:

  list of virtual parameters

## Methods

### Public methods

- [`GSVirtualTable$new()`](#method-GSVirtualTable-new)

- [`GSVirtualTable$decode()`](#method-GSVirtualTable-decode)

- [`GSVirtualTable$setName()`](#method-GSVirtualTable-setName)

- [`GSVirtualTable$setSql()`](#method-GSVirtualTable-setSql)

- [`GSVirtualTable$setEscapeSql()`](#method-GSVirtualTable-setEscapeSql)

- [`GSVirtualTable$setKeyColumn()`](#method-GSVirtualTable-setKeyColumn)

- [`GSVirtualTable$setGeometry()`](#method-GSVirtualTable-setGeometry)

- [`GSVirtualTable$addParameter()`](#method-GSVirtualTable-addParameter)

- [`GSVirtualTable$delParameter()`](#method-GSVirtualTable-delParameter)

- [`GSVirtualTable$clone()`](#method-GSVirtualTable-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSVirtualTable

#### Usage

    GSVirtualTable$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSVirtualTable$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setName()`

Set name

#### Usage

    GSVirtualTable$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setSql()`

Set SQL

#### Usage

    GSVirtualTable$setSql(sql)

#### Arguments

- `sql`:

  sql

------------------------------------------------------------------------

### Method `setEscapeSql()`

Set escape SQL

#### Usage

    GSVirtualTable$setEscapeSql(escapeSql)

#### Arguments

- `escapeSql`:

  escape SQL

------------------------------------------------------------------------

### Method `setKeyColumn()`

Set key column

#### Usage

    GSVirtualTable$setKeyColumn(keyColumn)

#### Arguments

- `keyColumn`:

  key column

------------------------------------------------------------------------

### Method `setGeometry()`

Set geometry

#### Usage

    GSVirtualTable$setGeometry(vtg)

#### Arguments

- `vtg`:

  object of class
  [GSVirtualTableGeometry](https://eblondel.github.io/geosapi/reference/GSVirtualTableGeometry.md)

------------------------------------------------------------------------

### Method `addParameter()`

Adds parameter

#### Usage

    GSVirtualTable$addParameter(parameter)

#### Arguments

- `parameter`:

  object of class
  [GSVirtualTableParameter](https://eblondel.github.io/geosapi/reference/GSVirtualTableParameter.md)

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delParameter()`

Deletes parameter

#### Usage

    GSVirtualTable$delParameter(parameter)

#### Arguments

- `parameter`:

  object of class
  [GSVirtualTableParameter](https://eblondel.github.io/geosapi/reference/GSVirtualTableParameter.md)

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSVirtualTable$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
GSVirtualTable$new()
#> <GSVirtualTable>
#> ....|-- name: NA
#> ....|-- sql: NA
#> ....|-- escapeSql: FALSE
```
