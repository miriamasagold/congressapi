
<!-- README.md is generated from README.Rmd. Please edit that file -->

# congressapi

<!-- badges: start -->

[![R-CMD-check](https://github.com/AMGold99/congressapi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/AMGold99/congressapi/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->
<img src='man/figures/README-hexsticker.svg' align="right" height="138.5" />

**congressapi** provides an extremely lightweight wrapper, facilitating
seamless data retrieval from the [official Congress
API](https://api.congress.gov/) via a single function, `congressGet()`.

## Installation

You can install the development version of **congressapi** from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("miriamasagold/congressapi")
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
# Retrieves all house bills from the 117th Congress
bill <- 
    dplyr::tibble(
      congressapi::congressGet("bill/117/hr")
      )

head(bill)
#> # A tibble: 6 x 12
#>   congress number originChamber originChamberCode title         type  updateDate
#>      <int> <chr>  <chr>         <chr>             <chr>         <chr> <chr>     
#> 1      117 8966   House         H                 To clarify r~ HR    2022-09-24
#> 2      117 8965   House         H                 To amend the~ HR    2022-09-24
#> 3      117 8949   House         H                 To amend the~ HR    2022-09-24
#> 4      117 5768   House         H                 VICTIM Act o~ HR    2022-09-24
#> 5      117 4118   House         H                 Break the Cy~ HR    2022-09-24
#> 6      117 7846   House         H                 Veterans’ Co~ HR    2022-09-24
#> # ... with 5 more variables: updateDateIncludingText <chr>, url <chr>,
#> #   latestAction_actionDate <chr>, latestAction_text <chr>,
#> #   latestAction_actionTime <chr>
```

Visit <https://miriamasagold.github.io/congressapi/> to read full
package documentation. If you find a bug or would like to see a new
functionality, please submit an
[issue](https://github.com/miriamasagold/congressapi/issues).

# Note

This project is not endorsed or sponsered by the United States Congress.
