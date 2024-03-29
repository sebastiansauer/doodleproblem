#' Computes the probability of a doodle match
#'
#' @param n_colleagues Number of colleagues addressed
#' @param o number of options to choose from
#' @param p number of picked options per colleagues
#' @param r number of repetions (simulates) samples
#' @param dep dependencies between reviewers
#' @param return_prob return a single number?
#' @param p_sd sd of p
#'
#' @return dataframe or numeric
#' @export
#'
#' @examples
#' prob_doodle_match(3, 10, 3, 0)
prob_doodle_match <- function(n_colleagues,
                          o,
                          p,
                          r = 1e3,
                          dep,
                          p_sd = 0,
                          return_prob = TRUE
) {

  # compute the samples:
  out <- doodle_samples(n_colleagues = n_colleagues,
                        o = o,
                        p = p,
                        r = r,
                        dep = dep)

  # summarize them:
  out <- summarize_samples(out)

  if (return_prob) {
    out <- prop_match(out, n_colleagues = n_colleagues)
    stopifnot(class(out) == "numeric")
  }

  return(out)
}
