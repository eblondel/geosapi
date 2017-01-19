# test_GSFeatureType.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSFeatureType.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSFeatureTYpe")

test_that("featureType encoding/decoding",{
  
  ft <- GSFeatureType$new()
  expect_is(ft, "GSFeatureType")
  expect_is(ft, "R6")
  
  ft$setName("name")
  expect_equal("name", ft$name)
  
  ft$setNativeName("native_name")
  expect_equal("native_name", ft$nativeName)
  
  ft$setTitle("this is a title")
  expect_equal("this is a title", ft$title)
  
  ft$setDescription("this is a description")
  expect_equal("this is a description", ft$description)
  
  ft$setAbstract("this is an abstract")
  expect_equal("this is an abstract", ft$abstract)
  
  expect_true(ft$addKeyword("keyword1"))
  expect_true(ft$addKeyword("keyword2"))
  expect_true(ft$addKeyword("keyword3"))
  expect_false(ft$addKeyword("keyword1")) #because already added
  expect_true(ft$delKeyword("keyword3"))
  expect_false(ft$delKeyword("keyword3")) #because already deleted
  expect_equal(length(ft$keywords), 2L)
  expect_true(all(unlist(ft$keywords) == c("keyword1","keyword2")))
  
  ft$setProjectionPolicy("NONE")
  expect_equal("NONE", ft$projectionPolicy)
  
  ft$setSrs("EPSG:4326")
  expect_equal("EPSG:4326", ft$srs)
  ft$setNativeCRS("EPSG:4326")
  expect_equal("EPSG:4326", ft$nativeCRS)
  
  ft$setLatLonBoundingBox(-180, -90, 180, 90, crs = "EPSG:4326")
  ft$setNativeBoundingBox(-180, -90, 180, 90, crs = "EPSG:4326")
  
  #encoding to XML
  ftXML <- ft$encode()
  expect_is(ftXML, c("XMLInternalElementNode","XMLInternalNode","XMLAbstractNode"))
  
  #decoding from XML
  ft2 <- GSFeatureType$new(xml = ftXML)
  ft2XML <- ft2$encode()
  
  #check encoded XML is equal to decoded XML
  expect_true(all(sapply(XML::compareXMLDocs(XML::xmlDoc(ftXML), XML::xmlDoc(ft2XML)), length) == 0))
  
})
