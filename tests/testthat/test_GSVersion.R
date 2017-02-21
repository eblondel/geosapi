# test_GSVersion.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSVersion.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSVersion")
testthat::skip_on_travis()
testthat::skip_on_cran()

test_that("layer encoding/decoding",{
  expect_is(gsVersion, "GSVersion")
  expect_equal(gsVersion$version, "2.10.1")
  expect_is(gsVersion$value, "list")
  expect_equal(length(gsVersion$value), 3L)
  expect_true(gsVersion$lowerThan("3.0.x"))
  expect_true(gsVersion$lowerThan("2.11.2"))
  expect_true(gsVersion$lowerThan("2.10.2"))
  expect_true(gsVersion$greaterThan("1.5.1"))
  expect_true(gsVersion$greaterThan("2.5.1"))
  expect_true(gsVersion$greaterThan("2.10.x"))
  expect_false(gsVersion$lowerThan("2.5.1"))
  expect_false(gsVersion$greaterThan("2.10.2"))
  expect_false(gsVersion$greaterThan("3.0.0"))
  expect_false(gsVersion$greaterThan("2.10.1"))
  expect_false(gsVersion$lowerThan("2.10.1"))
  expect_true(gsVersion$equalTo("2.10.1"))
})