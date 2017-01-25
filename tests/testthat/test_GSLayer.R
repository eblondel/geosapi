# test_GSLayer.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSLayer.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSLayer")

gsUrl <- NULL
gsUsr <- NULL
gsPwd <- NULL
gsman <- NULL

test_that("layer encoding/decoding",{
  
  lyr <- GSLayer$new()
  expect_is(lyr, "GSLayer")
  expect_is(lyr, "R6")
  
  lyr$setName("name")
  expect_equal(lyr$name, "name")
  
  lyr$setDefaultStyle("mystyle")
  expect_equal(length(lyr$defaultStyle), 1L)
  expect_equal(lyr$defaultStyle[[1]], "mystyle")
  
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
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  gsUrl <- "http://localhost:8080/geoserver"
  gsUsr <- "admin"
  gsPwd <- "geoserver"
  gsman <- GSDataStoreManager$new(gsUrl, gsUsr, gsPwd, "DEBUG")
  
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
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  lyrs <- gsman$getLayers()
  expect_equal(length(lyrs), 19L)
  expect_equal(unique(sapply(lyrs, function(x){class(x)[1]})), "GSLayer")
  expect_false(unique(sapply(lyrs, function(x){x$full})))
})

test_that("CREATE layer",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
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
  created <- gsman$createLayer(layer)
  expect_true(created)
})

test_that("UPDATE layer",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  lyr <- gsman$getLayer("tasmania_cities")
  expect_equal(lyr$defaultStyle$name, "capitals")
  lyr$setDefaultStyle("generic")
  updated <- gsman$updateLayer(lyr)
  lyr <- gsman$getLayer("tasmania_cities")
  expect_equal(lyr$defaultStyle$name, "generic")
  lyr$setDefaultStyle("capitals")
  updated <- gsman$updateLayer(lyr)
  expect_equal(lyr$defaultStyle$name, "capitals")
})

test_that("DELETE layer",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  deleted <- gsman$deleteLayer("tasmania_cities2")
  expect_true(deleted)
  if(deleted){
    #delete feature after
    gsman$deleteFeatureType("topp", "taz_shapes", "tasmania_cities2")
  }
})

test_that("PUBLISH layer",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()  
  
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
  
  #create layer
  layer <- GSLayer$new()
  layer$setName("tasmania_cities2")
  layer$setDefaultStyle("capitals")
  
  #try to publish the complete layer (featuretype + layer)
  published <- gsman$publishLayer("topp", "taz_shapes", featureType, layer)
  expect_true(published)
  
})

test_that("UNPUBLISH layer",{
  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  #try to unpublish the complete layer (featuretype + layer)
  unpublished <- gsman$unpublishLayer("topp", "taz_shapes", "tasmania_cities2")
  expect_true(unpublished)
})