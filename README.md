# crs

CRS: Composite Reference Standard in [`R`](https://cran.r-project.org/)

## Purpose


The functions are written to perform sensitivity and specificity calculations using CRS for any binary outcome (and produce valid confidence intervals).



The main function `perform_crs(...)` takes in a dataset containing one row per sample and at least three columns that represent the index text, imperfect truth and the resolver. The index test and the imperfect truth are expected to have no missing values, however as per the method, the resolver column may contain missing (`NA`) values as not every sample is expected to have a resolver result.

Details are available in the paper:
[Clinical evaluation of APAS Independence: automated imaging and interpretation of urine cultures using artificial intelligence with composite reference standard discrepant resolution ](https://notavailableyetsorry.com/). 

Additional background information on CRS can be found in [Hawkins et al. (2001)](https://www.ncbi.nlm.nih.gov/pubmed/11427955/) and [Alonzo and Pepe (1999)](https://www.ncbi.nlm.nih.gov/pubmed/10544302/). 


# Installation
To install and load in R, run:
```R
library(devtools) # see http://cran.r-project.org/web/packages/devtools/README.html
devtools::install_github('tystan/crs')
library(crs)
```

## Help
```r
### see help file to run example
?perform_crs
```

A PDF manual of the function descriptions is included in the repository here: [/inst/doc/crs-help.pdf](https://github.com/tystan/crs/blob/master/inst/doc/crs-help.pdf).



# Example usage

You can reproduce the analysis in Brenton et al. (2019). First load one of the dataframes that come with the package: `brenton2019`.

```R
data(brenton2019) # load data from Brenton et al. (2019)
?brenton2019      # will bring up a description of the data
brenton2019       # have a look at data
## A tibble: 881 x 3
##       A     S     P
##   <int> <int> <int>
## 1     1     1    NA
## 2     1     1    NA
## 3     2     2    NA
## 4     2     2    NA
## 5     2     1     2
## 6     1     1     1
## 7     1     1     1
## 8     1     1    NA
## 9     1     1    NA
##10     1     1     1
## ... with 871 more rows
```

To run CRS, pass the data (or any dataset in the required form) to the `perform_crs()` function.

```r
# run CRS analysis on brenton2019 data
perform_crs(
  brenton2019,       # data
  index     =  "A",  # index test
  imperfect =  "S",  # imperfect truth
  resolver  =  "P"   # resolver test (with NAs present)
)
```

The resulting output:

|param |     p|   var_p|   se_p|trans  |  p_lo|  p_up|
|:-----|-----:|-------:|------:|:------|-----:|-----:|
|sens  | 0.919| 0.00031| 0.0176|probit | 0.879| 0.948|
|spec  | 0.877| 0.00051| 0.0226|probit | 0.827| 0.916|


You can also recreate the results of [Hawkins et al. (2001)](https://www.ncbi.nlm.nih.gov/pubmed/11427955/) by running the below.


```R
data(hawkins2001) # load data from Hawkins et al. (2001)
hawkins2001       # have a look at data
# run CRS analysis on hawkins2001 data
perform_crs(
  hawkins2001,             # data
  index     =  "index",    # index test column in the data
  imperfect =  "ref",      # imperfect truth column in the data
  resolver  =  "resolve"   # resolver test column in the data (with NAs present)
)
```

|param |     p|    var_p|    se_p|trans  |  p_lo|  p_up|
|:-----|-----:|--------:|-------:|:------|-----:|-----:|
|sens  | 0.975| 0.000032| 0.00567|probit | 0.962| 0.984|
|spec  | 0.550| 0.000922| 0.03036|probit | 0.490| 0.609|


## Comparison to sensitivity and specificity calculations using the imperfect truth only

CRS can be compared to the index test against the imperfect truth by using the `get_sens_spec()` function.

For the `brenton2019` data:

```r
# the sens+spec estimates using the imperfect truth only
get_sens_spec(
  table(brenton2019[["S"]], brenton2019[["A"]])
)
```

|param | cases| correct|   est|    lo|    up|
|:-----|-----:|-------:|-----:|-----:|-----:|
|sens  |   449|     423| 0.942| 0.917| 0.960|
|spec  |   432|     342| 0.792| 0.751| 0.827|



Similarly, for the `hawkins2001` data:

```r
# the sens+spec estimates using the imperfect truth only
get_sens_spec(
  table(hawkins2001[["ref"]], hawkins2001[["index"]])
)
```

|param | cases| correct|   est|    lo|    up|
|:-----|-----:|-------:|-----:|-----:|-----:|
|sens  |  2000|    1800| 0.900| 0.886| 0.912|
|spec  |  1000|     400| 0.400| 0.370| 0.431|



# Referencing this work

Please run the following to get citation information when referencing this code.
```r
citation("crs")
```

<!--- ![](https://github.com/tystan/crs/blob/master/example.png) --->

