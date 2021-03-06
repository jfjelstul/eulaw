################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List variables in an eulaw.app dataset
#'
#' This function lists all of the variables that are available in the requested
#' dataset.
#'
#' @param database The name of the database as a string. Use the function
#'   \code{list_databases()} to see a list of valid values.
#' @param dataset The name of the dataset as a string. Use the function
#'   \code{list_datasets()} to see a list of valid values.
#' @return A tibble with 2 columns.
#' @export
list_variables <- function(database, dataset) {
  route <- route_codebook$route[route_codebook$database == database & route_codebook$dataset == dataset]
  url <- stringr::str_c("https://www.api.eulaw.app/databases/", database, "/variables?dataset=", dataset)
  out <- make_simple_request(url)
  out <- dplyr::select(out, variable_id, variable)
  return(out)
}

################################################################################
# end R script
################################################################################
