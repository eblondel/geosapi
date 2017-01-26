# test_GSMetadataLink.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSMetadataLink.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSMetadataLink")

test_that("metadataLink encoding/decoding",{
  
  md = GSMetadataLink$new(
    type = "text/xml",
    metadataType = "TC211",
    content = "http://someuri"
  )
  expect_is(md, "GSMetadataLink")
  expect_equal(md$type, "text/xml")
  expect_equal(md$metadataType, "TC211")
  expect_equal(md$content, "http://someuri")
  
  #encoding to XML
  mdXML <- md$encode()
  expect_is(mdXML, c("XMLInternalElementNode","XMLInternalNode","XMLAbstractNode"))
  
  #decoding from XML
  md2 <- GSMetadataLink$new(xml = mdXML)
  md2XML <- md2$encode()
  
  #check encoded XML is equal to decoded XML
  expect_true(all(sapply(XML::compareXMLDocs(XML::xmlDoc(mdXML), XML::xmlDoc(md2XML)), length) == 0))
  
})