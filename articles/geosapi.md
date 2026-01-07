# geosapi User Manual

## geosapi - R Interface to GeoServer REST API

R Interface to GeoServer REST API – Allows to perform programmatically
from R

- CRUD operations (Create, Read, Update, Delete) on GeoServer resources
  including `workspace`, `namespaces`, `dataStores` `featureTypes`,
  `layers`, `styles`, `settings` (workspaces, OGC services) etc.
- Data upload to Geoserver data directory (e.g. upload shapefile)

------------------------------------------------------------------------

If you wish to sponsor geosapi, do not hesitate to [contact
me](mailto:eblondel.pro@gmail.com)

Many thanks to the following organizations that have provided fundings
for strenghtening the `geosapi` package:

[![](https://www.weadapt.org/sites/weadapt.org/files/styles/large/public/screenshot_2021-05-25_at_16.19.32_0.png?itok=iiEMf_S3)](https://unepgrid.ch/en)[![](https://www.fao.org/fileadmin/templates/family-farming-decade/images/FAO-IFAD-Logos/FAO-Logo-EN.svg)](https://www.fao.org/home/en/)

------------------------------------------------------------------------

**Table of contents**

[**1. Overview**](#package_overview)  
[**2. Package status**](#package_status)  
[**3. Credits**](#package_credits)  
[**4. User guide**](#user_guide)  
   [4.1 Installation](#install_guide)  
   [4.2 Connect to GeoServer REST API](#GSManager)  
   [**4.3 GeoServer `workspaces`**](#GSWorkspace)  
      [4.3.1 Get a (list of) `workspace(s)`](#GSWorkspace-get)  
      [4.3.2 Create a new `workspace`](#GSWorkspace-create)  
      [4.3.3 Update a new `workspace`](#GSWorkspace-update)  
      [4.3.4 Delete a new `workspace`](#GSWorkspace-delete)  
   [**4.4 GeoServer `namespaces`**](#GSNamespace)  
      [4.4.1 Get a (list of) `namespace(s)`](#GSNamespace-get)  
      [4.4.2 Create a new `namespace`](#GSNamespace-create)  
      [4.4.3 Update a new `namespace`](#GSNamespace-update)  
      [4.4.4 Delete a new `namespace`](#GSNamespace-delete)  
   [**4.5 Manage vector data in GeoServer**](#vectordata)  
      [**4.5.1 GeoServer `dataStores`**](#GSDataStore)  
         [4.5.1.1 Get a (list of) `dataStore(s)`](#GSDataStore-get)  
         [4.5.1.2 Create a new `dataStore`](#GSDataStore-create)  
            [4.5.1.2.1 Create a **Shapefile**
`dataStore`](#GSShapefileDataStore-create)  
            [4.5.1.2.2 Create a **Shapefiles Directory**
`dataStore`](#GSShapefileDirectoryDataStore-create)  
            [4.5.1.2.3 Create a **GeoPackage**
`dataStore`](#GSGeoPackageDataStore-create)  
         [4.5.1.3 Update a new `dataStore`](#GSDataStore-update)  
         [4.5.1.4 Delete a new `dataStore`](#GSDataStore-delete)  
      [**4.5.2 Upload features/vector data**](#GSFeatureType-upload)  
      [**4.5.3 GeoServer `featureTypes`**](#GSFeatureType)  
         [4.5.3.1 Get a (list of)
`featureType(s)`](#GSFeatureType-get)  
         [4.5.3.2 Create a new `featureType`](#GSFeatureType-create)  
         [4.5.3.3 Update a new `featureType`](#GSFeatureType-update)  
         [4.5.3.4 Delete a new `featureType`](#GSFeatureType-delete)  
      [**4.5.3 GeoServer `layers`**](#GSLayer)  
         [4.5.4.1 Get a (list of) `layer(s)`](#GSLayer-get)  
         [4.5.4.2 Create a new `layer`](#GSLayer-create)  
         [4.5.4.3 Update a new `layer`](#GSLayer-update)  
         [4.5.4.4 Delete a new `layer`](#GSLayer-delete)  
      [**4.5.5 Publication of GeoServer feature
layer**](#publishFeatureLayer)  
         [4.5.5.1 Publish Geoserver feature
layer](#publishFeatureLayer-publish)  
         [4.5.5.2 Unpublish Geoserver feature
layer](#publishFeatureLayer-unpublish)  
      [**4.5.6 GeoServer `layer groups`**](#GSLayerGroup)  
         [4.5.6.1 Get a (list of) `layer group(s)`](#GSLayerGroup-get)  
         [4.5.6.2 Create a new `layer group`](#GSLayerGroup-create)  
         [4.5.6.3 Update a new `layer group`](#GSLayerGroup-update)  
         [4.5.6.4 Delete a new `layer group`](#GSLayerGroup-delete)  
   [**4.6 Manage raster data in GeoServer**](#rasterdata)  
      [**4.6.1 GeoServer `coveragestores`**](#GSCoverageStore)  
         [4.6.1.1 Get a (list of)
`coveragestore(s)`](#GSCoverageStore-get)  
         [4.6.1.2 Create a new
`coveragestore`](#GSCoverageStore-create)  
            [4.6.1.2.1 Create a **GeoTIFF**
`coveragestore`](#GSGeoTIFFCoverageStore-create)  
            [4.6.1.2.2 Create a **WorldImage**
`coveragestore`](#GSWorldImageCoverageStore-create)  
            [4.6.1.2.3 Create a **ArcGrid**
`coveragestore`](#GSArcGridCoverageStore-create)  
            [4.6.1.2.4 Create a **ImageMosaic**
`coveragestore`](#GSImageMosaicCoverageStore-create)  
         [4.6.1.3 Update a new
`coveragestore`](#GSCoverageStore-update)  
         [4.6.1.4 Delete a new
`coveragetore`](#GSCoverageStore-delete)  
      [**4.6.2 Upload coverage/raster data**](#GSCoverage-upload)  
      [**4.6.3 GeoServer `coverages`**](#GSCoverage)  
         [4.6.3.1 Get a (list of) `coverage(s)`](#GSCoverage-get)  
         [4.6.3.2 Create a new `coverage`](#GSCoverage-create)  
         [4.6.3.3 Update a new `coverage`](#GSCoverage-update)  
         [4.6.3.4 Delete a new `coverage`](#GSCoverage-delete)  
   [**4.7 Manage styles in GeoServer**](#styles)  
      [4.7.1 Get a (list of) `style(s)`](#GSStyle-get)  
      [4.7.2 Create a new `style`](#GSStyle-create)  
      [4.7.3 Update a new `style`](#GSStyle-update)  
      [4.7.4 Delete a new `style`](#GSStyle-delete)  
   [**4.8 Manage workspace settings in
GeoServer**](#settings_workspaces)  
      [4.8.1 Create a workspace settings](#GSWorkspaceSettings-create)  
      [4.8.2 Get a workspace settings](#GSWorkspaceSettings-get)  
      [4.8.3 Update a workspace settings](#GSWorkspaceSettings-update)  
      [4.8.4 Delete a workspace settings](#GSWorkspaceSettings-delete)  
   [**4.9 Manage OGC service (WMS/WFS/WCS) settings in
GeoServer**](#settings_services)  
      [4.9.1 Get an OGC service (WMS/WFS/WCS)
settings](#GSServiceSettings-get)  
      [4.9.2 Update an OGC service (WMS/WFS/WCS)
settings](#GSServiceSettings-update)  
      [4.9.3 Enable/Disable an OGC service
(WMS/WFS/WCS)](#GSServiceSettings-enable)  
[**5. Issue reporting**](#package_issues)  

#### 1. Overview and vision

------------------------------------------------------------------------

Until now, equivalent tools were existing for other programming
languages (e.g. Java, Python) but not in R.
[geosapi](https://github.com/eblondel/geosapi) intends to provide R
native interface to the GeoServer REST API, in order to facilitate
publication of geographic data resources from R to
[GeoServer](https://geoserver.org/).

#### 2. Development status

------------------------------------------------------------------------

Published on CRAN

#### 3. Credits

------------------------------------------------------------------------

3.  2016, Emmanuel Blondel

Package distributed under MIT license.

If you use `geosapi`, i would be very grateful if you can add a citation
in your published work. By citing `geosapi`, beyond acknowledging the
work, you contribute to make it more visible and guarantee its growing
and sustainability. You can get the preferred citation by running
`citation("geosapi)` in R.

You can reference `geosapi` through its DOI:
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1184895.svg)](https://doi.org/10.5281/zenodo.1184895)

#### 4. User guide

------------------------------------------------------------------------

##### 4.1 How to install geosapi in R

For now, the package can be installed from Github

``` r
install.packages("remotes")
```

Once the devtools package loaded, you can use the install_github to
install `geosapi. By default, package will be installed from`master\`\`
which is the current version in development (likely to be unstable).

``` r
remotes::install_github("eblondel/geosapi")
```

##### 4.2 Connect to GeoServer REST API

The main entry point of `geosapi` is the `GSManager`. To configure it,
enter the following line, specifying the base `URL` of your GeoServer,
and your credentials:

``` r
gsman <- GSManager$new(
    url = "http://localhost:8080/geoserver", #baseUrl of the Geoserver
    user = "admin", pwd = "geoserver", #credentials
    logger = NULL #logger, for info or debugging purpose
)
```

By default, the `geosapi` **logger** is deactivated. To enable the
logger, specify the level of log you wish as parameter of the above R
code. Two logging levels are available:

- `INFO`: will print the `geosapi` logs. Three types of messages can be
  distinguished: `INFO`, `WARN`, `ERROR`. The latter is generally
  associated with a `stop` and indicate an blocking error for the R
  method executed.
- `DEBUG` will print the above `geosapi` logs, and report all logs from
  HTTP requests performed with `cURL`

The `GSManager` inherits all methods of resource dependent managers, to
provide the users with a single R interface to GeoServer REST API
operations. In addition, the `GSManager` allows accessing the different
resource managers through specific methods. The following `managers` are
available: \* `GSNamespaceManager`: Manage `namespaces` \*
`GSWorkspaceManager`: Manage `workspaces` \* `GSDataStoreManager`:
Manage `dataStores`

##### 4.3 Manipulate GeoServer `workspaces`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/workspaces.html>

###### 4.3.1 Get a (list of) `workspace(s)`

``` r
  #get workspace objects
  wslist <- gsman$getWorkspaces()

  #get workspace names only
  wsnames <- gsman$getWorkspaceNames()

  #get workspace by name
  ws <- gsman$getWorkspace("topp")
```

###### 4.3.2 Create a new `workspace`

``` r
  created <- gsman$createWorkspace("geosapi", "http://geoapi")
```

###### 4.3.3 Update an existing `workspace`

``` r
  updated <- gsman$updateWorkspace("geosapi", "http://newgeoapi")
```

###### 4.3.4 Delete an existing `workspace`

``` r
  deleted <- gsman$deleteWorkspace("geosapi", recurse = TRUE)
```

The `recurse` parameter allows to delete all layers published under the
deleted workspace.

##### 4.4 Manipulate GeoServer `namespaces`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/namespaces.html>

###### 4.4.1 Get a (list of) `namespace(s)`

``` r
  #get namespace objects
  nslist <- gsman$getNamespaces()

  #get namespace names only
  nsnames <- gsman$getNamespaceNames()

  #get namespace by name
  ns <- gsman$getNamespace("topp")
```

###### 4.4.2 Create a new `namespace`

``` r
  created <- gsman$createNamespace("geosapi", "http://geoapi")
```

###### 4.4.3 Update an existing `namespace`

``` r
  updated <- gsman$updateNamespace("geosapi", "http://newgeoapi")
```

###### 4.4.4 Delete an existing `namespace`

``` r
  deleted <- gsman$deleteNamespace("geosapi", recurse = TRUE)
```

The `recurse` parameter allows to delete all layers published under the
deleted namespace.

##### 4.5 Manage **vector data** with GeoServer

###### 4.5.1 Manipulate GeoServer `dataStores`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/datastores.html>

###### 4.5.1.1 Get a (list of) `dataStore(s)`

``` r
  #get datastore objects
  dslist <- gsman$getDataStores("topp")

  #get datastore names only
  dsnames <- gsman$getDataStoreNames("topp")

  #get datastore by name
  ns <- gsman$getDataStore("topp", "states_shapefile")
```

###### 4.5.1.2 Create a new `dataStore`

- 4.5.1.2.1 Create a **Shapefile** `dataStore`

``` r
  ds = GSShapefileDataStore$new(dataStore="topp_datastore",
                                description = "topp_datastore description",
                                enabled = TRUE,
                                url = "file:data/shapefiles/states.shp")
  created <- gsman$createDataStore("topp", ds)
```

- 4.5.1.2.2 Create a **Shapefiles Directory** `dataStore`

``` r
  ds = GSShapefileDirectoryDataStore$new(dataStore="topp_datastore",
                                description = "topp_datastore description",
                                enabled = TRUE,
                                url = "file:data/shapefiles")
  created <- gsman$createDataStore("topp", ds)
```

- 4.5.1.2.3 Create a **GeoPackage** `dataStore`

``` r
  ds = GSGeoPackageDataStore$new(dataStore="topp_datastore",
                                description = "topp_datastore description",
                                enabled = TRUE,
                                database = "file:data/somefile.gpkg")
  created <- gsman$createDataStore("topp", ds)
```

###### 4.5.1.3 Update an existing `dataStore`

``` r
  dataStore <- gsman$getDataStore("topp", "topp_datastore")
  dataStore$setDescription("topp_datastore updated description")
  dataStore$setEnabled(FALSE)
  
  updated <- gsman$updateDataStore("topp", dataStore)
```

###### 4.5.1.4 Delete an existing `dataStore`

``` r
  deleted <- gsman$deleteDataStore("topp", "topp_datastore", recurse = TRUE)
```

The `recurse` parameter allows to delete all layers published under the
deleted datastore.

###### 4.5.2 Upload features/vector data

The `geosapi` offers methods to upload vector data to configured
`datastores`. A generic method `gsman$uploadData` allows to upload any
kind of data type supported by GeoServer, by specifying the file
extension. To upload data, several parameters have to be specified
including: \* `ws`: the workspace in which the datastore is configured
\* `ds`: the datastore in which data has to be uploaded \* `endpoint`:
choice among `file` (use a local file content as body), `url` (use a
file URL), or `external` (path to a file). Important note: So far only
`file` was tested and is supported. \* `extension`: the data file
extension \* `configure`: either `none` (upload only, with no
featuretype/layer configured by default), `first` (upload and configure
featuretype/layer over the uploaded vector data) \* `update`: update
strategy, either `append` (upload that will fails in case data was
already uploaded), or `overwrite` (overwrite the already uploaded data
if existing) \* `filename`: filename of the data resource to upload \*
`charset`: character set of the data resource \* \`contentType: data
content type

To simplify the upload, several data-specific methods were designed
targeting specific data file extensions. These methods share the same
parameters as above except the `extension` and `contentType` that will
be pre-set according to the data upload format: \* `uploadShapefile`:
upload a shapefile \* `uploadProperties`: upload a properties file \*
`uploadH2`: upload a H2 database \* `uploadSpatialite`: upload a
spatialite file \* `uploadAppSchema`: upload an app schema \*
`uploadGeoPackage`: upload an OGC GeoPackage

Example with an OGC Geopackage upload

``` r
  uploaded <- gsman$uploadGeoPackage(
    ws = "my_workspace", ds = "my_gpkg_datastore",
    endpoint = "file", configure = "first", update = "overwrite",
    charset = "UTF-8", filename = "myfile.gpkg"
  )
```

###### 4.5.3 Manipulate GeoServer `featureType`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/featuretypes.html>

###### 4.5.3.1 Get a (list of) `featureType(s)`

``` r
  #get featureType objects
  ftlist <- gsman$getFeatureTypes("topp", "taz_shapes")

  #get featureType names only
  ftnames <- gsman$getFeatureTypeNames()

  #get featureType by name
  ft <- gsman$getFeatureType("topp", "taz_shapes", "tasmania_cities")
```

###### 4.5.3.2 Create a new `featureType`

``` r
  #create featuretype object
  featureType <- GSFeatureType$new()
  featureType$setName("tasmania_cities2")
  featureType$setNativeName("tasmania_cities")
  featureType$setAbstract("abstract")
  featureType$setTitle("title")
  featureType$setSrs("EPSG:4326")
  featureType$setNativeCRS("EPSG:4326")
  featureType$setEnabled(TRUE)
  featureType$setProjectionPolicy("REPROJECT_TO_DECLARED")
  featureType$setLatLonBoundingBox(-180,-90,180,90, crs = "EPSG:4326")
  featureType$setNativeBoundingBox(-180,-90,180,90, crs ="EPSG:4326") 
  
  md1 <- GSMetadataLink$new(type = "text/xml", metadataType = "ISO19115:2003", content = "http://somelink.org/xml")
  featureType$addMetadataLink(md1)
  md2 <- GSMetadataLink$new(type = "text/html", metadataType = "ISO19115:2003", content = "http://somelink.org/html")
  featureType$addMetadataLink(md2)

  #create the feature type in GeoServer
  created <- gsman$createFeatureType("topp", "taz_shapes", featureType)
```

**How to set a Geoserver SQL View**

With `geosapi`, it is also possible to configure a Geoserver SQL View,
possibly with dynamic parameters. For this, GeoServer uses the concept
of *VirtualTable*. The code below explains how to configure such virtual
table with `geosapi`:

``` r

##virtual table
vt <- GSVirtualTable$new()
vt$setName("view name")
vt$setSql("select * from mydataset where flag = '%flag%' and year between %start_year% and %end_year%")

## incase of spatial virtual table, specify the geometry column name, type and SRID
vtg <- GSVirtualTableGeometry$new(name = "the_geom", type = "MultiPolygon", srid = 4326)
vt$setGeometry(vtg)

##in case of dynamic parameters handled in your sql (bound with %)
vtp1 <- GSVirtualTableParameter$new(name = "flag", defaultValue = "FRA", regexpValidator = "^[\\w\\d\\s]+$")
vtp2 <- GSVirtualTableParameter$new(name = "start_year", defaultValue = "2000",regexpValidator = "^[\\d]+$")
vtp3 <- GSVirtualTableParameter$new(name = "end_year", defaultValue = "2010",regexpValidator = "^[\\d]+$")
vt$addParameter(vtp1)
vt$addParameter(vtp2)
vt$addParameter(vtp3)

##add virtual table to featureType
featureType$setVirtualTable(vt)
```

###### 4.5.3.3 Update an existing `featureType`

``` r
  #fetch featureType and update some properties
  featureType <- gsman$getFeatureType("topp", "taz_shapes", "tasmania_cities2")
  featureType$setAbstract("abstract updated")
  featureType$setEnabled(FALSE)
  
  #update featureType in GeoServer
  updated <- gsman$updateFeatureType("topp", "taz_shapes", featureType)
```

###### 4.5.3.4 Delete an existing `featureType`

``` r
  deleted <- gsman$deleteFeatureType("topp", "taz_shapes", "tasmania_cities2", recurse = TRUE)
```

The `recurse` parameter allows to delete the layer published for the
deleted featureType.

###### 4.5.4 Manipulate GeoServer `layers`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/layers.html>

###### 4.5.4.1 Get a (list of) `layer(s)`

``` r
  #get layer objects
  layers <- gsman$getLayers()

  #get layer names only
  layerNames <- gsman$getLayerNames()

  #get layer by name
  layer <- gsman$getLayer("tasmania_cities")
```

###### 4.5.4.2 Create a new `layer`

This method shows how to *publish* a created `featureType` (as created
in [4.5.3 Create a new
`FeatureType`](https://github.com/eblondel/geosapi/wiki#GSFeatureType-create))

``` r
  layer <- GSLayer$new()
  layer$setName("tasmania_cities2")
  layer$setDefaultStyle("capitals")
  layer$addStyle("generic")
  created <- gsman$createLayer(layer)
```

###### 4.5.4.3 Update an existing `layer`

``` r
  lyr <- gsman$getLayer("tasmania_cities")
  lyr$setDefaultStyle("generic")
  updated <- gsman$updateLayer(lyr)
```

###### 4.5.4.4 Delete an existing `layer`

``` r
  deleted <- gsman$deleteLayer("tasmania_cities2")
```

###### 4.5.5 Publication of GeoServer feature layer

GeoServer manages feature data layers by means of two different types of
resources: the `featureType` and the `layer`. When created, the latter
will *publish* the former. Hence, in order to **publish** a complete
feature data layer, two GeoServer resources should be created. The below
methods allow the user to do both creation through a **single** method.
To distinguish them from the above API methods and avoid confusion, we
don’t use the terminology **create** / **delete** but **publish** /
**unpublish**.

###### 4.5.5.1 Publish Geoserver feature layer

The method `publishLayer` will sequentially do two requests to
GeoServer:

- Create `featureType`
- Create `layer`

``` r
  #create featuretype
  featureType <- GSFeatureType$new()
  featureType$setName("tasmania_cities2")
  featureType$setNativeName("tasmania_cities")
  featureType$setAbstract("abstract")
  featureType$setTitle("title")
  featureType$setSrs("EPSG:4326")
  featureType$setNativeCRS("EPSG:4326")
  featureType$setEnabled(TRUE)
  featureType$setProjectionPolicy("REPROJECT_TO_DECLARED")
  featureType$setLatLonBoundingBox(-180,-90,180,90, crs = "EPSG:4326")
  featureType$setNativeBoundingBox(-180,-90,180,90, crs ="EPSG:4326") 
  md1 <- GSMetadataLink$new(type = "text/xml", metadataType = "ISO19115:2003", content = "http://somelink.org/xml")
  featureType$addMetadataLink(md1)
  md2 <- GSMetadataLink$new(type = "text/html", metadataType = "ISO19115:2003", content = "http://somelink.org/html")
  featureType$addMetadataLink(md2)
  
  #create layer
  layer <- GSLayer$new()
  layer$setName("tasmania_cities2")
  layer$setDefaultStyle("capitals")
  layer$addStyle("generic")
  
  #try to publish the complete layer (featuretype + layer)
  published <- gsman$publishLayer("topp", "taz_shapes", featureType, layer)
```

###### 4.5.5.2 Unpublish Geoserver feature layer

The method `publishLayer` will sequentially do two requests to
GeoServer:

- Delete `layer`
- Delete `featureType`

``` r
  #try to unpublish the complete layer (featuretype + layer)
  published <- gsman$unpublishLayer("topp", "taz_shapes", "tasmania_cities2")
```

###### 4.5.6 Manipulate GeoServer `layer groups`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/layergroups.html>

###### 4.5.6.1 Get a (list of) `layer group(s)`

``` r
  #get layer groups objects
  layerGroups <- gsman$getLayerGroups()

  #get layer group names only
  layerGroupNames <- gsman$getLayerGroupNames()

  #get layer group by name
  layerGroup <- gsman$getLayerGroup("test_layergroup")
```

###### 4.5.6.2 Create a new `layer group`

``` r
  lyr <- GSLayerGroup$new()
  lyr$setName("test_layergroup")
  lyr$setTitle("title")
  lyr$setAbstract("abstract")
  lyr$setMode("SINGLE")
  lyr$addLayer(layer = "tasmania_cities", style = "generic")
  lyr$setBounds(-180,-90,180,90,crs = "EPSG:4326")
  gsman$createLayerGroup(layerGroup = lyr)
```

###### 4.5.6.3 Update an existing `layer group`

``` r
  lyr <- GSLayerGroup$new()
  lyr$setName("test_layergroup")
  lyr$setTitle("title")
  lyr$setAbstract("abstract 2")
  lyr$setMode("SINGLE")
  lyr$addLayer(layer = "tasmania_cities", style = "generic")
  lyr$setBounds(-180,-90,180,90,crs = "EPSG:4326")
  gsman$updateLayerGroup(layerGroup = lyr)
```

###### 4.5.6.4 Delete an existing `layer group`

``` r
  deleted <- gsman$deleteLayerGroup("test_layergroup")
```

##### 4.6. Manage **raster data** with GeoServer

###### 4.6.1 Manipulate GeoServer `coveragestores`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/coveragestores.html>

###### 4.6.1.1 Get a (list of) `coveragestore(s)`

``` r
  #get coveragestore objects
  cslist <- gsman$getCoverageStores("nurc")

  #get coveragestore names only
  csnames <- gsman$getCoverageStoreNames("nurc")

  #get coveragestore by name
  cs <- gsman$getCoverageStore("nurc", "mosaic")
```

###### 4.6.1.2 Create a new `coveragetore`

- 4.6.1.2.1 Create a **GeoTIFF** `coveragestore`

``` r
  cs = GSGeoTIFFCoverageStore$new(name="sfdem_new", description = "sfdem_new description", enabled = TRUE)
  created <- gsman$createCoverageStore("sf", cs)
```

- 4.6.1.2.2 Create a **WorldImage** `coveragestore`

``` r
  cs = GSWorldImageCoverageStore$new(name="sfdem_new", description = "sfdem_new description", enabled = TRUE)
  created <- gsman$createCoverageStore("sf", cs)
```

- 4.6.1.2.3 Create a **ArcGrid** `coveragestore`

``` r
  cs = GSArcGridCoverageStore$new(name="sfdem_new", description = "sfdem_new description", enabled = TRUE)
  created <- gsman$createCoverageStore("sf", cs)
```

- 4.6.1.2.4 Create a **ImageMosaic** `coveragestore`

``` r
  cs = GSImageMosaicCoverageStore$new(name="sfdem_new", description = "sfdem_new description", enabled = TRUE)
  created <- gsman$createCoverageStore("sf", cs)
```

###### 4.6.1.3 Update an existing `coveragestore`

``` r
  cs <- gsman$getCoverageStore("sf", "sfdem")
  cs$setDescription("sfdem updated description")
  cs$setEnabled(FALSE)
  
  updated <- gsman$updateCoverageStore("sf", cs)
```

###### 4.6.1.4 Delete an existing `coveragestore`

``` r
  deleted <- gsman$deleteCoverageStore("sf", "sfdem", recurse = TRUE)
```

The `recurse` parameter allows to delete all coverages published under
the deleted coveragestore.

###### 4.6.2 Upload coverage/raster data

The `geosapi` offers methods to upload coverage data to configured
`coveragestores`. A generic method `gsman$uploadCoverage` allows to
upload any kind of coverage data type supported by GeoServer, by
specifying the file extension. To upload data, several parameters have
to be specified including: \* `ws`: the workspace in which the datastore
is configured \* `ds`: the datastore in which data has to be uploaded \*
`endpoint`: choice among `file` (use a local file content as body),
`url` (use a file URL), or `external` (path to a file). Important note:
So far only `file` was tested and is supported. \* `extension`: the data
file extension \* `configure`: either `none` (upload only, with no
coverage/layer configured by default), `first` (upload and configure
coverae/layer over the uploaded data) \* `update`: update strategy,
either `append` (upload that will fails in case data was already
uploaded), or `overwrite` (overwrite the already uploaded data if
existing) \* `filename`: filename of the data resource to upload \*
`charset`: character set of the data resource \* \`contentType: data
content type

To simplify the upload, several coverage-specific methods were designed
targeting specific data file extensions. These methods share the same
parameters as above except the `extension` and `contentType` that will
be pre-set according to the data upload format: \* `uploadGeoTIFF`:
upload a GeoTIFF file \* `uploadWorldImage`: upload a WorldImage file \*
`uploadArcGrid`: upload an ArcGrid file \* `uploadImageMosaic`: upload
an ImageMosaic

Example with a GeoTIFF upload

``` r
  uploaded <- gsman$uploadGeoTIFF(
    ws = "sf", cs = "sfdem_new",
    endpoint = "file", configure = "none", update = "overwrite",
    filename = system.file("extdata/sfdem_new.tif", package = "geosapi")
  )
```

###### 4.6.3 Manipulate GeoServer `coverages`

> **GeoServer API doc**:
> <https://docs.geoserver.org/stable/en/user/rest/api/coverages.html>

###### 4.6.3.1 Get a (list of) `coverage(s)`

``` r
  #get coverage objects
  covlist <- gsman$getCoverages("sf", "sfdem")

  #get coverage names only
  covnames <- gsman$getCoverageNames("sf", "sfdem")

  #get coverage by name
  cov <- gsman$getCoverage("sf", "sfdem", "sfdem")
```

###### 4.6.3.2 Create a new `coverage`

``` r
  #create coverage object
  cov <- GSCoverage$new()
  cov$setName("sfdem_new")
  cov$setNativeName("sfdem_new")
  cov$setTitle("Title for sfdem")
  cov$setDescription("Description for sfdem")
  cov$addKeyword("sfdem keyword1")
  cov$addKeyword("sfdem keyword2")
  cov$addKeyword("sfdem keyword3")
  
  md1 <- GSMetadataLink$new(
    type = "text/xml",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/sfdem_new/xml"
  )
  cov$addMetadataLink(md1)
  md2 <- GSMetadataLink$new(
    type = "text/html",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/sfdem_new/html"
  )
  cov$addMetadataLink(md2)
  
  cov$setSrs("EPSG:4326")
  cov$setNativeCRS("EPSG:26713")
  cov$setLatLonBoundingBox(-103.87108701853181, 44.370187074132616, -103.62940739432703, 44.5016011535299, crs = "EPSG:4326")
  cov$setNativeBoundingBox(589980, 4913700, 609000, 4928010, crs = "EPSG:26713")
  
  created <- gsman$createCoverage(ws = "sf", cs = "sfdem_new", coverage = cov)
```

**How to set a Geoserver Coverage View**

With `geosapi`, it is also possible to configure a Geoserver Coverage
View. For this, GeoServer uses the concept of *CoverageView*. The code
below explains how to configure such coverage view with `geosapi`:

``` r

  ##coverage view
  coview <- GSCoverageView$new()
  coview$setName("sfdem_new")
  coview$setEnvelopeCompositionType("INTERSECTION")
  coview$setSelectedResolution("BEST")
  coview$setSelectedResolutionIndex(-1)
  coviewband <- GSCoverageBand$new()
  coviewband$setDefinition("sfdem_new@0")
  coviewband$setIndex(0)
  coviewband$addInputBand(GSInputCoverageBand$new( coverageName = "sfdem_new", band = 0))
  coview$addBand(coviewband)

  ##add coverage view to coverage
  cov$setView(coview)
```

###### 4.6.3.3 Update an existing `coverage`

``` r
  #fetch coverage and update some properties
  cov <- gsman$getCoverage("sf", "sfdem", "sfdem")
  cov$setAbstract("abstract updated")
  cov$setEnabled(FALSE)
  
  #update coverage in GeoServer
  updated <- gsman$updateCoverage("sf", "sfdem", cov)
```

###### 4.6.3.4 Delete an existing `coverage`

``` r
  deleted <- gsman$deleteCoverage("sf", "sfdem", "sfdem", recurse = TRUE)
```

The `recurse` parameter allows to delete the layer published for the
deleted featureType.

##### 4.7. Manage **styles** with GeoServer

###### 4.7.1 Get a (list of) `style`(s)

``` r
  styles <- gsman$getStyles()
  stylenames <- gsman$getStyleNames()
  style <- gsman$getStyle("capitals")
```

From GeoServer 2.2, it is also possible to get the content of a style,
ie the SLD body:

``` r
  sld <- gsman$getSLDBody("capitals")
```

###### 4.7.2 Create a new `style`

``` r
  sldFile <- system.file("extdata", "mystyle.sld", package = "geosapi") #to use 'file' argument of gsman$createStyle
  sldStyle <- xmlParse(sldFile) #to use 'sldBody' argument of gsman$createStyle
  created <- gsman$createStyle(file = sldFile, name = "mystyle")
```

###### 4.7.3 Update a new `style`

``` r
  sldFile2 <- system.file("extdata", "mystyle2.sld", package = "geosapi") #to use 'file' argument of gsman$updateStyle
  sldStyle2 <- xmlParse(sldFile2) #to use 'sldBody' argument of gsman$updateStyle
  updated <- gsman$updateStyle(sldBody = sldStyle2, name = "mystyle")
```

###### 4.7.4 Delete an existing `style`

``` r
  deleted <- gsman$deleteStyle("mystyle", recurse = TRUE, purge = TRUE)
```

All methods describe here above also support a `ws` argument where a
workspace can be specified.

##### 4.8. Manage **workspace settings** with GeoServer

Geoserver allows to activate settings by workspace. In such case, this
will overwrite the global Geoserver settings. Activating these settings
is required to set-up specific OGC service capabilities par workspace
(see next section).

###### 4.8.1 Create a workspace settings

Creating a workspace settings is equivalent to check the “Enabled”
checkbox in the *Settings* section of a workspace edition page in the
GeoServer UI. To create it (assuming a workspace named `geosapi`), run
the following code:

``` r
settings <- GSWorkspaceSettings$new()
settings$setNumDecimals(5) #custom number of decimals for data published in this workspace
created <- gsman$createWorkspaceSettings("geosapi", settings)
```

###### 4.8.2 Get a workspace settings

To get a workspace settings, use the following code:

``` r
geosapi_settings <- gsman$getWorkspaceSettings("geosapi")
```

This method can be used in view of updating a workspace settings.

###### 4.8.3 Update a workspace settings

Similar method can be used for updating the workspace configuration:

``` r
settings <- gsman$getWorkspaceSettings("geosapi")
settings$setNumDecimals(9) #change number of decimals
created <- gsman$updateWorkspaceSettings("geosapi", settings)
```

###### 4.8.4 Delete a workspace settings

The settings can be deleted (equivalent of unchecking the “Enabled”
checkbox in a workspace settings section):

``` r
deleted <- gsman$deleteWorkspaceSettings("geosapi")
```

##### 4.9 Manage OGC Service (WMS/WFS/WCS) settings with GeoServer

###### 4.9.1 Get an OGC service (WMS/WFS/WCS) settings

To get an OGC service settings (global, or workspace specific), geosapi
offers a generic method that can be used as follows:

``` r
#get WMS global settings
wms_global_settings <- gsman$getServiceSettings(service = "WMS")

#get WMS geosapi settings
wms_geosapi_settings <- gsman$getServiceSettings(service = "WMS", ws = "geosapi")
```

Shortcut methods can also be used as follow:

``` r
#get WMS global settings
wms_global_settings <- gsman$getWmsSettings()

#get WMS geosapi settings
wms_geosapi_settings <- gsman$getWmsSettings(ws = "geosapi")
```

Analog methods are available for WFS and WCS.

###### 4.9.2 Update an OGC service (WMS/WFS/WCS) settings

OGC service settings can be updated, for example to activate/deactivate
the service and fill minimum metadata (name, title, abstract). The
following examples shows how to do update WMS global configuration and
by workspace:

- Update the WMS global configuration:

``` r
wmsSettings <- gsman$getWmsSettings()
wmsSettings$setTitle("Tile for my global WMS")
updated <- gsman$updateServiceSettings(wmsSettings, service = "WMS")
```

Shortcut update methods are also available. The last code line above can
be replaced by:

``` r
updated <- gsman$updateWmsSettings(wmsSettings)
```

- Update WMS workspace configuration

``` r
wmsSettings <- GSServiceSettings$new(service = "WMS")
wmsSettings$setTitle("Tile for my workspace WMS")
wmsSettings$setAbstract("This WMS is set-up specifically for the workspace geosapi")
updated <- gsman$updateServiceSettings(wmsSettings, service = "WMS", ws = "geosapi")
```

The last code line above could be replaced by the shortcut method:

`updated <- gsman$updateWmsSettings(wmsSettings, ws = "geosapi")`

###### 4.9.3 Enable/Disable an OGC service (WMS/WFS/WCS)

To make OGC service enabling/disabling easier for users, additional
shortcut methods were set-up in geosapi. The following code examples
show you how to enable/disable WMS/WFS/WCS

- Enable/Disable Global OGC services

&nbsp;

    #disable global WMS
    gsman$disableWMS()
    #enable global WFS and WCS
    gsman$enableWFS()
    gsman$enableWCS()

- Enable/Disable OGC services at workspace level

``` r
#activates WMS for workspace 'geosapi'
enabled <- gsman$enableWMS("geosapi")

#deactivates WMS for workspace 'geosapi'
disabled <- gsman$disableWMS("geosapi")
```

Analog functions are available for WFS and WCS:

    #enable WFS and WCS for geosapi workspace
    gsman$enableWFS("geosapi")
    gsman$enableWCS("geosapi")

    #disable WFS and WCS for geosapi workspace
    gsman$disableWFS("geosapi")
    gsman$disableWCS("geosapi")

#### 5. Issue reporting

------------------------------------------------------------------------

Issues can be reported at <https://github.com/eblondel/geosapi/issues>
