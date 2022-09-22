
<!-- README.md is generated from README.Rmd. Please edit that file -->

# congressapi

<!-- badges: start -->
<!-- badges: end -->

<img src='man/figures/README-hexsticker.svg' align="right" height="138.5" />

The goal of congressapi is to facilitate seamless data retrieval from
the [official Congress API](https://api.congress.gov/) by providing a
single wrapper function, `congressGet()`.

## Installation

You can install the development version of **congressapi** from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("AMGold99/congressapi")
```

## Retrieving data

Data may be retrieved from one of eleven base endpoints:

-   bill
-   amendment
-   summaries
-   congress
-   member
-   committee
-   committeeReport
-   congressional-record
-   house-communication
-   nomination
-   treaty

All the user needs to do is specify the endpoint, along with any
additional specifications desired:

``` r
library(congressapi)
library(dplyr)
#> Warning: package 'dplyr' was built under R version 4.1.3
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(magrittr)
#> Warning: package 'magrittr' was built under R version 4.1.3

# congress_set_key()

# Retrieves all house bills from the 117th Congress
bill <- 
  congressGet("bill/117/hr") %>%
  dplyr::tibble()

head(bill)
#> # A tibble: 6 x 12
#>   congress number originChamber originChamberCode title         type  updateDate
#>      <int> <chr>  <chr>         <chr>             <chr>         <chr> <chr>     
#> 1      117 92     House         H                 "To designat~ HR    2022-09-21
#> 2      117 91     House         H                 "To designat~ HR    2022-09-21
#> 3      117 5809   House         H                 "To designat~ HR    2022-09-21
#> 4      117 5577   House         H                 "To designat~ HR    2022-09-21
#> 5      117 3539   House         H                 "To designat~ HR    2022-09-21
#> 6      117 3508   House         H                 "To designat~ HR    2022-09-21
#> # ... with 5 more variables: updateDateIncludingText <chr>, url <chr>,
#> #   latestAction_actionDate <chr>, latestAction_text <chr>,
#> #   latestAction_actionTime <chr>
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
