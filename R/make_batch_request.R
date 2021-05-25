################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

make_batch_request <- function(database, dataset, parameters) {

  # pipe function
  `%>%` <- magrittr::`%>%`

  # API host
  host <- "https://www.api.eulaw.app/"

  # API response limit
  api_limit <- 10000

  # API rate limit
  api_rate_limit <- 12 * 2

  ##################################################
  # construct the data query
  ##################################################

  # create an empty string to hold conditions
  conditions <- ""

  # loop through parameters and add to query
  if(length(parameters) > 0) {
    for(i in 1:length(parameters)) {

      # construct the condition
      value <- stringr::str_c(parameters[[i]], collapse = "+")
      condition <- stringr::str_c("&", names(parameters)[i], "=", value)

      # add the condition to the string
      conditions <- stringr::str_c(conditions, condition)
    }
  }

  # route
  route <- route_codebook$route[route_codebook$database == database & route_codebook$dataset == dataset]

  # construct query
  url <- stringr::str_c(host, route, "?", conditions)

  ##################################################
  # check the number of observations
  ##################################################

  # construct the query
  n_url <- stringr::str_c(url, "&count=1")

  # message
  cat("Requesting data via the eulaw.app API...\n")

  # fetch data
  n_response <- httr::GET(n_url)

  # error handling
  if(n_response$status_code != 200) {
    stop("API query not successful. Did you provide valid values?")
  }

  # parse response
  n <- jsonlite::fromJSON(rawToChar(n_response$content), flatten = TRUE) %>% as.numeric()

  # message
  cat("Response received...\n")

  # number of batches
  batches <- ceiling(n / api_limit)

  # frequency of batch requests
  freq <- 60 / api_rate_limit * 2

  # print to console
  cat("Observations requested: ", n, "\n", sep = "")
  cat("Downloading", api_limit, "observations every", freq, "seconds...\n")
  cat("Total estimated time: ", round(freq * (batches - 1) / 60, 2), " minutes (", freq * (batches - 1), " seconds)\n", sep = "")

  ##################################################
  # fetch the data
  ##################################################

  # empty list to hold batches
  out <- list()

  # loop through batches
  for(i in 1:batches) {

    # print to console
    clear_console_line()
    cat("\rDownloading...", sep = "")

    # limit condition
    limit_condition <- stringr::str_c("&limit=", api_limit)

    # offset condition
    offset_condition <- stringr::str_c("&offset=", api_limit * (i - 1))

    # batch query
    batch_url <- stringr::str_c(url, limit_condition, offset_condition)

    # fetch data
    response <- httr::GET(batch_url)

    # error handling
    if(response$status_code != 200) {
      stop("API query not successful. Did you provide valid values?")
    }

    # parse response and coerce to a tibble
    batch <- jsonlite::fromJSON(rawToChar(response$content), flatten = TRUE) %>% dplyr::as_tibble()

    # print to console
    progress <- stringr::str_c("\rBatch ", i, " of ", batches, " complete (observations ", api_limit * (i - 1) + 1, " to ", min(i * api_limit, n), " of ", n, ")\n")
    cat(progress)

    # countdown
    if(i != batches) {
      for(j in freq:1) {
        clear_console_line()
        cat("\rNext batch in: ", j, "     ", sep = "")
        Sys.sleep(1)
      }
    }

    # add tibble to output list
    out[[i]] <- batch
  }

  ##################################################
  # prepare the output
  ##################################################

  # stack tibbles
  out <- dplyr::bind_rows(out)

  # print to console
  clear_console_line()
  cat("\rYour download is complete\n")
  cat("\n")
  cat("If you use this database in a paper or project, please use the following citation:\n")
  cat("\n")
  cat("Joshua C. Fjelstul (2021). eulaw: An R Interface to the eulaw.app API. R package version 0.1.0.9000. https://github.com/jfjelstul/eulaw\n")

  # return a tibble
  return(out)
}

################################################################################
# end R script
################################################################################
