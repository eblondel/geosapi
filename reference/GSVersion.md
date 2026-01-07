# A GeoServer version

This class allows to grab the GeoServer version. By default, a tentative
is made to fetch version from web admin default page, since Geoserver
REST API did not support GET operation for the Geoserver version in past
releases of Geoserver.

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer version

## Details

Geoserver REST API - Geoserver Version

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Public fields

- `version`:

  version

- `value`:

  value

## Methods

### Public methods

- [`GSVersion$new()`](#method-GSVersion-new)

- [`GSVersion$lowerThan()`](#method-GSVersion-lowerThan)

- [`GSVersion$greaterThan()`](#method-GSVersion-greaterThan)

- [`GSVersion$equalTo()`](#method-GSVersion-equalTo)

- [`GSVersion$clone()`](#method-GSVersion-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSVersion

#### Usage

    GSVersion$new(url, user, pwd)

#### Arguments

- `url`:

  url

- `user`:

  user

- `pwd`:

  pwd

------------------------------------------------------------------------

### Method `lowerThan()`

Compares to a version and returns TRUE if it is lower, FALSE otherwise

#### Usage

    GSVersion$lowerThan(version)

#### Arguments

- `version`:

  version

#### Returns

`TRUE` if lower, `FALSE` otherwise

------------------------------------------------------------------------

### Method `greaterThan()`

Compares to a version and returns TRUE if it is greater, FALSE otherwise

#### Usage

    GSVersion$greaterThan(version)

#### Arguments

- `version`:

  version

#### Returns

`TRUE` if greater, `FALSE` otherwise

------------------------------------------------------------------------

### Method `equalTo()`

Compares to a version and returns TRUE if it is equal, FALSE otherwise

#### Usage

    GSVersion$equalTo(version)

#### Arguments

- `version`:

  version

#### Returns

`TRUE` if equal, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSVersion$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
version <- GSVersion$new(
             url = "http://localhost:8080/geoserver",
             user = "admin", pwd = "geoserver"
           )
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
# }
```
