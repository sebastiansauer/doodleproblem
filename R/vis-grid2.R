#' Visualize the sensitivity grid of a Doodle match analysis
#'
#' @param d_grid output of `populate_grid`
#'
#' @return ggplot object
#' @export
#'
#' @examples
#' vis_grid(d_grid)
vis_grid2 <- function(d_grid, facet_var_rows, facet_var_cols) {

  d_grid_labels <-
    d_grid |>
    mutate(n_colleagues = factor(n_colleagues)) |>
    group_by(.data[[facet_var_rows]], .data[[facet_var_cols]], n_colleagues) |>
    summarise(X = max(o),
              Y = last(match_prob))

  facet_var_rows_labs <- paste0(facet_var_rows, ": ", unique(d_grid[[facet_var_rows]]))
  names(facet_var_rows_labs) <- unique((d_grid[[facet_var_rows]]))

 facet_var_cols_labs <- paste0(facet_var_cols, ": ", unique(d_grid[[facet_var_cols]]))
  names(facet_var_cols_labs) <- unique((d_grid[[facet_var_cols]]))

  row_var_sym <- rlang::sym(facet_var_rows)
  col_var_sym <- rlang::sym(facet_var_cols)

  d_grid |>
    rename(n = n_colleagues) |>
    mutate(n = factor(n)) |>
    ggplot(aes(x = o, y = match_prob)) +
    geom_line(aes(color = n, group = n)) +
    geom_point(aes(color = n, group = n)) +
    facet_grid(rows = vars(!!row_var_sym),
               cols = vars(!!col_var_sym),
               labeller = label_both) +
    # facet_wrap(.data[[facet_var_rows]] ~ .data[[facet_var_cols]],
    #            labeller = labeller(.rows = facet_var_rows_labs,
    #                                .cols = facet_var_cols_labs)) +
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
