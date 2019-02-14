

var_pijk <- function(p_ij_dot, r_ij, m_ij, n) {

  term_a <- p_ij_dot^2 * r_ij * (1 - r_ij) / m_ij
  term_b <- r_ij^2 * p_ij_dot * (1 - p_ij_dot) / n

  return(term_a + term_b)

}
