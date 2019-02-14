# create a 3-D array of the counts of index (first dim), imperfect truth (second dim) and
# resolver (third dim) combinations
# records where the resolver value is not present (i.e., NA) are discarded
get_rslv_array <- function(dat, index, imperfect, resolver) {
  dat_na_rm <- dat[!is.na(resolver), ]
  rslv <- table(dat_na_rm[[index]], dat_na_rm[[imperfect]], dat_na_rm[[resolver]])
  return(rslv)
}
