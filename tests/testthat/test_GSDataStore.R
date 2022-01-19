# test_GSDataStore.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSDataStore*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSDataStore")

test_that("READ dataStore",{
  expect_is(gsman,"GSManager")
  ds <- gsman$getDataStore("topp", "taz_shapes")
  expect_is(ds, "GSAbstractDataStore")
  expect_true(all(c("name", "enabled", "type", "description", "connectionParameters", "full") %in% names(ds)))
  expect_equal(ds$name, "taz_shapes")
})

test_that("READ dataStores",{
  dslist <- gsman$getDataStores("topp")
  expect_true(all(sapply(dslist, function(x){class(x)[1] == "GSAbstractDataStore"})))
  dsnames <- gsman$getDataStoreNames("topp")
  expect_true(all(dsnames %in% c("states_shapefile","taz_shapes")))
})

#Shapefile
#---------------------------------------------------------------------------

test_that("CREATE dataStore - Shapefile",{
  ds = GSShapefileDataStore$new(name = "topp_datastore",
                                description = "topp_datastore description",
                                enabled = TRUE,
                                url = "file:data/shapefiles/states.shp")
  created <- gsman$createDataStore("topp", ds)
  expect_true(created)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "GSShapefileDataStore")
  expect_equal(ds$description, "topp_datastore description")
  expect_true(ds$enabled)
})

test_that("UPDATE datastore - Shapefile",{
  dataStore <- gsman$getDataStore("topp", "topp_datastore")
  dataStore$setDescription("topp_datastore updated description")
  dataStore$setEnabled(FALSE)
  
  updated <- gsman$updateDataStore("topp", dataStore)
  expect_true(updated)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "GSShapefileDataStore")
  expect_equal(ds$description, "topp_datastore updated description")
  expect_false(ds$enabled)
})

test_that("DELETE dataStore - Shapefile",{
  deleted <- gsman$deleteDataStore("topp", "topp_datastore", TRUE)
  expect_true(deleted)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "NULL")
})

#Shapefile Directory
#---------------------------------------------------------------------------

test_that("CREATE dataStore - Directory of Shapefiles",{
  ds = GSShapefileDirectoryDataStore$new(name = "topp_datastore",
                                description = "topp_datastore description",
                                enabled = TRUE, url = "file:data/shapefiles")
  created <- gsman$createDataStore("topp", ds)
  expect_true(created)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "GSShapefileDirectoryDataStore")
  expect_equal(ds$description, "topp_datastore description")
  expect_true(ds$enabled)
})

test_that("UPDATE datastore - Directory of Shapefiles",{
  dataStore <- gsman$getDataStore("topp", "topp_datastore")
  dataStore$setDescription("topp_datastore updated description")
  dataStore$setEnabled(FALSE)
  
  updated <- gsman$updateDataStore("topp", dataStore)
  expect_true(updated)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "GSShapefileDirectoryDataStore")
  expect_equal(ds$description, "topp_datastore updated description")
  expect_false(ds$enabled)
})

test_that("DELETE dataStore - Directory of Shapefiles",{
  deleted <- gsman$deleteDataStore("topp", "topp_datastore", TRUE)
  expect_true(deleted)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "NULL")
})

#GeoPackage
#------------------------------------------------------------------------
test_that("CREATE dataStore - GeoPackage",{
  ds = GSGeoPackageDataStore$new(name = "topp_datastore_gpkg",
                                description = "topp_datastore description",
                                enabled = TRUE,
                                database = "file:data/somefile.gpkg")
  created <- gsman$createDataStore("topp", ds)
  expect_true(created)
  ds <- gsman$getDataStore("topp", "topp_datastore_gpkg")
  expect_is(ds, "GSDataStore")
  expect_equal(ds$description, "topp_datastore description")
  expect_true(ds$enabled)
})

test_that("UPDATE datastore - GeoPackage",{
  dataStore <- gsman$getDataStore("topp", "topp_datastore_gpkg")
  dataStore$setDescription("topp_datastore updated description")
  dataStore$setEnabled(FALSE)
  
  updated <- gsman$updateDataStore("topp", dataStore)
  expect_true(updated)
  ds <- gsman$getDataStore("topp", "topp_datastore_gpkg")
  expect_is(ds, "GSDataStore")
  expect_equal(ds$description, "topp_datastore updated description")
  expect_false(ds$enabled)
})

test_that("DELETE dataStore - GeoPackage",{
  deleted <- gsman$deleteDataStore("topp", "topp_datastore_gpkg", TRUE)
  expect_true(deleted)
  ds <- gsman$getDataStore("topp", "topp_datastore_gpkg")
  expect_is(ds, "NULL")
})
