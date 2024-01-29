# test_GSFeatureDimension.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSFeatureDimension.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSFeatureDimension")

test_that("feature dimension encoding/decoding",{
  
  dim <- GSFeatureDimension$new()
  dim$setEnabled(TRUE)
  dim$setAttribute("START_YEAR")
  dim$setEndAttribute("END_YEAR")
  dim$setPresentation("CONTINUOUS_INTERVAL")
  dim$setUnit("ISO8601")
  expect_true(dim$enabled)
  expect_equal(dim$attribute, "START_YEAR")
  expect_equal(dim$endAttribute, "END_YEAR")
  expect_equal(dim$presentation, "CONTINUOUS_INTERVAL")
  expect_equal(dim$units, "ISO8601")
  
  #encoding to XML
  dimXML <- dim$encode()
  expect_is(dimXML, c("xml_document", "xml_node"))
  
  #decoding from XML
  dim2 <- GSFeatureDimension$new(xml = dimXML)
  dim2XML <- dim2$encode()
  
  #check encoded XML is equal to decoded XML
  testthat::expect_true(length(waldo::compare(dimXML, dim2XML))==0)
  
})

test_that("featureType metadata",{
  
  ft <- GSFeatureType$new()
  ft$setName("name")
  
  timeDimension <- GSFeatureDimension$new()
  timeDimension$setEnabled(TRUE)
  timeDimension$setAttribute("START_YEAR")
  timeDimension$setEndAttribute("END_YEAR")
  timeDimension$setPresentation("CONTINUOUS_INTERVAL")
  timeDimension$setUnit("ISO8601")
  ft$setMetadata("time", timeDimension)
  
  #encoding to XML
  ftXML <- ft$encode()
  expect_is(ftXML, c("xml_document", "xml_node"))
  
  #decoding from XML
  ft2 <- GSFeatureType$new(xml = ftXML)
  ft2XML <- ft2$encode()
  
  #check encoded XML is equal to decoded XML
  testthat::expect_true(length(waldo::compare(ftXML, ft2XML))==0)
  
})