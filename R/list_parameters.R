################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' List variables in an eulaw.app dataset

#' @export
list_parameters <- function(database, dataset) {

  # url
  route <- route_codebook$route[route_codebook$database == database & route_codebook$dataset == dataset]
  url <- stringr::str_c("https://www.api.eulaw.app/", route, "?variables=1")

  # request variables
  out <- make_simple_request(url)

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

  # new ID
  out$parameter_id <- 1:nrow(out)

  # convert to a tibble
  out <- dplyr::as_tibble(out)

  # if no parameters
  if (nrow(out) == 0) {
    cat("There are no API parameters for this dataset\n")
    return(NULL)
  }

  return(out)
}

################################################################################
# end R script
################################################################################
