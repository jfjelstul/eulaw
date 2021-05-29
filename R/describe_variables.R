################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' Describe variables in an eulaw.app dataset
#'
#' This function describes all of the variables in the requested dataset.
#'
#' @param database The name of the database as a string. Use the function
#'   \code{list_databases()} to see a list of valid values.
#' @param dataset The name of the dataset as a string. Use the function
#'   \code{list_datasets()} to see a list of valid values.
#' @return A tibble with 4 columns.
#' @export
describe_variables <- function(database, dataset) {
  route <- route_codebook$route[route_codebook$database == database & route_codebook$dataset == dataset]
  url <- stringr::str_c("https://www.api.eulaw.app/databases/", database, "/variables?dataset=", dataset)
  out <- make_simple_request(url)
  out <- dplyr::select(out, variable_id, variable, type, description)
  return(out)
}

################################################################################
# end R script
################################################################################
