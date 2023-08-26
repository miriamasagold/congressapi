
<!-- README.md is generated from README.Rmd. Please edit that file -->

# congressapi

<!-- badges: start -->

[![R-CMD-check](https://github.com/miriamasagold/congressapi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/miriamasagold/congressapi/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/miriamasagold/congressapi/branch/main/graph/badge.svg)](https://app.codecov.io/gh/miriamasagold/congressapi?branch=main)
<!-- badges: end -->
<img src='man/figures/logo.svg' align="right" height="138.5" />

**congressapi** provides an extremely lightweight wrapper, facilitating
seamless data retrieval from the [official Congress
API](https://api.congress.gov/) via a single function, `get_congress()`.

## Installation

You can install the development version of **congressapi** from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("miriamasagold/congressapi")
```

## Retrieving data

Data may be retrieved from one of eleven base endpoints:

- bill
- amendment
- summaries
- congress
- member
- committee
- committee-report
- congressional-record
- house-communication
- nomination
- treaty

All the user needs to do is specify the endpoint, along with any
additional specifications desired:

``` r
library(congressapi)
# Retrieves all house bills from the 117th Congress
bill <- 
    dplyr::tibble(
      congressapi::get_congress("bill/117/hr")
      )

head(bill)
#> # A tibble: 6 × 11
#>   congress number originChamber originChamberCode title         type  updateDate
#>      <int> <chr>  <chr>         <chr>             <chr>         <chr> <chr>     
#> 1      117 897    House         H                 Agua Calient… HR    2023-03-09
#> 2      117 7939   House         H                 Veterans Aut… HR    2023-08-02
#> 3      117 680    House         H                 For the reli… HR    2023-03-08
#> 4      117 1917   House         H                 Hazard Eligi… HR    2023-03-09
#> 5      117 1154   House         H                 Great Dismal… HR    2023-03-09
#> 6      117 1082   House         H                 Sami's Law    HR    2023-08-25
#> # ℹ 4 more variables: updateDateIncludingText <chr>, url <chr>,
#> #   latestAction_actionDate <chr>, latestAction_text <chr>
```

Visit <https://miriamasagold.github.io/congressapi/> to read full
package documentation. If you find a bug or would like to see a new
functionality, please submit an
[issue](https://github.com/miriamasagold/congressapi/issues).

# Note

This project is neither endorsed nor sponsored by the United States
Congress.
