################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' Search the eulaw.app codebook

#' @export
download_codebook <- function(database, dataset = NULL) {
  if (!is.null(dataset)) {
    dataset <- stringr::str_c("?dataset=", dataset)
  } else {
    dataset <- ""
  }
  url <- stringr::str_c("https://www.api.eulaw.app/databases/", database, "/codebook", dataset)
  out <- make_simple_request(url, key_id = TRUE)
  return(out)
}

################################################################################
# end R script
################################################################################
