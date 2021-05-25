################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List possible parameter values in an eulaw.app database

#' @export
list_parameter_values <- function(database, parameter) {
  parameter <- stringr::str_remove(parameter, "_id")
  parameter <- stringr::str_replace_all(parameter, "_", "-")
  url <- stringr::str_c("https://www.api.eulaw.app/ID-numbers/", database, "/", parameter)
  out <- make_simple_request(url)
  return(out)
}

################################################################################
# end R script
################################################################################
