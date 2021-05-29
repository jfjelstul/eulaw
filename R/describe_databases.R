################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' Describe eulaw.app databases
#'
#' This function describes all of the databases that are available via the eulaw.app
#' API.
#'
#' @return A tibble with 3 columns.
#' @export
describe_databases <- function() {
  url <- "https://www.api.eulaw.app/databases"
  out <- make_simple_request(url)
  out <- dplyr::select(out, database_id, database, description)
  return(out)
}

################################################################################
# end R script
################################################################################
