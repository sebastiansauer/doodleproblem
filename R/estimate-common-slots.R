#' Monte Carlo analysis of doodle matches
#'
#' Essentially a loop around `count_common_slots`
#'
#' @param slots_chosen_collision slots chosen by all colleagues (match)
#' @param n_colleagues  number of colleagues
#' @param o  number of options to choose from
#' @param p number of picked options
#' @param dep  degree of dependency beteen colleagues
#' @param r  number of repeated simulations
#'
#' @return dataframe of samples for Doodle match
#' @export
#'
#' @examples
#' estimate_common_slots(slots_chosen_collision, n_colleagues, o, p, dep)
estimate_common_slots <- function(slots_chosen_collision, n_colleagues, o, p, dep, r = 1e3){

  smples <-
    slots_chosen_collision |>
    # add id for further reference:
    mutate(id = 1)

  # repeat r times, giving us many simulated samples:
  for (i in 2:r) {
    tmp <- count_common_slots(n_colleagues = n_colleagues,
                              o = o,
                              p = p,
                              dep = dep)
    tmp$id <- i

    smples <-
      smples |>
      bind_rows(tmp)
  }

  attr(smples, "n_simulated_samples") <- r

  return(smples)
}
