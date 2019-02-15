get_crs_spec <- function(marg, rslv, trans_method = "probit", ci_lvl = 0.95) {

  n <- sum(marg)
  m_ij <- apply(rslv, 1:2, sum)
  m <- sum(m_ij)
  p_ij_dot <- marg / n
  r_ij <- rslv[, , 2] / (rslv[, , 1] +  rslv[, , 2])


  p_ij1 <- p_ij_dot * (1 - r_ij)

  true_neg  <- p_ij1[1, 1] + p_ij1[1, 2]
  false_pos <- p_ij1[2, 2] + p_ij1[2, 1]

  true_neg_ii  <- c(`(1,1)` = 1, `(1,2)` = 3)
  false_pos_ii <- c(`(2,1)` = 2, `(2,2)` = 4)

  E_x <- true_neg
  E_y <- true_neg + false_pos

  var_X <- var_lin_comb(true_neg_ii, p_ij_dot, 1 - r_ij, m_ij, n)
  var_Y <- var_lin_comb(c(true_neg_ii, false_pos_ii), p_ij_dot, 1 - r_ij, m_ij, n)

  cov_XY <- var_X
  for (kk in true_neg_ii)
    for (mm in false_pos_ii)
      cov_XY <- cov_XY + cov_pijk_pair(c(kk, mm), p_ij_dot, 1 - r_ij, n)

  p <- E_x/E_y # i.e., spec_est <- true_neg / (true_neg + false_pos)
  var_p <- var_x_on_y(E_x, E_y, var_X, var_Y, cov_XY)

  return(trans_ci(p, var_p, trans_method = trans_method, ci_lvl = ci_lvl))

}
