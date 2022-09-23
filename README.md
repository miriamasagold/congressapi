
<!-- README.md is generated from README.Rmd. Please edit that file -->

# congressapi

<!-- badges: start -->

[![R-CMD-check](https://github.com/AMGold99/congressapi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/AMGold99/congressapi/actions/workflows/R-CMD-check.yaml)
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

# Retrieves all house bills from the 117th Congress
bill <- 
    dplyr::tibble(
      congressapi::congressGet("bill/117/hr")
      )

head(bill)
#> # A tibble: 6 x 12
#>   congress number originChamber originChamberCode title         type  updateDate
#>      <int> <chr>  <chr>         <chr>             <chr>         <chr> <chr>     
#> 1      117 5768   House         H                 VICTIM Act o~ HR    2022-09-23
#> 2      117 4118   House         H                 Break the Cy~ HR    2022-09-23
#> 3      117 7846   House         H                 Veterans’ Co~ HR    2022-09-23
#> 4      117 8542   House         H                 Mental Healt~ HR    2022-09-23
#> 5      117 6448   House         H                 Invest to Pr~ HR    2022-09-23
#> 6      117 6833   House         H                 Affordable I~ HR    2022-09-23
#> # ... with 5 more variables: updateDateIncludingText <chr>, url <chr>,
#> #   latestAction_actionDate <chr>, latestAction_actionTime <chr>,
#> #   latestAction_text <chr>
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
