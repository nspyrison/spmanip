% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/0_util.r
\name{manip_var_of}
\alias{manip_var_of}
\title{Suggest a manipulation variable.}
\usage{
manip_var_of(basis, rank = 1L)
}
\arguments{
\item{basis}{Numeric matrix (p x d), orthogonal liner combinations of the
variables.}

\item{rank}{The number, specifying the variable with the \code{rank}-th largest
contribution. Defaults to 1.}
}
\value{
Numeric scalar, the column number of a variable.
}
\description{
Find the column number of the variable with the \code{rank}-ith largest
contribution in the first column of the supplied basis.
Useful for identifying a variable to change the contribution of in a manual
tour, it's \code{manip_var} argument.
}
\examples{
dat_std <- scale_sd(wine[, 2:14])
bas <- basis_pca(dat_std)
manip_var_of(basis = bas)
}
