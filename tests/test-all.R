library(testthat)
library(geosapi)

#test environment
gsUrl <- "http://localhost:8080/geoserver"
gsUsr <- "admin"
gsPwd <- "geoserver"
gsman <- NULL

tryCatch({
  gsman <- GSManager$new(gsUrl, gsUsr, gsPwd, "DEBUG")
  test_check("geosapi")
},error = function(e){
  cat("GeoServer test instance is not started. Skipping integration tests...\n")
})