# A GeoServer service settings resource

This class models a GeoServer OWS service settings.

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer OWS service setting

## Details

Geoserver REST API Service Setting

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSServiceSettings`

## Public fields

- `enabled`:

  is service enabled or not?

- `citeCompliant`:

  is service cite compliant?

- `name`:

  service name

- `title`:

  service title

- `maintainer`:

  service maintainer

- `abstrct`:

  service abastract

- `accessConstraints`:

  service access constraints

- `fees`:

  service fees

- `keywords`:

  services keywords

- `onlineResource`:

  service online resource

- `schemaBaseURL`:

  service schema base URL

- `verbose`:

  service verbose or not?

## Methods

### Public methods

- [`GSServiceSettings$new()`](#method-GSServiceSettings-new)

- [`GSServiceSettings$decode()`](#method-GSServiceSettings-decode)

- [`GSServiceSettings$setEnabled()`](#method-GSServiceSettings-setEnabled)

- [`GSServiceSettings$setCiteCompliant()`](#method-GSServiceSettings-setCiteCompliant)

- [`GSServiceSettings$setName()`](#method-GSServiceSettings-setName)

- [`GSServiceSettings$setTitle()`](#method-GSServiceSettings-setTitle)

- [`GSServiceSettings$setMaintainer()`](#method-GSServiceSettings-setMaintainer)

- [`GSServiceSettings$setAbstract()`](#method-GSServiceSettings-setAbstract)

- [`GSServiceSettings$setAccessConstraints()`](#method-GSServiceSettings-setAccessConstraints)

- [`GSServiceSettings$setFees()`](#method-GSServiceSettings-setFees)

- [`GSServiceSettings$setKeywords()`](#method-GSServiceSettings-setKeywords)

- [`GSServiceSettings$addKeyword()`](#method-GSServiceSettings-addKeyword)

- [`GSServiceSettings$delKeyword()`](#method-GSServiceSettings-delKeyword)

- [`GSServiceSettings$clone()`](#method-GSServiceSettings-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSServiceSettings

#### Usage

    GSServiceSettings$new(xml = NULL, service)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `service`:

  service service acronym

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSServiceSettings$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setEnabled()`

Set enabled

#### Usage

    GSServiceSettings$setEnabled(enabled)

#### Arguments

- `enabled`:

  enabled

------------------------------------------------------------------------

### Method `setCiteCompliant()`

Set cite compliant

#### Usage

    GSServiceSettings$setCiteCompliant(citeCompliant)

#### Arguments

- `citeCompliant`:

  cite compliant

------------------------------------------------------------------------

### Method `setName()`

Set name

#### Usage

    GSServiceSettings$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setTitle()`

Set title

#### Usage

    GSServiceSettings$setTitle(title)

#### Arguments

- `title`:

  title

------------------------------------------------------------------------

### Method `setMaintainer()`

Set maintainer

#### Usage

    GSServiceSettings$setMaintainer(maintainer)

#### Arguments

- `maintainer`:

  maintainer

------------------------------------------------------------------------

### Method `setAbstract()`

Set abstract

#### Usage

    GSServiceSettings$setAbstract(abstract)

#### Arguments

- `abstract`:

  abstract

------------------------------------------------------------------------

### Method `setAccessConstraints()`

Set access constraints

#### Usage

    GSServiceSettings$setAccessConstraints(accessConstraints)

#### Arguments

- `accessConstraints`:

  access constraints

------------------------------------------------------------------------

### Method `setFees()`

Set fees

#### Usage

    GSServiceSettings$setFees(fees)

#### Arguments

- `fees`:

  fees

------------------------------------------------------------------------

### Method `setKeywords()`

Set keywords

#### Usage

    GSServiceSettings$setKeywords(keywords)

#### Arguments

- `keywords`:

  keywords

------------------------------------------------------------------------

### Method `addKeyword()`

Adds a keyword

#### Usage

    GSServiceSettings$addKeyword(keyword)

#### Arguments

- `keyword`:

  keyword

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `delKeyword()`

Deletes a keyword

#### Usage

    GSServiceSettings$delKeyword(keyword)

#### Arguments

- `keyword`:

  keyword

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSServiceSettings$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
settings <- GSServiceSettings$new(service = "WMS")
settings$setEnabled(TRUE)
```
