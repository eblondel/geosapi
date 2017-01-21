# test_GSFeatureType.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSFeatureType.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSFeatureType")

gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsman <- GSDataStoreManager$new(gsUrl, gsUsr, gsPwd)

test_that("featureType encoding/decoding",{
  
  ft <- GSFeatureType$new()
  expect_is(ft, "GSFeatureType")
  expect_is(ft, "R6")
  
  ft$setName("name")
  expect_equal(ft$name, "name")
  
  ft$setNativeName("native_name")
  expect_equal(ft$nativeName, "native_name")
  
  ft$setTitle("this is a title")
  expect_equal(ft$title, "this is a title")
  
  ft$setDescription("this is a description")
  expect_equal(ft$description, "this is a description")
  
  ft$setAbstract("this is an abstract")
  expect_equal(ft$abstract, "this is an abstract")
  
  expect_true(ft$addKeyword("keyword1"))
  expect_true(ft$addKeyword("keyword2"))
  expect_true(ft$addKeyword("keyword3"))
  expect_false(ft$addKeyword("keyword1")) #because already added
  expect_true(ft$delKeyword("keyword3"))
  expect_false(ft$delKeyword("keyword3")) #because already deleted
  expect_equal(length(ft$keywords), 2L)
  expect_true(all(unlist(ft$keywords) == c("keyword1","keyword2")))
  
  ft$setProjectionPolicy("NONE")
  expect_equal(ft$projectionPolicy, "NONE")
  
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

test_that("GET featuretypes",{ 
  ft <- gsman$getFeatureType("topp","taz_shapes", "tasmania_cities")
  expect_true(any(class(ft) == "GSFeatureType"))
  expect_true(ft$full)
})

test_that("GET featuretypes",{
  fts <- gsman$getFeatureTypes("topp","taz_shapes")
  expect_equal(length(fts), 4L)
  expect_equal(unique(sapply(fts, function(x){class(x)[1]})), "GSFeatureType")
  expect_false(unique(sapply(fts, function(x){x$full})))
  expect_equal(sapply(fts,function(x){x$name}),paste0("tasmania_", c("cities", "roads", "state_boundaries", "water_bodies")))
})

test_that("CREATE featureType",{
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
  expect_true(created)
})

test_that("DELETE featureType",{
  deleted <- gsman$deleteFeatureType("topp", "taz_shapes", "tasmania_cities2")
  expect_true(deleted)
  ft <- gsman$getFeatureType("topp", "taz_shapes", "tasmania_cities2")
  expect_is(ft, "NULL")
})