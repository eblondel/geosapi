# test_GSCoverageStore.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSCoverageStore*.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSCoverageStore")

test_that("READ coverageStore",{
  expect_is(gsman,"GSManager")
  cs <- gsman$getCoverageStore("nurc", "mosaic")
  expect_is(cs, "GSAbstractCoverageStore")
  expect_true(all(c("name", "enabled", "type", "description", "full") %in% names(cs)))
  expect_equal(cs$name, "mosaic")
})

test_that("READ coverageStores",{
  cslist <- gsman$getCoverageStores("nurc")
  expect_true(all(sapply(cslist, function(x){class(x)[1] == "GSAbstractCoverageStore"})))
  csnames <- gsman$getCoverageStoreNames("nurc")
  expect_true(all(csnames %in% c("arcGridSample","img_sample2", "mosaic","worldImageSample")))
})


#GeoTIFF
#==========================================================================
#GeoTIFF CoverageStore CRUD 
#---------------------------------------------------------------------------

test_that("CRUD operations coverageStore - GeoTIFF",{
  cs = GSGeoTIFFCoverageStore$new(name="sfdem_new",
                                description = "sfdem_new description", enabled = TRUE,
                                url = "file:data/sf/sfdem_new.tif")
  #CREATE
  created <- gsman$createCoverageStore("sf", cs)
  expect_true(created)
  cs <- gsman$getCoverageStore("sf", "sfdem_new")
  expect_is(cs, "GSGeoTIFFCoverageStore")
  expect_equal(cs$description, "sfdem_new description")
  expect_true(cs$enabled)

  #UPDATE
  coverageStore <- gsman$getCoverageStore("sf", "sfdem_new")
  coverageStore$setDescription("sfdem_new updated description")
  coverageStore$setEnabled(FALSE)
  
  updated <- gsman$updateCoverageStore("sf", coverageStore)
  expect_true(updated)
  cs <- gsman$getCoverageStore("sf", "sfdem_new")
  expect_is(cs, "GSGeoTIFFCoverageStore")
  expect_equal(cs$description, "sfdem_new updated description")
  expect_false(cs$enabled)

  #DELETE
  deleted <- gsman$deleteCoverageStore("sf", "sfdem_new", TRUE)
  expect_true(deleted)
  cs <- gsman$getCoverageStore("sf", "sfdem_new")
  expect_is(cs, "NULL")
})

#GeoTIFF Upload/Coverage CRUD 
#---------------------------------------------------------------------------
test_that("Upload coverage file and Create coverage - GeoTIFF",{
  #prerequisite - create store
  cs = GSGeoTIFFCoverageStore$new(name="sfdem_new",
                                  description = "sfdem_new description", enabled = TRUE,
                                  url = "file:data/sf/sfdem_new.tif")
  created <- gsman$createCoverageStore("sf", cs)
  expect_true(created)
  
  #UPLOAD coverage file
  uploaded <- gsman$uploadGeoTIFF(ws = "sf", cs = "sfdem_new",
                                  endpoint = "file", configure = "none", update = "overwrite",
                                  filename = system.file("extdata/sfdem_new.tif", package = "geosapi"))
  expect_true(uploaded)
  
  #CREATE coverage
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
  
  created <- gsman$createCoverage(ws = "sf", cs = "sfdem_new", coverage = cov)
  expect_true(created)

  #READ coverage
  cov <- gsman$getCoverage(ws = "sf", cs = "sfdem_new", cv = "sfdem_new")
  expect_is(cov, "GSCoverage")
  expect_equal(cov$name, "sfdem_new")

  #UPDATE coverage
  cov$setEnabled(FALSE)
  cov$setAbstract("this is a modified abstract")
  updated <- gsman$updateCoverage(ws = "sf", cs = "sfdem_new", coverage = cov)
  expect_true(updated)
  cov_updated <- gsman$getCoverage(ws = "sf", cs = "sfdem_new", cv = "sfdem_new")
  expect_false(cov_updated$enabled)
  expect_equal(cov_updated$abstract, "this is a modified abstract")

  #DELETE coverage
  deleted <- gsman$deleteCoverage(ws = "sf", cs = "sfdem_new", cv = "sfdem_new", recurse = TRUE)
  expect_true(deleted)
  cov <- gsman$getCoverage(ws = "sf", cs = "sfdem_new", cv = "sfdem_new")
  expect_null(cov)
})