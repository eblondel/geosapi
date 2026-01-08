# A GeoServer access control list layer rule

This class models a GeoServer access control list layer rule

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer access control list layer rule

## Details

Geoserver REST API Access Control List Layer Rule

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\>
[`geosapi::GSRule`](https://eblondel.github.io/geosapi/reference/GSRule.md)
-\> `GSLayerRule`

## Public fields

- `roles`:

  one or more roles

## Methods

### Public methods

- [`GSLayerRule$new()`](#method-GSLayerRule-new)

- [`GSLayerRule$clone()`](#method-GSLayerRule-clone)

Inherited methods

- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)
- [`geosapi::GSRule$decode()`](https://eblondel.github.io/geosapi/reference/GSRule.html#method-decode)
- [`geosapi::GSRule$encode()`](https://eblondel.github.io/geosapi/reference/GSRule.html#method-encode)

------------------------------------------------------------------------

### Method `new()`

Initializes a GSLayerRule

#### Usage

    GSLayerRule$new(
      xml = NULL,
      ws = NULL,
      lyr,
      permission = c("r", "w", "a"),
      roles
    )

#### Arguments

- `xml`:

  an object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

- `ws`:

  the resource workspace. Default is `NULL`

- `lyr`:

  the target layer to which the access control should be added

- `permission`:

  the rule permission, either `r` (read), `w` (write) or `a`
  (administer)

- `roles`:

  one or more roles to add for the rule

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSLayerRule$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
