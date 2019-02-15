# create summary statistics given a marginal 2-D array and a 3-D resolver array
# arrays can be generated from get_marg_array() and get_rslv_array() using data in a
# data frame with index, imperfect, resolver columns and observations in the rows.
table_crs <- function(marg, rslv, trans_method = "probit", alpha = 0.05) {

  n_trans <- length(trans_method)
  table_sens <- get_crs_sens(marg, rslv, trans_method = trans_method, ci_lvl = 1 - alpha)
  table_sens <- bind_cols(tibble(param = rep("sens", n_trans)), table_sens)
  table_spec <- get_crs_spec(marg, rslv, trans_method = trans_method, ci_lvl = 1 - alpha)
  table_spec <- bind_cols(tibble(param = rep("spec", n_trans)), table_spec)


  return(
    bind_rows(
      table_sens,
      table_spec
    )
  )

}
