# test_GSWorkspace.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSWorkspace*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSWorkspace")

gsman$createWorkspace("geosapi")

test_that("CREATE workspace settings",{
  settings <- GSWorkspaceSettings$new()
  created <- gsman$createWorkspaceSettings("geosapi", settings)
  expect_true(created)
})

test_that("READ workspace settings",{
  settings <- gsman$getWorkspaceSettings("geosapi")
  expect_true(!is.null(settings))
})

test_that("UPDATE workspace settings",{
  settings <- GSWorkspaceSettings$new()
  updated <- gsman$updateWorkspaceSettings("geosapi", settings)
  expect_true(updated)
})

test_that("DELETE workspace settings",{
  deleted <- gsman$deleteWorkspaceSettings("geosapi")
  expect_true(deleted)
})

gsman$deleteWorkspace("geosapi")