# test_GSVirtualTable.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for GSVirtualTable.R
#=======================
require(geosapi, quietly = TRUE)
require(testthat)

context("GSVirtualTable")

test_that("virtual table encoding/decoding",{
  
  vt <- GSVirtualTable$new()
  vt$setName("popstates")
  vt$setSql("select gid, state_name, the_geom from pgstates where persons between %low% and %high%")
  vtg <- GSVirtualTableGeometry$new(name = "the_geom", type = "MultiPolygon", srid = 4326)
  vt$setGeometry(vtg)
  vtp1 <- GSVirtualTableParameter$new(name = "low", defaultValue = "10000000",regexpValidator = "^[\\d]+$")
  vtp2 <- GSVirtualTableParameter$new(name = "high", defaultValue = "0",regexpValidator = "^[\\d]+$")
  vt$addParameter(vtp1)
  vt$addParameter(vtp2)
  
  vtXML <- vt$encode()
  expect_is(vtXML, c("XMLInternalElementNode","XMLInternalNode","XMLAbstractNode"))
  
  #decoding from XML
  vt2 <- GSVirtualTable$new(xml = vtXML)
  vt2XML <- vt2$encode()
  
  #check encoded XML is equal to decoded XML
  expect_true(all(sapply(XML::compareXMLDocs(XML::xmlDoc(vtXML), XML::xmlDoc(vt2XML)), length) == 0))
  
})
