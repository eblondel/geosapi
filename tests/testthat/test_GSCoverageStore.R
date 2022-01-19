# test_GSCoverageStore.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSCoverageStore*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSCoverageStore")

test_that("READ coverageStore",{
  expect_is(gsman,"GSManager")
  cs <- gsman$getCoverageStore("nurc", "mosaic")
  expect_is(cs, "GSAbstractCoverageStore")
  expect_true(all(c("name", "enabled", "type", "description", "full") %in% names(cs)))
  expect_equal(cs$name, "mosaic")
})

test_that("READ coverageStores",{
  cslist <- gsman$getCoverageStores("nurc")
  expect_true(all(sapply(cslist, function(x){class(x)[1] == "GSAbstractCoverageStore"})))
  csnames <- gsman$getCoverageStoreNames("nurc")
  expect_true(all(csnames %in% c("arcGridSample","img_sample2", "mosaic","worldImageSample")))
})

#GeoTIFF
#---------------------------------------------------------------------------

test_that("CREATE coverageStore - GeoTIFF",{
  cs = GSGeoTIFFCoverageStore$new(name="sfdem_new",
                                description = "sfdem new description", enabled = TRUE,
                                url = "file:data/sf/sfdem.tif")
  created <- gsman$createCoverageStore("sf", cs)
  expect_true(created)
  ds <- gsman$getCoverageStore("sf", "sfdem_new")
  expect_is(ds, "GSGeoTIFFDataStore")
  expect_equal(ds$description, "topp_datastore description")
  expect_true(ds$enabled)
})
