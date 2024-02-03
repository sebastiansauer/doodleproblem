#' Runs a sensitivity analysis for doodle mathces
#'
#' @param n_colleagues number of colleagues
#' @param o number of options to choose from
#' @param p number of picked options
#' @param dep degree of dependency
#'
#' @return dataframe with results of Doodle match sensitivity analysis
#' @export
#'
#' @examples
#' populate_grid(n_colleagues, o, p, dep)
populate_grid <- function(n_colleagues,
                          o,
                          p,
                          dep,
                          verbose = FALSE){

  d <- expand_grid(n_colleagues = n_colleagues,
                   o = o,
                   p = p,
                   dep = dep)

  if (verbose) print(paste0("Grid size (nrow): ", nrow(d)))

  d_grid <-
    d |>
    mutate(match_prob =
             pmap_dbl(
               .l = list(n_colleagues = n_colleagues, o = o, p = p, dep = dep),
               .f = prob_doodle_match,
               .progress = verbose))

  return(d_grid)
}
