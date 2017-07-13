# test_GSLayerGroup.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSLayerGroup.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSLayerGroup")

test_that("layer group encoding/decoding",{
  
  lyr <- GSLayerGroup$new()
  expect_is(lyr, "GSLayerGroup")
  expect_is(lyr, "R6")
  
  lyr$setName("name")
  lyr$setTitle("title")
  lyr$setAbstract("abstract")
  lyr$setMode("SINGLE")
  lyr$setWorkspace("staging")
  lyr$addLayer(layer = "grc_farms", style = "generic")
  lyr$setBounds(-180,-90,180,90,crs = "EPSG:4326")
  
  #encoding to XML
  lyrXML <- lyr$encode()
  expect_is(lyrXML, c("XMLInternalElementNode","XMLInternalNode","XMLAbstractNode"))
  
  #decoding from XML
  lyr2 <- GSLayerGroup$new(xml = lyrXML)
  lyr2XML <- lyr2$encode()
  
  #check encoded XML is equal to decoded XML
  expect_true(all(sapply(XML::compareXMLDocs(XML::xmlDoc(lyrXML), XML::xmlDoc(lyr2XML)), length) == 0))
  
})

test_that("CREATE layer group",{
  lyr <- GSLayerGroup$new()
  lyr$setName("test_layergroup")
  lyr$setTitle("title")
  lyr$setAbstract("abstract")
  lyr$setMode("SINGLE")
  lyr$setWorkspace("topp")
  lyr$addLayer(layer = "tasmania_cities", style = "generic")
  lyr$setBounds(-180,-90,180,90,crs = "EPSG:4326")
  expect_true(gsman$createLayerGroup(layerGroup = lyr, ws = "topp"))
})

test_that("UPDATE layer group",{
  lyr <- GSLayerGroup$new()
  lyr$setName("test_layergroup")
  lyr$setTitle("title")
  lyr$setAbstract("abstract 2")
  lyr$setMode("SINGLE")
  lyr$setWorkspace("topp")
  lyr$addLayer(layer = "tasmania_cities", style = "generic")
  lyr$setBounds(-180,-90,180,90,crs = "EPSG:4326")
  expect_true(gsman$updateLayerGroup(layerGroup = lyr, ws = "topp"))
})

test_that("READ layer group",{
  lyr <- gsman$getLayerGroup(lyr = "test_layergroup", ws = "topp")
  expect_equal(lyr$abstract, "abstract 2")
  expect_is(lyr, "GSLayerGroup")
})

test_that("READ layer groups",{ 
  lyrs <- gsman$getLayerGroups(ws = "topp")
  expect_is(lyrs, "list")
  expect_equal(length(lyrs), 1L)
  expect_is(lyrs[[1]], "GSLayerGroup")
})

test_that("DELETE layer group",{
  expect_true(gsman$deleteLayerGroup(lyr = "test_layergroup", ws = "topp"))
})
