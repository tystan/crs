
# see page 1999 in Hawkins et al. (2001)
var_x_on_y <- function(e_x, e_y, var_x, var_y, cov_xy) {

  term_a <- var_x / (e_y^2)
  term_b <- e_x^2 * var_y / (e_y^4)
  term_c <- -2 * e_x * cov_xy / (e_y^3)

  return(term_a + term_b + term_c)

}
