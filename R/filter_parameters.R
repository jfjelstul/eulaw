################################################################################
# Joshua C. Fjelstul, Ph.D.
# eulaw R package
################################################################################

filter_parameters <- function(provided, valid) {

  # filter parameteres
  filtered <- provided[names(provided) %in% valid]

  # invalid parameters
  invalid <- provided[!(names(provided) %in% valid)]

  # warn about invalid parameters
  if(length(invalid) > 0) {
    stop(stringr::str_c(
      "The following API parameters are not valid: ",
      stringr::str_c(
        names(invalid), collapse = ", "
      ),
      collapse = ""
    ))
  }

  # return filtered parameters
  return(filtered)
}

################################################################################
# end R script
################################################################################
