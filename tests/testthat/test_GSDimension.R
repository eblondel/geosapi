# test_GSDimension.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSDimension.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSDimension")

test_that("dimension encoding/decoding",{

  dim <- GSDimension$new()
  dim$setEnabled(TRUE)
  dim$setPresentation("CONTINUOUS_INTERVAL")
  dim$setUnit("ISO8601")
  expect_true(dim$enabled)
  expect_equal(dim$presentation, "CONTINUOUS_INTERVAL")
  expect_equal(dim$units, "ISO8601")

  #encoding to XML
  dimXML <- dim$encode()
  expect_is(dimXML, c("XMLInternalElementNode","XMLInternalNode","XMLAbstractNode"))
  
  #decoding from XML
  dim2 <- GSDimension$new(xml = dimXML)
  dim2XML <- dim2$encode()
  
  #check encoded XML is equal to decoded XML
  expect_true(all(sapply(XML::compareXMLDocs(XML::xmlDoc(dimXML), XML::xmlDoc(dim2XML)), length) == 0))
  
})
