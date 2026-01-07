# A GeoServer layer resource

This class models a GeoServer layer. This class is to be used for
published resource (feature type or coverage).

This class models a GeoServer style.

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer layer

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer style

## Details

Geoserver REST API Resource

Geoserver REST API Style

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSLayer`

## Public fields

- `full`:

  full

- `name`:

  name

- `path`:

  path

- `defaultStyle`:

  default style

- `styles`:

  styles

- `enabled`:

  enabled

- `queryable`:

  queryable

- `advertised`:

  advertised

## Methods

### Public methods

- [`GSLayer$new()`](#method-GSLayer-new)

- [`GSLayer$decode()`](#method-GSLayer-decode)

- [`GSLayer$setName()`](#method-GSLayer-setName)

- [`GSLayer$setPath()`](#method-GSLayer-setPath)

- [`GSLayer$setEnabled()`](#method-GSLayer-setEnabled)

- [`GSLayer$setQueryable()`](#method-GSLayer-setQueryable)

- [`GSLayer$setAdvertised()`](#method-GSLayer-setAdvertised)

- [`GSLayer$setDefaultStyle()`](#method-GSLayer-setDefaultStyle)

- [`GSLayer$setStyles()`](#method-GSLayer-setStyles)

- [`GSLayer$addStyle()`](#method-GSLayer-addStyle)

- [`GSLayer$delStyle()`](#method-GSLayer-delStyle)

- [`GSLayer$clone()`](#method-GSLayer-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSLayer

#### Usage

    GSLayer$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSLayer$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setName()`

Set name

#### Usage

    GSLayer$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setPath()`

Set path

#### Usage

    GSLayer$setPath(path)

#### Arguments

- `path`:

  path

------------------------------------------------------------------------

### Method `setEnabled()`

Set enabled

#### Usage

    GSLayer$setEnabled(enabled)

#### Arguments

- `enabled`:

  enabled

------------------------------------------------------------------------

### Method `setQueryable()`

Set queryable

#### Usage

    GSLayer$setQueryable(queryable)

#### Arguments

- `queryable`:

  queryable

------------------------------------------------------------------------

### Method `setAdvertised()`

Set advertised

#### Usage

    GSLayer$setAdvertised(advertised)

#### Arguments

- `advertised`:

  advertised

------------------------------------------------------------------------

### Method `setDefaultStyle()`

Set default style

#### Usage

    GSLayer$setDefaultStyle(style)

#### Arguments

- `style`:

  object o class GSStyle or `character`

------------------------------------------------------------------------

### Method `setStyles()`

Set styles

#### Usage

    GSLayer$setStyles(styles)

#### Arguments

- `styles`:

  styles

------------------------------------------------------------------------

### Method `addStyle()`

Adds style

#### Usage

    GSLayer$addStyle(style)

#### Arguments

- `style`:

  style, object o class GSStyle or `character`

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delStyle()`

Deletes style

#### Usage

    GSLayer$delStyle(style)

#### Arguments

- `style`:

  style, object o class GSStyle or `character`

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSLayer$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSStyle`

## Public fields

- `full`:

  full

- `name`:

  name

- `filename`:

  filename

## Methods

### Public methods

- [`GSStyle$new()`](#method-GSStyle-new)

- [`GSStyle$decode()`](#method-GSStyle-decode)

- [`GSStyle$setName()`](#method-GSStyle-setName)

- [`GSStyle$setFilename()`](#method-GSStyle-setFilename)

- [`GSStyle$clone()`](#method-GSStyle-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes a GSStyle

#### Usage

    GSStyle$new(xml = NULL, name = NULL, filename = NULL)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `name`:

  name

- `filename`:

  filename

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSStyle$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setName()`

set name

#### Usage

    GSStyle$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setFilename()`

Set filename

#### Usage

    GSStyle$setFilename(filename)

#### Arguments

- `filename`:

  filename

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSStyle$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  lyr <- GSLayer$new()

  lyr <- GSStyle$new()
```
