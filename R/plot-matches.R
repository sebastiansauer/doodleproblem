#' Plot the number of Doodle matches
#'
#' @param smples_tbl the output of the function `summarize_samples`
#' @param n_colleagues number of colleagues addressed
#' @param p number of picked options
#' @param o number of available options
#' @param dep degree of dependency between colleagues
#'
#' @return ggplot
#' @export
#'
#' @examples
#' plot_matches(smples_tbl, n_colleagues, p, o, dep)
plot_matches <- function(smples_tbl, n_colleagues, p, o, dep){

  smples_tbl |>
    mutate(Freq = replace_na(Freq, -99)) |>
    group_by(we_found_slot =
               factor(Freq >= n_colleagues, levels = c(FALSE, TRUE)),
             .drop = FALSE) |>
    summarise(n_matches = sum(n_matches),
              prop_matches = sum(prop_matches)) |>
    ggplot() +
    aes(x = we_found_slot, y = prop_matches) +
    geom_col() +
    labs(title = "Proportion of collisions",
         subtitle = paste0(n_colleagues, " colleagues, ", p, " picked time slots, ", o, " options to chose from, ", r, " simulated samples"),
         caption = paste0("Assumed dependency between colleagues: ", dep)) +
    geom_label(aes(label = round(prop_matches, 2), x = we_found_slot))
}

