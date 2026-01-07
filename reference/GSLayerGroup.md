# A GeoServer layergroup resource

This class models a GeoServer layer group. This class is to be used for
clustering layers into a group.

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a GeoServer layergroup

## Details

Geoserver REST API LayerGroup

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`geosapi::GSRESTResource`](https://eblondel.github.io/geosapi/reference/GSRESTResource.md)
-\> `GSLayerGroup`

## Public fields

- `full`:

  full

- `name`:

  name

- `mode`:

  mode

- `title`:

  title

- `abstractTxt`:

  abstract

- `workspace`:

  workspace

- `publishables`:

  publishables

- `styles`:

  styles

- `metadataLinks`:

  metadata links

- `bounds`:

  bounds

## Methods

### Public methods

- [`GSLayerGroup$new()`](#method-GSLayerGroup-new)

- [`GSLayerGroup$decode()`](#method-GSLayerGroup-decode)

- [`GSLayerGroup$setName()`](#method-GSLayerGroup-setName)

- [`GSLayerGroup$setMode()`](#method-GSLayerGroup-setMode)

- [`GSLayerGroup$setTitle()`](#method-GSLayerGroup-setTitle)

- [`GSLayerGroup$setAbstract()`](#method-GSLayerGroup-setAbstract)

- [`GSLayerGroup$setWorkspace()`](#method-GSLayerGroup-setWorkspace)

- [`GSLayerGroup$addLayer()`](#method-GSLayerGroup-addLayer)

- [`GSLayerGroup$addLayerGroup()`](#method-GSLayerGroup-addLayerGroup)

- [`GSLayerGroup$addPublishable()`](#method-GSLayerGroup-addPublishable)

- [`GSLayerGroup$setStyles()`](#method-GSLayerGroup-setStyles)

- [`GSLayerGroup$addStyle()`](#method-GSLayerGroup-addStyle)

- [`GSLayerGroup$setMetadataLinks()`](#method-GSLayerGroup-setMetadataLinks)

- [`GSLayerGroup$addMetadataLink()`](#method-GSLayerGroup-addMetadataLink)

- [`GSLayerGroup$deleteMetadataLink()`](#method-GSLayerGroup-deleteMetadataLink)

- [`GSLayerGroup$setBounds()`](#method-GSLayerGroup-setBounds)

- [`GSLayerGroup$clone()`](#method-GSLayerGroup-clone)

Inherited methods

- [`geosapi::GSRESTResource$encode()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-encode)
- [`geosapi::GSRESTResource$getClassName()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-getClassName)
- [`geosapi::GSRESTResource$print()`](https://eblondel.github.io/geosapi/reference/GSRESTResource.html#method-print)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class GSLayerGroup

#### Usage

    GSLayerGroup$new(xml = NULL)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    GSLayerGroup$decode(xml)

#### Arguments

- `xml`:

  object of class
  [xml_node-class](http://xml2.r-lib.org/reference/oldclass.md)

------------------------------------------------------------------------

### Method `setName()`

Set name

#### Usage

    GSLayerGroup$setName(name)

#### Arguments

- `name`:

  name

------------------------------------------------------------------------

### Method `setMode()`

Set mode

#### Usage

    GSLayerGroup$setMode(mode)

#### Arguments

- `mode`:

  a mode value among "SINGLE", "NAMED", "CONTAINER", "EO"

------------------------------------------------------------------------

### Method `setTitle()`

Set title

#### Usage

    GSLayerGroup$setTitle(title)

#### Arguments

- `title`:

  title

------------------------------------------------------------------------

### Method `setAbstract()`

Set abstract

#### Usage

    GSLayerGroup$setAbstract(abstract)

#### Arguments

- `abstract`:

  abstract

------------------------------------------------------------------------

### Method `setWorkspace()`

Set workspace

#### Usage

    GSLayerGroup$setWorkspace(workspace)

#### Arguments

- `workspace`:

  workspace name, object of class
  [GSWorkspace](https://eblondel.github.io/geosapi/reference/GSWorkspace.md)
  or `character`

------------------------------------------------------------------------

### Method `addLayer()`

Adds layer

#### Usage

    GSLayerGroup$addLayer(layer, style)

#### Arguments

- `layer`:

  layer name

- `style`:

  style name

------------------------------------------------------------------------

### Method `addLayerGroup()`

Adds layer group

#### Usage

    GSLayerGroup$addLayerGroup(layerGroup)

#### Arguments

- `layerGroup`:

  layer group

------------------------------------------------------------------------

### Method `addPublishable()`

Adds publishable

#### Usage

    GSLayerGroup$addPublishable(publishable)

#### Arguments

- `publishable`:

  publishable

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setStyles()`

Set styles

#### Usage

    GSLayerGroup$setStyles(styles)

#### Arguments

- `styles`:

  styles

------------------------------------------------------------------------

### Method `addStyle()`

Adds a style

#### Usage

    GSLayerGroup$addStyle(style)

#### Arguments

- `style`:

  style

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setMetadataLinks()`

Set metadata links

#### Usage

    GSLayerGroup$setMetadataLinks(metadataLinks)

#### Arguments

- `metadataLinks`:

  metadata links

------------------------------------------------------------------------

### Method `addMetadataLink()`

Adds metadata link

#### Usage

    GSLayerGroup$addMetadataLink(metadataLink)

#### Arguments

- `metadataLink`:

  object of class
  [GSMetadataLink](https://eblondel.github.io/geosapi/reference/GSMetadataLink.md)

#### Returns

`TRUE` if added, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteMetadataLink()`

Deletes metadata link

#### Usage

    GSLayerGroup$deleteMetadataLink(metadataLink)

#### Arguments

- `metadataLink`:

  object of class
  [GSMetadataLink](https://eblondel.github.io/geosapi/reference/GSMetadataLink.md)

#### Returns

`TRUE` if deleted, `FALSE` otherwise

------------------------------------------------------------------------

### Method `setBounds()`

Set bounds

#### Usage

    GSLayerGroup$setBounds(minx, miny, maxx, maxy, bbox = NULL, crs)

#### Arguments

- `minx`:

  minx

- `miny`:

  miny

- `maxx`:

  maxx

- `maxy`:

  maxy

- `bbox`:

  bbox

- `crs`:

  crs

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSLayerGroup$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  lyr <- GSLayerGroup$new()
```
