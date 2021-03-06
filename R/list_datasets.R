################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List datasets in an eulaw.app database
#'
#' This function lists all of the datasets that are available from the requested
#' database.
#'
#' @param database The name of the database as a string. Use the function
#'   \code{list_databases()} to see a list of valid values.
#' @return A tibble with 2 columns.
#' @export
list_datasets <- function(database) {
  url <- stringr::str_c("https://www.api.eulaw.app/databases/", database, "/datasets")
  out <- make_simple_request(url)
  out <- dplyr::select(out, dataset_id, dataset)
  return(out)
}

################################################################################
# end R script
################################################################################
