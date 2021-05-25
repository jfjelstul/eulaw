################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List variables in an eulaw.app dataset

#' @export
list_variables <- function(database, dataset) {
  route <- route_codebook$route[route_codebook$database == database & route_codebook$dataset == dataset]
  url <- stringr::str_c("https://www.api.eulaw.app/", route, "?variables=1")
  out <- make_simple_request(url)
  return(out)
}

################################################################################
# end R script
################################################################################
