# test_GSWorkspace.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSWorkspace*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSWorkspace")

gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsman <- GSWorkspaceManager$new(gsUrl, gsUsr, gsPwd)

test_that("GET workspace",{
  ws <- gsman$getWorkspace("topp")
  expect_is(ws, "GSWorkspace")
  expect_true(all(c("xml", "name") %in% names(ws)))
  expect_equal(ws$name, "topp")
})

test_that("GET workspaces",{
  wslist <- gsman$getWorkspaces()
  expect_true(all(sapply(wslist, function(x){class(x)[1] == "GSWorkspace"})))
  wsnames <- gsman$getWorkspaceNames()
  expect_equal(wsnames,c("sf", "sde", "cite", "nurc", "tiger", "it.geosolutions", "topp"))
})

test_that("CREATE workspace",{
  created <- gsman$createWorkspace("geosapi")
  expect_true(created)
  ws <- gsman$getWorkspace("geosapi")
  expect_equal(ws$name, "geosapi")
})

test_that("DELETE workspace",{
  deleted <- gsman$deleteWorkspace("geosapi")
  expect_true(deleted)
  ws <- gsman$getWorkspace("geosapi")
  expect_is(ws, "NULL")
})