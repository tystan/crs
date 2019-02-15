get_crs_sens <- function(marg, rslv, trans_method = "probit", ci_lvl = 0.95) {

  n <- sum(marg)
  m_ij <- apply(rslv, 1:2, sum)
  m <- sum(m_ij)
  p_ij_dot <- marg / n
  r_ij <- rslv[, , 2] / (rslv[, , 1] +  rslv[, , 2])

  p_ij2 <- p_ij_dot * r_ij

  true_pos  <- p_ij2[2, 2] + p_ij2[2, 1]
  false_neg <- p_ij2[1, 2] + p_ij2[1, 1]

  # NOTE: Hawkins et al. (2001) propose: (note the subscripts in the false_neg calc)
  # true_pos <- p_ij_dot[2, 2] * r_ij[2, 2] + p_ij_dot[2, 1] * r_ij[2, 1]
  # false_neg <- p_ij_dot[1, 2] * r_ij[1, 2] + p_ij_dot[1, 1] * r_ij[1, 1]
  # HOWEVER, there is an error in subscripts

  false_neg_ii <- c(`(1,1)` = 1, `(1,2)` = 3)
  true_pos_ii  <- c(`(2,1)` = 2, `(2,2)` = 4)

  # i.e., sens_est <- true_pos / (true_pos + false_neg)
  E_x <- true_pos
  E_y <- true_pos + false_neg

  var_X <- var_lin_comb(true_pos_ii, p_ij_dot, r_ij, m_ij, n)
  var_Y <- var_lin_comb(c(true_pos_ii, false_neg_ii), p_ij_dot, r_ij, m_ij, n)

  cov_XY <- var_X
  for (kk in true_pos_ii)
    for (mm in false_neg_ii)
      cov_XY <- cov_XY + cov_pijk_pair(c(kk, mm), p_ij_dot, r_ij, n)

  p <- E_x/E_y # sens estimate
  var_p <- var_x_on_y(E_x, E_y, var_X, var_Y, cov_XY)

  return(trans_ci(p, var_p, trans_method = trans_method, ci_lvl = ci_lvl))

}
