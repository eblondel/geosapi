# test_GSWorkspace.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSWorkspace*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSWorkspace")

test_that("new workspace",{
  ws <- GSWorkspace$new(name = "test")
  expect_is(ws, "GSWorkspace")
  expect_equal(ws$name, "test")
})

test_that("READ workspace",{
  ws <- gsman$getWorkspace("topp")
  expect_is(ws, "GSWorkspace")
  expect_true("name" %in% names(ws))
  expect_equal(ws$name, "topp")
})

test_that("READ workspaces",{
  wslist <- gsman$getWorkspaces()
  expect_true(all(sapply(wslist, function(x){class(x)[1] == "GSWorkspace"})))
})

test_that("CREATE workspace",{
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
  updated <- gsman$updateWorkspace("geosapi", "http://www.my.org/geosapi2")
  expect_true(updated)
  nsman <- GSNamespaceManager$new(gsUrl, gsUsr, gsPwd)
  ns <- nsman$getNamespace("geosapi")
  expect_equal(ns$name, "geosapi")
  expect_equal(ns$prefix, "geosapi")
  expect_equal(ns$uri, "http://www.my.org/geosapi2")
})

test_that("DELETE workspace",{
  deleted <- gsman$deleteWorkspace("geosapi")
  expect_true(deleted)
  ws <- gsman$getWorkspace("geosapi")
  expect_is(ws, "NULL")
})