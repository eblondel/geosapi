library(testthat)
library(geosapi)

#test environment
gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsLogger <- "INFO"
gsman <- try(GSManager$new(gsUrl, gsUsr, gsPwd, gsLogger))


if(is(gsman, "GSManager")){
  cat(sprintf("GeoServer test instance started at %s. Running integration tests...\n", gsUrl))
  test_check("geosapi")
}else{
  cat("GeoServer test instance is not started. Skipping integration tests...\n")
}
