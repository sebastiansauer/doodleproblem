#' Runs a sensitivity analysis for doodle matches
#'
#' Can take some computation times. Note that there are precomputed
#' results in data folder. Parameters of computations
#' are added as attributes to the output dataframe.
#'
#' @param n_colleagues number of colleagues
#' @param o number of options to choose from
#' @param p number of picked options
#' @param dep degree of dependency
#' @param p_sd sd of p
#'
#' @return dataframe with results of Doodle match sensitivity analysis
#' @export
#'
#' @examples
#' populate_grid(n_colleagues, o, p, dep, p_sd)
populate_grid <- function(n_colleagues,
                          o,
                          p,
                          dep,
                          p_sd = 0,
                          verbose = FALSE){

  d <- expand_grid(n_colleagues = n_colleagues,
                   o = o,
                   p = p,
                   p_sd = p_sd,
                   dep = dep)

  if (verbose) print(paste0("Grid size (nrow): ", nrow(d)))

  d_grid <-
    d |>
    mutate(match_prob =
             pmap_dbl(
               .l = list(n_colleagues = n_colleagues,
                         o = o,
                         p = p,
                         dep = dep,
                         p_sd = p_sd),
               .f = prob_doodle_match,
               .progress = verbose))


  attr(d_grid, "o") <- o
  attr(d_grid, "n_colleagues") <- n_colleagues
  attr(d_grid, "p") <- p
  attr(d_grid, "dep") <- dep


  return(d_grid)
}
