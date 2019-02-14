
trans_ci <- function(p, var_p, trans_method = "probit", ci_lvl = 0.95) {

  trans_names <- c("logit", "probit", "loglog", "arcsin")

  # match input argument to valid values
  trans_to_use <- pmatch(trans_method, trans_names)
  # remove mismatches
  trans_to_use <- trans_to_use[!is.na(trans_to_use)]
  # use strings not indexes for use later on
  trans_to_use <- trans_names[trans_to_use]

  if (length(trans_to_use) == 0)
    stop(
      "No valid transformation specified. Valid transformations are",
      paste(trans_names, collapse = "|")
    )

  trans <- list(
    function(p) log(p/(1 - p)),
    function(p) qnorm(p),
    function(p) log(-log(1 - p)),
    function(p) asin(sqrt(p))
  )
  squared_deriv_of_trans <- list(
    function(p) 1 / (p * (1 - p)),
    function(p) 1 / dnorm(qnorm(p)),
    function(p) 1 / ((1 - p) * abs(log(1 - p))),
    function(p) 1 / (2 * sqrt(p * (1 - p)))
  )
  inv_trans <- list(
    function(x) exp(x) / (1 + exp(x)),
    function(x) pnorm(x),
    function(x) 1 - exp(-exp(x)),
    function(x) sin(x)^2
  )

  names(trans) <- names(squared_deriv_of_trans) <- names(inv_trans) <- trans_names

  foreach(method = trans_to_use, .combine = bind_rows) %do% {

    z_st <- -qnorm((1 - ci_lvl)/2)
    lambda <- trans[[method]](p)
    trans_ci <-
      lambda + c(-1, 1) * z_st * sqrt(var_p) * squared_deriv_of_trans[[method]](p)
    ci <- inv_trans[[method]](trans_ci)
    data_frame(
      p = p,
      var_p = var_p,
      se_p = sqrt(var_p),
      trans = method,
      trans_p = lambda,
      trans_ci_lo = trans_ci[1],
      trans_ci_up = trans_ci[2],
      p_lo = ci[1],
      p_up = ci[2]
    )

  }

}
