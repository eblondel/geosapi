# test_GSWorkspace.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSWorkspace*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSWorkspace")

gsUrl <- NULL
gsUsr <- NULL
gsPwd <- NULL
gsman <- NULL

test_that("new workspace",{
  ws <- GSWorkspace$new(name = "test")
  expect_is(ws, "GSWorkspace")
  expect_equal(ws$name, "test")
})

test_that("READ workspace",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  gsUrl <- "http://localhost:8080/geoserver"
  gsUsr <- "admin"
  gsPwd <- "geoserver"
  gsman <- GSWorkspaceManager$new(gsUrl, gsUsr, gsPwd)
  
  ws <- gsman$getWorkspace("topp")
  expect_is(ws, "GSWorkspace")
  expect_true("name" %in% names(ws))
  expect_equal(ws$name, "topp")
})

test_that("READ workspaces",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  wslist <- gsman$getWorkspaces()
  expect_true(all(sapply(wslist, function(x){class(x)[1] == "GSWorkspace"})))
  wsnames <- gsman$getWorkspaceNames()
  expect_equal(wsnames,c("sf", "sde", "cite", "nurc", "tiger", "it.geosolutions", "topp"))
})

test_that("CREATE workspace",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  created <- gsman$createWorkspace("geosapi")
  expect_true(created)
  ws <- gsman$getWorkspace("geosapi")
  expect_equal(ws$name, "geosapi")
  nsman <- GSNamespaceManager$new(gsUrl, gsUsr, gsPwd)
  ns <- nsman$getNamespace("geosapi")
  expect_equal(ns$name, "geosapi")
  expect_equal(ns$prefix, "geosapi")
  expect_equal(ns$uri, "http://geosapi")
})

test_that("UPDATE namespace",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  updated <- gsman$updateWorkspace("geosapi", "http://www.my.org/geosapi2")
  expect_true(updated)
  nsman <- GSNamespaceManager$new(gsUrl, gsUsr, gsPwd)
  ns <- nsman$getNamespace("geosapi")
  expect_equal(ns$name, "geosapi")
  expect_equal(ns$prefix, "geosapi")
  expect_equal(ns$uri, "http://www.my.org/geosapi2")
})

test_that("DELETE workspace",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  deleted <- gsman$deleteWorkspace("geosapi")
  expect_true(deleted)
  ws <- gsman$getWorkspace("geosapi")
  expect_is(ws, "NULL")
})