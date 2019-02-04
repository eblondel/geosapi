# test_GSServiceSettings.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSService*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSServiceSettings")

gsman$createWorkspace("geosapiWS")
settings <- GSWorkspaceSettings$new()
created <- gsman$createWorkspaceSettings("geosapiWS", settings)

test_that("Enable/Disable WMS",{
  enabled <- gsman$enableWMS("geosapiWS")
  expect_true(enabled)
  wms_settings <- gsman$getWmsSettings("geosapiWS")
  expect_true(wms_settings$enabled)
  disabled <- gsman$disableWMS("geosapiWS")
  expect_true(disabled)
  wms_settings <- gsman$getWmsSettings("geosapiWS")
  expect_null(wms_settings)
})

test_that("Enable/Disable WFS",{
  enabled <- gsman$enableWFS("geosapiWS")
  expect_true(enabled)
  wfs_settings <- gsman$getWfsSettings("geosapiWS")
  expect_true(wfs_settings$enabled)
  disabled <- gsman$disableWFS("geosapiWS")
  expect_true(disabled)
  wfs_settings <- gsman$getWfsSettings("geosapiWS")
  expect_null(wfs_settings)
})

test_that("Enable/Disable WCS",{
  enabled <- gsman$enableWCS("geosapiWS")
  expect_true(enabled)
  wcs_settings <- gsman$getWcsSettings("geosapiWS")
  expect_true(wcs_settings$enabled)
  disabled <- gsman$disableWCS("geosapiWS")
  expect_true(disabled)
  wcs_settings <- gsman$getWcsSettings("geosapiWS")
  expect_null(wcs_settings)
})

gsman$deleteWorkspace("geosapiWS")
