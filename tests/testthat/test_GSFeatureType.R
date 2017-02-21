# test_GSFeatureType.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSFeatureType.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSFeatureType")
testthat::skip_on_travis()
testthat::skip_on_cran()
gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsman <- GSDataStoreManager$new(gsUrl, gsUsr, gsPwd, "DEBUG")

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
  
  md1 <- GSMetadataLink$new(
    type = "text/xml",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/xml"
  )
  expect_true(ft$addMetadataLink(md1))
  expect_false(ft$addMetadataLink(md1))
  expect_equal(length(ft$metadataLinks), 1L)
  md2 <- GSMetadataLink$new(
    type = "text/html",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/html"
  )
  expect_true(ft$addMetadataLink(md2))
  expect_false(ft$addMetadataLink(md2))
  expect_equal(length(ft$metadataLinks), 2L)
  
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

test_that("READ featuretype",{ 
  ft <- gsman$getFeatureType("topp","taz_shapes", "tasmania_cities")
  expect_true(any(class(ft) == "GSFeatureType"))
  expect_true(ft$full)
})

test_that("READ featuretypes",{
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
  
  md1 <- GSMetadataLink$new(
    type = "text/xml",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/xml"
  )
  expect_true(ft$addMetadataLink(md1))
  expect_false(ft$addMetadataLink(md1))
  expect_equal(length(ft$metadataLinks), 1L)
  md2 <- GSMetadataLink$new(
    type = "text/html",
    metadataType = "ISO19115:2003",
    content = "http://somelink.org/html"
  )
  expect_true(ft$addMetadataLink(md2))
  expect_false(ft$addMetadataLink(md2))
  expect_equal(length(ft$metadataLinks), 2L)
  
  created <- gsman$createFeatureType("topp", "taz_shapes", ft)
  expect_true(created)
  
  featureType <- gsman$getFeatureType("topp", "taz_shapes", "tasmania_cities2")
  expect_is(featureType, "GSFeatureType")
  expect_true(featureType$enabled)
  expect_equal(featureType$abstract, "abstract")
})

test_that("UPDATE featuretype",{
  featureType <- gsman$getFeatureType("topp", "taz_shapes", "tasmania_cities2")
  featureType$setAbstract("abstract updated")
  featureType$setEnabled(FALSE)
  
  updated <- gsman$updateFeatureType("topp", "taz_shapes", featureType)
  expect_true(updated)
  ft <- gsman$getFeatureType("topp", "taz_shapes", "tasmania_cities2")
  expect_is(ft, "GSFeatureType")
  expect_equal(ft$abstract, "abstract updated")
  expect_false(ft$enabled)
})

test_that("DELETE featureType",{
  deleted <- gsman$deleteLayer("tasmania_cities2")
  expect_true(deleted)
  if(deleted){
    deleted <- gsman$deleteFeatureType("topp", "taz_shapes", "tasmania_cities2")
    expect_true(deleted)
    ft <- gsman$getFeatureType("topp", "taz_shapes", "tasmania_cities2")
    expect_is(ft, "NULL")
  }
  
})