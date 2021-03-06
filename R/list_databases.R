################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List eulaw.app databases
#'
#' This function lists all of the databases that are available via the eulaw.app
#' API.
#'
#' @return A tibble with 2 columns.
#' @export
list_databases <- function() {
  url <- "https://www.api.eulaw.app/databases"
  out <- make_simple_request(url)
  out <- dplyr::select(out, database_id, database)
  return(out)
}

################################################################################
# end R script
################################################################################
