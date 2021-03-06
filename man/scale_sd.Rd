% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/0_util.r
\name{scale_sd}
\alias{scale_sd}
\alias{scale_01}
\title{Preprocessing variable transformation}
\usage{
scale_sd(data)

scale_01(data)
}
\arguments{
\item{data}{Numeric matrix or data.frame of the observations.}
}
\description{
Centers and scales each column by standard deviation (sd) or to the
interval (0, 1).
}
\examples{
scale_sd(data = wine[, 2:14])
scale_01(data = wine[, 2:14])
}
