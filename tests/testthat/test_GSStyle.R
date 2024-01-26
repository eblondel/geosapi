# test_GSStyle.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSStyle.R
#=======================
require(geosapi, quietly = TRUE)
require(XML)
require(testthat)

context("GSStyle")

test_that("style encoding/decoding",{
  style <- GSStyle$new()
  expect_is(style, "GSStyle")
  expect_is(style, "R6")
})

test_that("GET style",{
  style <- gsman$getStyle("capitals")
  expect_is(style, "GSStyle")
})

test_that("READ style (SLD content)",{
  sldBody <- gsman$getSLDBody("capitals")
  expect_is(sldBody, "xml_document")
})

test_that("GET styles",{ 
  styles <- gsman$getStyles()
  expect_equal(length(styles), 21L)
  expect_equal(unique(sapply(styles, function(x){class(x)[1]})), "GSStyle")
  expect_false(unique(sapply(styles, function(x){x$full})))
})

test_that("CREATE style",{
  sldFile <- system.file("extdata", "mystyle.sld", package = "geosapi")
  sldStyle <- xml2::read_xml(sldFile)
  expect_true(is(sldStyle, "xml_document"))
  
  created <- gsman$createStyle(file = sldFile, name = "mystyle")
  expect_true(created)
})

test_that("UPDATE style",{
  sldFile2 <- system.file("extdata", "mystyle2.sld", package = "geosapi")
  sldStyle2 <- xml2::read_xml(sldFile2)
  expect_true(is(sldStyle2, "xml_document"))
  updated <- gsman$updateStyle(sldBody = sldStyle2, name = "mystyle")
  expect_true(updated)
})

test_that("DELETE style",{
  deleted <- gsman$deleteStyle("mystyle", TRUE, TRUE)
  expect_true(deleted)
})
