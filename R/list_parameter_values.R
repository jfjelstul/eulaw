################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List values for an eulaw.app API parameter
#'
#' This function lists all of the valid values for an API parameter. API
#' parameters can appear across multiple datasets within a database, and they
#' are always coded the same within a database, so you only need to specify a
#' database and a parameter. API parameters take numeric values that correspond
#' to categorical values.
#'
#' @param database The name of the database as a string. Use the function
#'   \code{list_databases()} to see a list of valid values.
#' @param parameter The name of an API parameter as a string. Use the function
#'   \code{list_parameters()} to see a list of valid values.
#' @return A tibble with 2 columns.
#'
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
