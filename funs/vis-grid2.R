#' Visualize the sensitivity grid of a Doodle match analysis 
#'
#' @param d_grid output of `populate_grid`
#'
#' @return ggplot object
#' @export
#'
#' @examples

vis_grid2 <- function(d_grid, facet_var) {
  
  d_grid_labels <- 
    d_grid |> 
    mutate(n_colleagues = factor(n_colleagues)) |> 
    group_by(.data[[facet_var]], n_colleagues) |> 
    summarise(X = max(o), 
              Y = last(match_prob))
  
  facet_labs <- paste0(facet_var, ": ", unique(d_grid[[facet_var]]))
  names(facet_labs) <- unique((d_grid[[facet_var]]))
  
  d_grid |> 
    rename(n = n_colleagues) |> 
    mutate(n = factor(n)) |> 
    ggplot(aes(x = o, y = match_prob)) +
    geom_line(aes(color = n, group = n)) +
    geom_point(aes(color = n, group = n)) +
    facet_wrap(~ .data[[facet_var]], 
               labeller = labeller(.rows = facet_labs)) +
    labs(title = "Proportiong of a match when 'doodling' for a joint meeting",
         caption = "p: Number of options picked per colleague;\n
       n: Number of colleagues approached;\n
       o: Number of available time slot options to choose from;\n
       dep: Degree of depedency between colleagues",
       y = "Probality of a match",
       color = "Number of\ncolleagues",
       text = "") +
    theme_light() +
    theme(legend.position = "none") +
    geom_label(data = d_grid_labels,
               aes(label = paste0("n: ", n_colleagues), 
                   x = X, y = Y, color = factor(n_colleagues))) +
    expand_limits(x = max(d_grid$o) + 1)
  
}
