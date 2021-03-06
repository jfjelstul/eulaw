% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describe_variables.R
\name{describe_variables}
\alias{describe_variables}
\title{Describe variables in an eulaw.app dataset}
\usage{
describe_variables(database, dataset)
}
\arguments{
\item{database}{The name of the database as a string. Use the function
\code{list_databases()} to see a list of valid values.}

\item{dataset}{The name of the dataset as a string. Use the function
\code{list_datasets()} to see a list of valid values.}
}
\value{
A tibble with 4 columns.
}
\description{
This function describes all of the variables in the requested dataset.
}
