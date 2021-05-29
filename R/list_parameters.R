################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List API parameters for an eulaw.app dataset
#'
#' This function lists all of the valid API parameters for the requested
#' dataset. You can use API parameters to filter the data when downloading a
#' dataset via the eulaw.app API. See the function \code{download_data()} for
#' more details. See the package vignette for an example of how to specify API
#' parameters.
#'
#' @param database The name of the database as a string. Use the function
#'   \code{list_databases()} to see a list of valid values.
#' @param dataset The name of the dataset as a string. Use the function
#'   \code{list_datasets()} to see a list of valid values.
#' @return A tibble with 2 columns.
#'
#' @export
list_parameters <- function(database, dataset) {

  # url
  route <- route_codebook$route[route_codebook$database == database & route_codebook$dataset == dataset]
  url <- stringr::str_c("https://www.api.eulaw.app/databases/", database, "/variables?dataset=", dataset)

  # request variables
  out <- make_simple_request(url)

  # select variables
  out <- dplyr::select(out, variable_id, variable)

  # filter
  out <- dplyr::filter(out, stringr::str_detect(variable, "_id$|^year$"))
  out <- dplyr::filter(out, !stringr::str_detect(dataset, "_net"))
  out <- dplyr::filter(out, variable != "key_id")

  # fix year
  out$variable[out$variable == "year"] <- "year_min, year_max"

  # split
  out <- tidyr::separate_rows(out, variable, sep = ", ")

  # rename variables
  names(out) <- c("parameter_id", "parameter")

  # if no parameters
  if (nrow(out) == 0) {
    cat("There are no API parameters for this dataset\n")
    return(NULL)
  }

  # new ID
  out$parameter_id <- 1:nrow(out)

  # convert to a tibble
  out <- dplyr::as_tibble(out)

  return(out)
}

################################################################################
# end R script
################################################################################
