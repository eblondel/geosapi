# Geoserver REST API Manager Utils

Geoserver REST API Manager Utils

Geoserver REST API Manager Utils

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
static util methods for communication with the REST API of a GeoServer
instance.

## Static methods

- `getUserAgent()`:

  This method is used to get the user agent for performing GeoServer API
  requests. Here the user agent will be compound by geosapi package name
  and version.

- `getUserToken(user, pwd)`:

  This method is used to get the user authentication token for
  performing GeoServer API requests. Token is given a Base64 encoded
  string.

- `GET(url, user, pwd, path, verbose)`:

  This method performs a GET request for a given `path` to GeoServer
  REST API

- `PUT(url, user, pwd, path, filename, contentType, verbose)`:

  This method performs a PUT request for a given `path` to GeoServer
  REST API, to upload a file of name `filename` with given `contentType`

- `POST(url, user, pwd, path, content, contentType, verbose)`:

  This method performs a POST request for a given `path` to GeoServer
  REST API, to post content of given `contentType`

- `DELETE(url, user, pwd, path, verbose)`:

  This method performs a DELETE request for a given GeoServer resource
  identified by a `path` in GeoServer REST API

- `parseResponseXML(req)`:

  Convenience method to parse XML response from GeoServer REST API.

- `getPayloadXML(obj)`:

  Convenience method to create payload XML to send to GeoServer.

- `setBbox(minx, miny, maxx, maxy, bbox, crs)`:

  Creates an list object representing a bbox. Either from coordinates or
  from a `bbox` object (matrix).

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Methods

### Public methods

- [`GSUtils$clone()`](#method-GSUtils-clone)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSUtils$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
