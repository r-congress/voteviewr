
<!-- README.md is generated from README.Rmd. Please edit that file -->

# voteviewr

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/r-congress/voteviewr.svg?branch=master)](https://travis-ci.org/r-congress/voteviewr)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/r-congress/voteviewr?branch=master&svg=true)](https://ci.appveyor.com/project/r-congress/voteviewr)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/voteviewr)](https://CRAN.R-project.org/package=voteviewr)
<!-- badges: end -->

Get data from [Voteview.com](https://voteview.com/data)

## Installation

You can install the released version of voteviewr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("voteviewr")
```

You can install the dev version of voteviewr from
[Github](https://github.com) with:

``` r
if (!requireNamespace("remotes")) {
  install.packages("remotes")
}
remotes::install_packages("r-congress/voteviewr")
```

## Import

Import Voteview data from the House and Senate for the 116th U.S.
Congress

``` r
## read using defaults (both chambers of current congress)
cng116 <- read_voteview()
```

or get data from the House and Senate separately for the 115th U.S.
Congress

``` r
## house 115th data
h115 <- read_voteview("house", 115)

## senate 115th data
s115 <- read_voteview("senate", "115th")
```

or specify a session of Congress

``` r
## both chambers of 99th Congress
cng99 <- read_voteview(99)

##
cng99 <- read_voteview(99, "senate")
```

or specify a year

``` r
## get data on the 99th Congress
cng1961 <- read_voteview(1961)
```

## Data

A tibble is returned

``` r
## preview tibble
cng116
#> # A tibble: 538 x 23
#>    congress chamber icpsr state_icpsr district_code state_abbrev party_code occupancy
#>       <dbl> <chr>   <dbl>       <dbl>         <dbl> <chr>             <dbl> <lgl>    
#>  1      116 House   20301          41             3 AL                  200 NA       
#>  2      116 House   21102          41             7 AL                  100 NA       
#>  3      116 House   21192          41             2 AL                  200 NA       
#>  4      116 House   21193          41             5 AL                  200 NA       
#>  5      116 House   21376          41             1 AL                  200 NA       
#>  6      116 House   21500          41             6 AL                  200 NA       
#>  7      116 House   29701          41             4 AL                  200 NA       
#>  8      116 House   14066          81             1 AK                  200 NA       
#>  9      116 House   20305          61             3 AZ                  100 NA       
#> 10      116 House   20902          61             2 AZ                  100 NA       
#> # … with 528 more rows, and 15 more variables: last_means <lgl>, bioname <chr>,
#> #   bioguide_id <chr>, born <dbl>, died <lgl>, nominate_dim1 <dbl>, nominate_dim2 <dbl>,
#> #   nominate_log_likelihood <dbl>, nominate_geo_mean_probability <dbl>,
#> #   nominate_number_of_votes <dbl>, nominate_number_of_errors <dbl>, conditional <lgl>,
#> #   nokken_poole_dim1 <dbl>, nokken_poole_dim2 <dbl>, .timestamp <dttm>
```

More info on all returned variables

``` r
## view object structure
str(cng116)
#> Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 538 obs. of  23 variables:
#>  $ congress                     : num  116 116 116 116 116 116 116 116 116 116 ...
#>  $ chamber                      : chr  "House" "House" "House" "House" ...
#>  $ icpsr                        : num  20301 21102 21192 21193 21376 ...
#>  $ state_icpsr                  : num  41 41 41 41 41 41 41 81 61 61 ...
#>  $ district_code                : num  3 7 2 5 1 6 4 1 3 2 ...
#>  $ state_abbrev                 : chr  "AL" "AL" "AL" "AL" ...
#>  $ party_code                   : num  200 100 200 200 200 200 200 200 100 100 ...
#>  $ occupancy                    : logi  NA NA NA NA NA NA ...
#>  $ last_means                   : logi  NA NA NA NA NA NA ...
#>  $ bioname                      : chr  "ROGERS, Mike Dennis" "SEWELL, Terri" "ROBY, Martha" "BROOKS, Mo" ...
#>  $ bioguide_id                  : chr  "R000575" "S001185" "R000591" "B001274" ...
#>  $ born                         : num  1958 1965 1976 1954 1955 ...
#>  $ died                         : logi  NA NA NA NA NA NA ...
#>  $ nominate_dim1                : num  0.352 -0.39 0.361 0.644 0.606 0.715 0.366 0.284 -0.599 -0.161 ...
#>  $ nominate_dim2                : num  0.459 0.401 0.658 -0.45 0.253 -0.046 0.594 0.023 -0.252 -0.008 ...
#>  $ nominate_log_likelihood      : num  -141.2 -22.3 -78.6 -107.4 -92.7 ...
#>  $ nominate_geo_mean_probability: num  0.759 0.959 0.859 0.818 0.839 ...
#>  $ nominate_number_of_votes     : num  512 536 517 533 527 537 530 519 515 508 ...
#>  $ nominate_number_of_errors    : num  60 9 27 45 35 35 32 51 7 17 ...
#>  $ conditional                  : logi  NA NA NA NA NA NA ...
#>  $ nokken_poole_dim1            : num  0.534 -0.408 0.339 0.781 0.708 0.666 0.422 0.353 -0.629 -0.369 ...
#>  $ nokken_poole_dim2            : num  0.38 0.353 0.668 -0.4 0.149 0.124 0.657 0.178 -0.646 0.476 ...
#>  $ .timestamp                   : POSIXct, format: "2019-11-22 23:49:27" "2019-11-22 23:49:27" ...
#>  - attr(*, "spec")=
#>   .. cols(
#>   ..   congress = col_double(),
#>   ..   chamber = col_character(),
#>   ..   icpsr = col_double(),
#>   ..   state_icpsr = col_double(),
#>   ..   district_code = col_double(),
#>   ..   state_abbrev = col_character(),
#>   ..   party_code = col_double(),
#>   ..   occupancy = col_logical(),
#>   ..   last_means = col_logical(),
#>   ..   bioname = col_character(),
#>   ..   bioguide_id = col_character(),
#>   ..   born = col_double(),
#>   ..   died = col_logical(),
#>   ..   nominate_dim1 = col_double(),
#>   ..   nominate_dim2 = col_double(),
#>   ..   nominate_log_likelihood = col_double(),
#>   ..   nominate_geo_mean_probability = col_double(),
#>   ..   nominate_number_of_votes = col_double(),
#>   ..   nominate_number_of_errors = col_double(),
#>   ..   conditional = col_logical(),
#>   ..   nokken_poole_dim1 = col_double(),
#>   ..   nokken_poole_dim2 = col_double()
#>   .. )
```
