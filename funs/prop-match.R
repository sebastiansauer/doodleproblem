#' Extracts probability of a doodle match from summarized results
#'
#' This helper function extracts the probability of a match 
#' - given the parameters n,p,o,r - 
#' from the data frame returned by `summarize_samples(smples)`.
#' @param smples_tbl summarized samples
#' @param n_colleagues number of colleagues
#'
#' @return
#' @export
#'
#' @examples
prop_match <- function(smples_tbl, n_colleagues){
  
  smples_tbl_we_found_slot <- 
    smples_tbl |> 
    mutate(Freq = replace_na(Freq, 0)) |> 
    group_by(we_found_slot = factor(Freq >= n_colleagues, levels = c(FALSE, TRUE)), .drop = FALSE) |> 
    summarise(n_matches = sum(n_matches)) |> 
    mutate(prop_matches = n_matches/sum(n_matches)) 
  
  out <- smples_tbl_we_found_slot$prop_matches[smples_tbl_we_found_slot$we_found_slot == TRUE]
  
  return(out)
}

