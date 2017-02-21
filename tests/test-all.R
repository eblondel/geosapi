library(testthat)
library(geosapi)

#test environment
gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsLogger <- "DEBUG"
gsman <- try(GSManager$new(gsUrl, gsUsr, gsPwd, gsLogger))

if(class(gsman) = "try-error"){
  cat("GeoServer test instance is not started. Skipping integration tests...\n")
}else if(is(gsman, "GSManager")){
  test_check("geosapi")
}
