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
  expect_is(ds, "GSDataStore")
  expect_true(all(c("name", "enabled", "type", "description", "connectionParameters", "full") %in% names(ds)))
  expect_equal(ds$name, "taz_shapes")
})

test_that("READ dataStores",{
  dslist <- gsman$getDataStores("topp")
  expect_true(all(sapply(dslist, function(x){class(x)[1] == "GSDataStore"})))
  dsnames <- gsman$getDataStoreNames("topp")
  expect_equal(dsnames, c("states_shapefile","taz_shapes"))
})

test_that("CREATE dataStore - Shapefile",{
  ds = GSShapefileDataStore$new(dataStore="topp_datastore",
                                description = "topp_datastore description",
                                enabled = TRUE,
                                url = "file:data/shapefiles/states.shp")
  created <- gsman$createDataStore("topp", ds)
  expect_true(created)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "GSDataStore")
  expect_equal(ds$description, "topp_datastore description")
  expect_true(ds$enabled)
})

test_that("UPDATE datastore",{
  dataStore <- gsman$getDataStore("topp", "topp_datastore")
  dataStore$setDescription("topp_datastore updated description")
  dataStore$setEnabled(FALSE)
  
  updated <- gsman$updateDataStore("topp", dataStore)
  expect_true(updated)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "GSDataStore")
  expect_equal(ds$description, "topp_datastore updated description")
  expect_false(ds$enabled)
})

test_that("DELETE dataStore",{
  deleted <- gsman$deleteDataStore("topp", "topp_datastore")
  expect_true(deleted)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "NULL")
})
