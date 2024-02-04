#' Simulate Doodle Samples
#'
#' Simulates Doodle samples as a basis for computing the match probability.
#'
#' @param n_colleagues number of colleagues addressed
#' @param o number of options to choose from
#' @param p number of picked options
#' @param r number of repetitions of simulations (defaults to 1e3)
#' @param dep degree of dependency between colleagues (defaults to 0)
#'
#' @return dataframe with samples
#' @export
#'
#' @examples
#' doodle_samples(n_colleagues, o, p)
doodle_samples <- function(n_colleagues,
                           o,
                           p,
                           r = 1e3,
                           dep = 0){

  first_common_slot <- count_common_slots(n_colleagues, o = o, p = p, dep = dep)
  all_common_slots <- estimate_common_slots(first_common_slot,
                                            n_colleagues = n_colleagues,
                                            o = o,
                                            p = p,
                                            dep = dep)

  attr(all_common_slots, "n_colleagues") <- n_colleagues
  attr(all_common_slots, "o") <- o
  attr(all_common_slots, "p") <- p
  attr(all_common_slots, "r") <- r
  attr(all_common_slots, "dep") <- dep

  return(all_common_slots)

}
