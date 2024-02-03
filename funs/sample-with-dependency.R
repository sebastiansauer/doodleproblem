#' Sample with dependency
#' 
#' Similar to `sample` but allows for dependencies between the 
#' picked options.
#' 
#' The proportion as specified by `dep` is subtracted from the combined
#' probability mass of the *u*npicked options and added in equal parts to the 
#' *p*icked options. 
#'
#' @param p_set Set of picked options
#' @param o number of options to choose frome
#' @param dep degree of dependency between colleagues
#'
#' @return
#' @export
#'
#' @examples
sample_with_dependency <- function(p_set, o, dep) {
  
  p <- length(p_set)
  o_set <- 1:o
  u_set <- setdiff(o_set, p_set)
  u <- length(u_set)
  
  #slots_chosen_l <- list()
  
  Pr_P <-  p / o
  Pr_U = 1 - Pr_P
  
  Pr_pi = Pr_P / p
  Pr_ui = u / o
  
  
  Pr_P_new <- Pr_P + dep*Pr_U
  Pr_Pi_new <- Pr_P_new / p
  


  Pr_U_new <- Pr_U - dep*Pr_U
  Pr_Ui_new <- Pr_U_new / u

  slots_chosen <- sample(c(p_set, u_set), 
                         size = p, 
                         prob = c(rep(Pr_Pi_new, p), rep(Pr_Ui_new, u)))
  
  return(slots_chosen)
}