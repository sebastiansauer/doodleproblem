% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/count-common-slots.R
\name{count_common_slots}
\alias{count_common_slots}
\title{Count Doodle matches}
\usage{
count_common_slots(n_colleagues, o, p, dep = 0, p_sd = 0)
}
\arguments{
\item{n_colleagues}{number of colleagues}

\item{o}{number of options available}

\item{p}{number of picked options}

\item{dep}{proportion of dependency between colleagues}

\item{p_sd}{sd of p}
}
\value{
dataframe where each row is a match
}
\description{
A match is (`is_match`) where the `Freq`uency of a picked options is
at least as great as the number of colleagues (`n_colleagues`)
}
\examples{
count_common_slots(n_colleagues, o, p, dep)
}
