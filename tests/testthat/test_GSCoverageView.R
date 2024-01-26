# test_GSCoverageView.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSCoverageView.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSCoverageView")

test_that("GSCoverageView encoding/decoding",{

  coview <- GSCoverageView$new()
  coview$setName("sfdem_new")
  coview$setEnvelopeCompositionType("INTERSECTION")
  coview$setSelectedResolution("BEST")
  coview$setSelectedResolutionIndex(-1)
  coviewband <- GSCoverageBand$new()
  coviewband$setDefinition("sfdem_new@0")
  coviewband$setIndex(0)
  coviewband$addInputBand(GSInputCoverageBand$new( coverageName = "sfdem_new", band = 0))
  coview$addBand(coviewband)
  
  #encoding to XML
  coviewXML <- coview$encode()
  expect_is(coviewXML, c("xml_document", "xml_node"))
  
  #decoding from XML
  coview2 <- GSCoverageView$new(xml = coviewXML)
  coview2XML <- coview2$encode()
  
  #check encoded XML is equal to decoded XML
  testthat::compare(coviewXML, coview2XML)
  
})