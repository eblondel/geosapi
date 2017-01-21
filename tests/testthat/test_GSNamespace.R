# test_GSNamespace.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSNamespace*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSNamespace")

gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsman <- GSNamespaceManager$new(gsUrl, gsUsr, gsPwd)

test_that("READ namespace",{
  ns <- gsman$getNamespace("topp")
  expect_is(ns, "GSNamespace")
  expect_true(all(c("name", "prefix", "uri") %in% names(ns)))
  expect_equal(ns$name, "topp")
  expect_equal(ns$prefix, "topp")
  expect_equal(ns$uri, "http://www.openplans.org/topp")
})

test_that("READ namespaces",{
  nslist <- gsman$getNamespaces()
  expect_true(all(sapply(nslist, function(x){class(x)[1] == "GSNamespace"})))
  nsnames <- gsman$getNamespaceNames()
  expect_equal(nsnames,c("sf", "sde", "cite", "nurc", "tiger", "it.geosolutions", "topp"))
})

test_that("CREATE namespace",{
  created <- gsman$createNamespace("geosapi", "http://www.my.org/geosapi")
  expect_true(created)
  ns <- gsman$getNamespace("geosapi")
  expect_equal(ns$name, "geosapi")
  expect_equal(ns$prefix, "geosapi")
  expect_equal(ns$uri, "http://www.my.org/geosapi")
})

test_that("UPDATE namespace",{
  updated <- gsman$updateNamespace("geosapi", "http://www.my.org/geosapi2")
  expect_true(updated)
  ns <- gsman$getNamespace("geosapi")
  expect_equal(ns$name, "geosapi")
  expect_equal(ns$prefix, "geosapi")
  expect_equal(ns$uri, "http://www.my.org/geosapi2")
})

test_that("DELETE namespace",{
  deleted <- gsman$deleteNamespace("geosapi")
  expect_true(deleted)
  ns <- gsman$getNamespace("geosapi")
  expect_is(ns, "NULL")
})