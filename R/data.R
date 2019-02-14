#' Data from Benton et al. (2019)
#'
#' These are the data from from Benton et al. (2019) containing the APAS (A, the index test),
#' St Vincent's standard workflow (S, imperfect truth) and the panel consensus (P, resolver) variables.
#'
#' @format A data frame with 881 rows and 3 variables:
#' \describe{
#'   \item{A}{APAS values; \code{1}=not significan growth (0 and 10^6 CFU/L), \code{2}=significant growth (10^7 and 10^8+ CFU/L)}
#'   \item{S}{St Vincent's standard workflow values; \code{1}=not significan growth (0 and 10^6 CFU/L), \code{2}=significant growth (10^7 and 10^8+ CFU/L)}
#'   \item{P}{Panel consensus values; \code{1}=not significan growth (0 and 10^6 CFU/L), \code{2}=significant growth (10^7 and 10^8+ CFU/L)}
#' }
#' @docType data
#'
#' @usage data(brenton2019)
"brenton2019"


#' Representation of the data from Hawkins et al. (2001)
#'
#' These are a recreation of a sample line data that prodice the cross
#' tabulations seen in Hawkins et al. (2001) containing the index test (\code{index}),
#' reference (\code{ref}) and the resolver (\code{resolve}) variables.
#'
#' @format A data frame with 3,000 rows and 3 variables:
#' \describe{
#'   \item{index}{index test values; \code{1}=negative, \code{2}=positive}
#'   \item{ref}{Reference values; \code{1}=negative, \code{2}=positive}
#'   \item{resolve}{Resolver values; \code{1}=negative, \code{2}=positive}
#' }
#' @docType data
#'
#' @usage data(hawkins2001)
"hawkins2001"


