# see page 1998 in Hawkins et al. (2001)
var_lin_comb <- function(idxs, p_ij_dot, r_ij, m_ij, n) {

  n_comb <- length(idxs)
  cumulative_var <- 0

  if (n_comb < 2)
    stop("Need at least 2 RVs, make sure idxs is at least length 2")

  for (k in 1:n_comb) {

    i1 <- idxs[k]

    for (m in k:n_comb) {

      if (k == m) {

        cumulative_var <-
          cumulative_var +
          var_pijk(p_ij_dot, r_ij, m_ij, n)[i1]

      } else {

        i2 <- idxs[m]
        cumulative_var <-
          cumulative_var +
          2 * cov_pijk_pair(c(i1, i2), p_ij_dot, r_ij, n)

      }
    }
  }

  return(cumulative_var)

}

