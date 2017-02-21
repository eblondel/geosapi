# test_GSLayer.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSLayer.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSLayer")
testthat::skip_on_travis()
testthat::skip_on_cran()
gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsman <- GSDataStoreManager$new(gsUrl, gsUsr, gsPwd, "DEBUG")

test_that("layer encoding/decoding",{
  
  lyr <- GSLayer$new()
  expect_is(lyr, "GSLayer")
  expect_is(lyr, "R6")
  
  lyr$setName("name")
  expect_equal(lyr$name, "name")
  
  lyr$setDefaultStyle("mystyle")
  expect_equal(length(lyr$defaultStyle), 1L)
  expect_equal(lyr$defaultStyle[[1]], "mystyle")
  
  expect_true(lyr$addStyle("mystyle2"))
  expect_false(lyr$addStyle("mystyle2"))
  expect_true(lyr$addStyle("mystyle3"))
  expect_false(lyr$addStyle("mystyle3"))
  expect_true(lyr$addStyle("mystyle4"))
  expect_false(lyr$addStyle("mystyle4"))
  expect_equal(length(lyr$styles), 3L)
  expect_true(lyr$delStyle("mystyle4"))
  expect_false(lyr$delStyle("mystyle4"))
  expect_equal(length(lyr$styles), 2L)
  expect_equal(sapply(lyr$styles, function(x){x$name}), c("mystyle2","mystyle3"))
  
  #encoding to XML
  lyrXML <- lyr$encode()
  expect_is(lyrXML, c("XMLInternalElementNode","XMLInternalNode","XMLAbstractNode"))
  
  #decoding from XML
  lyr2 <- GSLayer$new(xml = lyrXML)
  lyr2XML <- lyr2$encode()
  
  #check encoded XML is equal to decoded XML
  expect_true(all(sapply(XML::compareXMLDocs(XML::xmlDoc(lyrXML), XML::xmlDoc(lyr2XML)), length) == 0))
  
})

test_that("READ layer",{
  lyr <- gsman$getLayer("tasmania_cities")
  expect_is(lyr,"GSLayer")
  expect_true(lyr$enabled)
  expect_true(lyr$queryable)
  expect_true(lyr$advertised)
  expect_equal(lyr$name, "tasmania_cities")
  expect_equal(length(lyr$defaultStyle), 1L)
  expect_equal(lyr$defaultStyle[[1]], "capitals")
})

test_that("READ layers",{ 
  lyrs <- gsman$getLayers()
  expect_equal(length(lyrs), 19L)
  expect_equal(unique(sapply(lyrs, function(x){class(x)[1]})), "GSLayer")
  expect_false(unique(sapply(lyrs, function(x){x$full})))
})

test_that("CREATE layer",{
  #create featuretype before
  ft <- GSFeatureType$new()
  ft$setName("tasmania_cities2")
  ft$setNativeName("tasmania_cities")
  ft$setAbstract("abstract")
  ft$setTitle("title")
  ft$setSrs("EPSG:4326")
  ft$setNativeCRS("EPSG:4326")
  ft$setEnabled(TRUE)
  ft$setProjectionPolicy("REPROJECT_TO_DECLARED")
  ft$setLatLonBoundingBox(-180,-90,180,90, crs = "EPSG:4326")
  ft$setNativeBoundingBox(-180,-90,180,90, crs ="EPSG:4326") 
  created <- gsman$createFeatureType("topp", "taz_shapes", ft)
  
  #test layer creation
  layer <- GSLayer$new()
  layer$setName("tasmania_cities2")
  layer$setDefaultStyle("capitals")
  layer$addStyle("generic")
  created <- gsman$createLayer(layer)
  expect_true(created)
})

test_that("UPDATE layer",{
  lyr <- gsman$getLayer("tasmania_cities")
  expect_equal(lyr$defaultStyle$name, "capitals")
  
  lyr$setDefaultStyle("generic")
  lyr$delStyle("generic")
  lyr$addStyle("capitals")
  updated <- gsman$updateLayer(lyr)
  lyr <- gsman$getLayer("tasmania_cities")
  expect_equal(lyr$defaultStyle$name, "generic")
  expect_equal(length(lyr$styles), 1L)
  expect_is(lyr$styles[[1]], "GSStyle")
  expect_equal(lyr$styles[[1]]$name, "capitals")
  
  lyr$setDefaultStyle("capitals")
  lyr$delStyle("capitals")
  updated <- gsman$updateLayer(lyr)
  expect_equal(lyr$defaultStyle$name, "capitals")
  expect_equal(length(lyr$styles), 0)
})

test_that("DELETE layer",{
  deleted <- gsman$deleteLayer("tasmania_cities2")
  expect_true(deleted)
  if(deleted){
    #delete feature after
    gsman$deleteFeatureType("topp", "taz_shapes", "tasmania_cities2")
  }
})

test_that("PUBLISH layer",{
  #create featuretype
  featureType <- GSFeatureType$new()
  featureType$setName("tasmania_cities2")
  featureType$setNativeName("tasmania_cities")
  featureType$setAbstract("abstract")
  featureType$setTitle("title")
  featureType$setSrs("EPSG:4326")
  featureType$setNativeCRS("EPSG:4326")
  featureType$setEnabled(TRUE)
  featureType$setProjectionPolicy("REPROJECT_TO_DECLARED")
  featureType$setLatLonBoundingBox(-180,-90,180,90, crs = "EPSG:4326")
  featureType$setNativeBoundingBox(-180,-90,180,90, crs ="EPSG:4326") 
  
  md1 <- GSMetadataLink$new(
    type = "text/xml",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/xml"
  )
  expect_true(featureType$addMetadataLink(md1))
  expect_false(featureType$addMetadataLink(md1))
  expect_equal(length(featureType$metadataLinks), 1L)
  md2 <- GSMetadataLink$new(
    type = "text/html",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/html"
  )
  expect_true(featureType$addMetadataLink(md2))
  expect_false(featureType$addMetadataLink(md2))
  expect_equal(length(featureType$metadataLinks), 2L)
  
  #create layer
  layer <- GSLayer$new()
  layer$setName("tasmania_cities2")
  layer$setDefaultStyle("capitals")
  layer$addStyle("generic")
  
  #try to publish the complete layer (featuretype + layer)
  published <- gsman$publishLayer("topp", "taz_shapes", featureType, layer)
  expect_true(published)
  
})

test_that("UNPUBLISH layer",{
  #try to unpublish the complete layer (featuretype + layer)
  unpublished <- gsman$unpublishLayer("topp", "taz_shapes", "tasmania_cities2")
  expect_true(unpublished)
})