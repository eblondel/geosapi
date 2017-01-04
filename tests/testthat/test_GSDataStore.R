# test_GSDataStore.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSDataStore*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSDataStore")

gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsman <- GSDataStoreManager$new(gsUrl, gsUsr, gsPwd)

test_that("GET dataStore",{
  ds <- gsman$getDataStore("topp", "taz_shapes")
  expect_is(ds, "GSDataStore")
  expect_true(all(c("name", "enabled", "type", "description", "connectionParameters", "full") %in% names(ds)))
  expect_equal(ds$name, "taz_shapes")
})

test_that("GET dataStores",{
  dslist <- gsman$getDataStores("topp")
  expect_true(all(sapply(dslist, function(x){class(x)[1] == "GSDataStore"})))
  dsnames <- gsman$getDataStoreNames("topp")
  expect_equal(dsnames, c("states_shapefile","taz_shapes"))
})

test_that("CREATE dataStore - Shapefile",{
  ds = GSShapefileDataStore$new(dataStore="topp_datastore", description = "topp_datastore description",
                                enabled = TRUE, url = "file:data/shapefiles/states.shp")
  created <- gsman$createDataStore("topp", ds)
  expect_true(created)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "GSDataStore")
})

test_that("DELETE dataStore",{
  deleted <- gsman$deleteDataStore("topp", "topp_datastore")
  expect_true(deleted)
  ds <- gsman$getDataStore("topp", "topp_datastore")
  expect_is(ds, "NULL")
})