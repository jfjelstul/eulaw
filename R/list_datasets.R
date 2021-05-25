################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List variables in an eulaw.app dataset

#' @export
list_datasets <- function(database) {
  url <- stringr::str_c("https://www.api.eulaw.app/databases/", database)
  out <- make_simple_request(url)
  return(out)
}

################################################################################
# end R script
################################################################################
