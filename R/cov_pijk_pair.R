
# idxs as a vector of indexes where:
# 1 = (1,1)
# 2 = (2,1)
# 3 = (1,2)
# 4 = (2,2)
cov_pijk_pair <- function(idxs, p_ij_dot, r_ij, n) {

  if (length(idxs) != 2)
    stop("This function only computes pairwise covariance")

  i1 <- idxs[1]
  i2 <- idxs[2]

  return(-p_ij_dot[i1] * p_ij_dot[i2] * r_ij[i1] * r_ij[i2] / n)

}
