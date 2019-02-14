
# create a 2-D array of the marginal counts of index (rows) vs imperfect truth (cols)
# i.e. is marginal with respect to the resolver values
get_marg_array <- function(dat, index, imperfect)
  return(table(dat[[index]], dat[[imperfect]]))
