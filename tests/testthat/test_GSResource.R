# test_GSResource.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSResource.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSResource")

test_that("resource encoding/decoding",{
  
  res <- GSResource$new(rootName = "featureType")
  expect_is(res, "GSResource")
  expect_is(res, "R6")
  
  res$setName("name")
  expect_equal("name", res$name)
  
  res$setNativeName("native_name")
  expect_equal("native_name", res$nativeName)
  
  res$setTitle("this is a title")
  expect_equal("this is a title", res$title)
  
  res$setDescription("this is a description")
  expect_equal("this is a description", res$description)
  
  res$setAbstract("this is an abstract")
  expect_equal("this is an abstract", res$abstract)
  
  expect_true(res$addKeyword("keyword1"))
  expect_true(res$addKeyword("keyword2"))
  expect_true(res$addKeyword("keyword3"))
  expect_false(res$addKeyword("keyword1")) #because already added
  expect_true(res$delKeyword("keyword3"))
  expect_false(res$delKeyword("keyword3")) #because already deleted
  expect_equal(length(res$keywords), 2L)
  expect_true(all(unlist(res$keywords) == c("keyword1","keyword2")))
  
  md1 <- GSMetadataLink$new(
    type = "text/xml",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/xml"
  )
  expect_true(res$addMetadataLink(md1))
  expect_false(res$addMetadataLink(md1))
  expect_equal(length(res$metadataLinks), 1L)
  md2 <- GSMetadataLink$new(
    type = "text/html",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/html"
  )
  expect_true(res$addMetadataLink(md2))
  expect_false(res$addMetadataLink(md2))
  expect_equal(length(res$metadataLinks), 2L)
  
  res$setProjectionPolicy("NONE")
  expect_equal("NONE", res$projectionPolicy)
  
  res$setSrs("EPSG:4326")
  expect_equal("EPSG:4326", res$srs)
  res$setNativeCRS("EPSG:4326")
  expect_equal("EPSG:4326", res$nativeCRS)
  
  res$setLatLonBoundingBox(-180, -90, 180, 90, crs = "EPSG:4326")
  res$setNativeBoundingBox(-180, -90, 180, 90, crs = "EPSG:4326")
  
  #encoding to XML
  resXML <- res$encode()
  expect_is(resXML, c("xml_document", "xml_node"))
  
  #decoding from XML
  res2 <- GSResource$new(rootName = "featureType", xml = resXML)
  res2XML <- res2$encode()
  
  #check encoded XML is equal to decoded XML
  testthat::expect_true(length(waldo::compare(resXML, res2XML))==0)
  
})
