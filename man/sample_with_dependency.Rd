% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample-with-dependency.R
\name{sample_with_dependency}
\alias{sample_with_dependency}
\title{Sample with dependency}
\usage{
sample_with_dependency(p_set, o, dep, p_sd)
}
\arguments{
\item{p_set}{Set of picked options}

\item{o}{number of options to choose from}

\item{dep}{degree of dependency between colleagues}

\item{p_sd}{sd of p}
}
\value{
vector of picked slots (integer)
}
\description{
Similar to `sample` but allows for dependencies between the
picked options.
}
\details{
The proportion as specified by `dep` is subtracted from the combined
probability mass of the *u*npicked options and added in equal parts to the
*p*icked options.
}
\examples{
sample_with_dependency(p_set, o, dep)
}
