################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

#' Search the eulaw.app database

#' @export
download_data <- function(database, dataset, parameters = NULL) {
  valid <- run_quietly(list_parameters(database, dataset))
  parameters <- filter_parameters(parameters, valid$parameter)
  out <- make_batch_request(database, dataset, parameters)
  return(out)
}

################################################################################
# end R script
################################################################################
