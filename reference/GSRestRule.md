# A GeoServer access control list service rule

This class models a GeoServer access control list service rule

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer access control list service rule

## Details

Geoserver REST API Access Control List REST Rule

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSRule`](https://eblondel.github.io/geosapi/reference/GSRule.md)
-\> `GSRestRule`

## Public fields

- `roles`:

  one or more roles

## Methods

### Public methods

- [`GSRestRule$new()`](#method-GSRestRule-new)

- [`GSRestRule$clone()`](#method-GSRestRule-clone)

Inherited methods

- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSRule$decode()`](https://eblondel.github.io/geosapi/reference/GSRule.html#method-decode)
- [`geosapi::GSRule$encode()`](https://eblondel.github.io/geosapi/reference/GSRule.html#method-encode)

------------------------------------------------------------------------

### Method `new()`

Initializes a
[GSLayerRule](https://eblondel.github.io/geosapi/reference/GSLayerRule.md)

#### Usage

    GSRestRule$new(
      xml = NULL,
      pattern,
      methods,
      permission = c("r", "w", "a"),
      roles
    )

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `pattern`:

  a URL Ant pattern, only applicable for domain `rest`. Default is `/**`

- `methods`:

  HTTP method(s)

- `permission`:

  the rule permission, either `r` (read), `w` (write) or `a`
  (administer)

- `roles`:

  one or more roles to add for the rule

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSRestRule$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
