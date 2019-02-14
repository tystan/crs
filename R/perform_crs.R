globalVariables(c(
  "param", "est", "lo", "up"
))

#' Perform CRS sens and spec calulations using a one sample-per-row input dataset
#'
#' @author Ty Stanford <tyman@lbtinnovations.com>
#' @description Performs the CRS analysis
#' @param dat data frame that contains the index test, imperfect truth and resolver columns (see details)
#' @param index string of column name in \code{dat} corresponding to the index test (1=negative, 2=positive)
#' @param imperfect string of column name in \code{dat} corresponding to the imperfect truth (1=negative, 2=positive)
#' @param resolver string of column name in \code{dat} corresponding to the resolver (1=negative, 2=positive, NA=not known)
#' @param trans_method one of "probit" (default), "logit", "loglog", "arcsin"
#' @param alpha confidence level (default=0.05)
#' @return A tibble with columns \code{param}, \code{p}, \code{var_p}, \code{se_p}, \code{p_lo}, \code{p_up}
#' @details Currently \code{perform_mcrs} requires \code{dat} to contain variables with negative and positive values as
#'     the integers \code{1}=negative and \code{2}=positive
#' @export
#' @examples
#' library(tibble)
#' data(brenton2019)
#' perform_crs(brenton2019, "A", "S", "P")


perform_crs <-
  function(
    dat,
    index, imperfect, resolver,
    trans_method = "probit",
    alpha = 0.05
  ) {

    check_col(dat, c(index, imperfect, resolver))

    marg <- get_marg_array(dat, index = index, imperfect = imperfect)
    rslv <- get_rslv_array(dat, index = index, imperfect = imperfect, resolver = resolver)
    crs <- table_crs(marg, rslv, trans_method = trans_method)
    crs


  }
