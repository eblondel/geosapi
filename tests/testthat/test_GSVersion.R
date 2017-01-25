# test_GSVersion.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSVersion.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSVersion")

test_that("layer encoding/decoding",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  gsUrl <- "http://localhost:8080/geoserver"
  gsUsr <- "admin"
  gsPwd <- "geoserver"
  gsVersion <- GSVersion$new(gsUrl, gsUsr, gsPwd)
  expect_is(gsVersion, "GSVersion")
  expect_equal(gsVersion$version, "2.10.1")
  expect_equal(gsVersion$value, 2101)
  expect_true(gsVersion$lowerThan("2.10.2"))
  expect_true(gsVersion$greaterThan("2.5.1"))
  expect_false(gsVersion$lowerThan("2.5.1"))
  expect_false(gsVersion$greaterThan("2.10.2"))
  
})