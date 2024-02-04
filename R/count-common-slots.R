#' Count Doodle matches
#'
#' A match is (`is_match`) where the `Freq`uency of a picked options is
#' at least as great as the number of colleagues (`n_colleagues`)
#'
#' @param n_colleagues number of colleagues
#' @param o number of options available
#' @param p number of picked options
#' @param dep proportion of dependency between colleagues
#' @param p_sd sd of p
#'
#' @return dataframe where each row is a match
#' @export
#'
#' @examples
#' count_common_slots(n_colleagues, o, p, dep)
count_common_slots <- function(n_colleagues, o, p, dep = 0, p_sd = 0){

  slots_chosen_l <- list()

  # make sure that only so many options can be picked as are available:
  if (p > o) p <- o

  # the first colleagues serves as a attractor for the others:
  slots_chosen_l[[1]] <- sample(1:o, size = p)

  for (i in 2:n_colleagues){  # for each colleague addressed:
    slots_chosen_l[[i]] <- sample_with_dependency(slots_chosen_l[[1]],
                                                  o,
                                                  dep,
                                                  p_sd = p_sd)  # pick p options from o possible options
  }



  slots_chosen <- unlist(slots_chosen_l)

  # a R table allows to easily find matches:
  slots_chosen_tbl <- slots_chosen |> table()

  # a match is where a picked options has a frequency of (at least) 3,
  # if 3 colleagues were addressed, etc.:
  slots_chosen_collision <- slots_chosen_tbl[slots_chosen_tbl >= n_colleagues]

  slots_chosen_df <- data.frame(slots_chosen_collision)

  # take care of border cases, only different options chosen:
  if (nrow(slots_chosen_df) == 0) slots_chosen_df <-
    data.frame(slots_chosen = factor(NA), Freq = NA_integer_)

  # if there's 1 match, tabl() returns a single number only,
  # so we have to make sure it looks like a real table:
  if (ncol(slots_chosen_df) == 1) slots_chosen_df <-
    data.frame(slots_chosen = factor(row.names(slots_chosen_df)),
               Freq = slots_chosen_df$slots_chosen_collision)

  # add a column indicating whether we have a match or not:
  slots_chosen_df$is_match <- FALSE
  slots_chosen_df$is_match[!is.na(slots_chosen_df$slots_chosen)] <- TRUE

  # add the relevant parameters as attributes to the dataframe:
  attr(slots_chosen_df, "n_colleagues") <- n_colleagues
  attr(slots_chosen_df, "o") <- o
  attr(slots_chosen_df, "p") <- p
  attr(slots_chosen_df, "chosen_options") <- slots_chosen
  attr(slots_chosen_df, "chosen_options_l") <- slots_chosen_l
  attr(slots_chosen_df, "attractor_slots") <- slots_chosen_l[[1]]
  attr(slots_chosen_df, "p_sd") <- p_sd

  return(slots_chosen_df)
}
