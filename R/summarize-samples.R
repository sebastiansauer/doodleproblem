#' Summarizes Monte Carlo samples for finding the doodle match probability
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

