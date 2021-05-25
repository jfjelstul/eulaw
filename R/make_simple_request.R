################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

make_simple_request <- function(url, key_id = FALSE, quietly = FALSE) {

  # message
  if (quietly == FALSE) {
    cat("Requesting data via the eulaw.app API...\n")
  }

  # fetch data
  response <- httr::GET(url)

  # error handling
  if(response$status_code != 200) {
    stop("API query not successful. Did you provide valid values?")
  }

  # parse response and coerce to a tibble
  out <- jsonlite::fromJSON(rawToChar(response$content), flatten = TRUE)

  # message
  if (quietly == FALSE) {
    cat("Response received...\n")
  }

  # convert to a tibble
  out <- dplyr::as_tibble(out)

  # key ID
  if(key_id == TRUE) {
    out$key_id <- 1:nrow(out)
  }

  return(out)
}

################################################################################
# end R script
################################################################################
