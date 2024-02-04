#' Summarizes Monte Carlo samples for finding the doodle match probability
#'
#' The returned dataframe shows for each simulated samples (denoted by `id`),
#' whether or not there `is_match`. In more detail, if `Freq >= n_colleagues`,
#' there `is_match`. Which slots happened to be the match (e.g, all colleagues
#' chose slot 1) is not so important, but reported by `slots_chosen`.
#'
#' @param smples Output of `estimate_common_slots`
#'
#' @return dataframe with summarized sample characteristics
#' @export
#'
#' @examples
#' summarize_samples(smples)
summarize_samples <- function(smples){

  smples_tbl <-
    smples |>
    #mutate(Freq = replace_na(Freq, 0)) |>
    group_by(Freq) |>
    summarise(n_matches = n()) |>
    mutate(prop_matches = n_matches / sum(n_matches))
  #mutate(Freq = replace_na(Freq, 0))

  return(smples_tbl)

}

