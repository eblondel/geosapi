# test_GSServiceSettings.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSService*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSServiceSettings")

gsman$createWorkspace("geosapi")
settings <- GSWorkspaceSettings$new()
created <- gsman$createWorkspaceSettings("geosapi", settings)

test_that("Enable/Disable WMS",{
  enabled <- gsman$enableWMS("geosapi")
  expect_true(enabled)
  wms_settings <- gsman$getWmsSettings("geosapi")
  expect_true(wms_settings$enabled)
  disabled <- gsman$disableWMS("geosapi")
  expect_true(disabled)
  wms_settings <- gsman$getWmsSettings("geosapi")
  expect_false(wms_settings$enabled)
})

test_that("Enable/Disable WFS",{
  enabled <- gsman$enableWFS("geosapi")
  expect_true(enabled)
  wfs_settings <- gsman$getWfsSettings("geosapi")
  expect_true(wfs_settings$enabled)
  disabled <- gsman$disableWFS("geosapi")
  expect_true(disabled)
  wfs_settings <- gsman$getWfsSettings("geosapi")
  expect_false(wfs_settings$enabled)
})

test_that("Enable/Disable WCS",{
  enabled <- gsman$enableWCS("geosapi")
  expect_true(enabled)
  wcs_settings <- gsman$getWcsSettings("geosapi")
  expect_true(wcs_settings$enabled)
  disabled <- gsman$disableWCS("geosapi")
  expect_true(disabled)
  wcs_settings <- gsman$getWcsSettings("geosapi")
  expect_false(wcs_settings$enabled)
})

gsman$deleteWorkspace("geosapi")