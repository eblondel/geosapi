# test_GSVersion.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSVersion.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSVersion")

test_that("geoserver versions",{
  #gsVersion <- gsman$version
  #expect_is(gsVersion, "GSVersion")
  #GS_VERSION <- "2.12.1"
  #expect_equal(gsVersion$version, GS_VERSION)
  #expect_is(gsVersion$value, "list")
  #expect_equal(length(gsVersion$value), 3L)
  #expect_true(gsVersion$lowerThan("3.0.x"))
  #expect_true(gsVersion$lowerThan("2.11.3"))
  #expect_true(gsVersion$lowerThan("2.11.2"))
  #expect_true(gsVersion$greaterThan("1.5.1"))
  #expect_true(gsVersion$greaterThan("2.5.1"))
  #expect_true(gsVersion$greaterThan("2.10.x"))
  #expect_false(gsVersion$lowerThan("2.5.1"))
  #expect_false(gsVersion$greaterThan(GS_VERSION))
  #expect_false(gsVersion$lowerThan(GS_VERSION))
  #expect_true(gsVersion$equalTo(GS_VERSION))
  #expect_false(gsVersion$greaterThan("3.0.0"))
})
