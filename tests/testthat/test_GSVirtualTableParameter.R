# test_GSVirtualTableParameter.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSVirtualTableParameter.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSVirtualTableParameter")

test_that("virtual table parameter encoding/decoding",{
  vtp <- GSVirtualTableParameter$new(name = "fieldname", defaultValue = "default_value",
                                    regexpValidator = "^[\\w\\d\\s]+$")
  expect_is(vtp, "GSVirtualTableParameter")
  expect_equal(vtp$name, "fieldname")
  expect_equal(vtp$defaultValue, "default_value")
  expect_equal(vtp$regexpValidator, "^[\\w\\d\\s]+$")
  
  vtpXML <- vtp$encode()
  expect_is(vtpXML, c("xml_document", "xml_node"))
  
  #decoding from XML
  vtp2 <- GSVirtualTableParameter$new(xml = vtpXML)
  vtp2XML <- vtp2$encode()
  
  #check encoded XML is equal to decoded XML
  testthat::compare(vtpXML, vtp2XML)
  
})
