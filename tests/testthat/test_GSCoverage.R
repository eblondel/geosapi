# test_GSCoverage.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSCoverage.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSCoverage")

test_that("GSCoverage encoding/decoding",{
  
  cov <- GSCoverage$new()
  cov$setName("sfdem_new")
  cov$setNativeName("sfdem_new")
  cov$setTitle("Title for sfdem")
  cov$setDescription("Description for sfdem")
  cov$addKeyword("sfdem keyword1")
  cov$addKeyword("sfdem keyword2")
  cov$addKeyword("sfdem keyword3")
  
  md1 <- GSMetadataLink$new(
    type = "text/xml",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/sfdem_new/xml"
  )
  cov$addMetadataLink(md1)
  md2 <- GSMetadataLink$new(
    type = "text/html",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/sfdem_new/html"
  )
  cov$addMetadataLink(md2)
  
  cov$setSrs("EPSG:4326")
  cov$setNativeCRS("EPSG:26713")
  cov$setLatLonBoundingBox(-103.87108701853181, 44.370187074132616, -103.62940739432703, 44.5016011535299, crs = "EPSG:4326")
  cov$setNativeBoundingBox(589980, 4913700, 609000, 4928010, crs = "EPSG:26713")
  
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
  cov$setView(coview)
  
  #encoding to XML
  covXML <- cov$encode()
  expect_is(covXML, c("XMLInternalElementNode","XMLInternalNode","XMLAbstractNode"))
  
  #decoding from XML
  cov2 <- GSCoverage$new(xml = covXML)
  cov2XML <- cov2$encode()
  
  #check encoded XML is equal to decoded XML
  expect_true(all(sapply(XML::compareXMLDocs(XML::xmlDoc(covXML), XML::xmlDoc(cov2XML)), length) == 0))
  
})