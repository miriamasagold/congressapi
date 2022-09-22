
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

# congress_set_key()

# Retrieves all house bills from the 117th Congress
bill <- congressGet("bill/117/hr")

head(bill)
#>   congress number originChamber originChamberCode
#> 1      117     92         House                 H
#> 2      117     91         House                 H
#> 3      117   5809         House                 H
#> 4      117   5577         House                 H
#> 5      117   3539         House                 H
#> 6      117   3508         House                 H
#>                                                                                                                                                                                                   title
#> 1                         To designate the facility of the United States Postal Service located at 110 Johnson Street in Pickens, South Carolina, as the "Specialist Four Charles Johnson Post Office".
#> 2 To designate the facility of the United States Postal Service located at 810 South Pendleton Street in Easley, South Carolina, as the "Private First Class Barrett Lyle Austin Post Office Building".
#> 3       To designate the facility of the United States Postal Service located at 1801 Town and Country Drive in Norco, California, as the "Lance Corporal Kareem Nikoui Memorial Post Office Building".
#> 4                                  To designate the facility of the United States Postal Service located at 3900 Crown Road Southwest in Atlanta, Georgia, as the "John R. Lewis Post Office Building".
#> 5                                    To designate the facility of the United States Postal Service located at 223 West Chalan Santo Papa in Hagatna, Guam, as the "Atanasio Taitano Perez Post Office".
#> 6                        To designate the facility of the United States Postal Service located at 39 West Main Street, in Honeoye Falls, New York, as the "CW4 Christian J. Koch Memorial Post Office".
#>   type updateDate updateDateIncludingText
#> 1   HR 2022-09-21    2022-09-21T15:05:49Z
#> 2   HR 2022-09-21    2022-09-21T15:05:12Z
#> 3   HR 2022-09-21    2022-09-21T15:17:31Z
#> 4   HR 2022-09-21    2022-09-21T15:17:03Z
#> 5   HR 2022-09-21    2022-09-21T15:13:36Z
#> 6   HR 2022-09-21    2022-09-21T15:13:12Z
#>                                                        url
#> 1   https://api.congress.gov/v3/bill/117/hr/92?format=json
#> 2   https://api.congress.gov/v3/bill/117/hr/91?format=json
#> 3 https://api.congress.gov/v3/bill/117/hr/5809?format=json
#> 4 https://api.congress.gov/v3/bill/117/hr/5577?format=json
#> 5 https://api.congress.gov/v3/bill/117/hr/3539?format=json
#> 6 https://api.congress.gov/v3/bill/117/hr/3508?format=json
#>   latestAction_actionDate
#> 1              2022-09-20
#> 2              2022-09-20
#> 3              2022-09-20
#> 4              2022-09-20
#> 5              2022-09-20
#> 6              2022-09-20
#>                                                                                 latestAction_text
#> 1 Passed Senate without amendment by Unanimous Consent. (consideration: CR S4876; text: CR S4876)
#> 2 Passed Senate without amendment by Unanimous Consent. (consideration: CR S4876; text: CR S4876)
#> 3 Passed Senate without amendment by Unanimous Consent. (consideration: CR S4876; text: CR S4876)
#> 4 Passed Senate without amendment by Unanimous Consent. (consideration: CR S4876; text: CR S4876)
#> 5 Passed Senate without amendment by Unanimous Consent. (consideration: CR S4876; text: CR S4876)
#> 6 Passed Senate without amendment by Unanimous Consent. (consideration: CR S4876; text: CR S4876)
#>   latestAction_actionTime
#> 1                    <NA>
#> 2                    <NA>
#> 3                    <NA>
#> 4                    <NA>
#> 5                    <NA>
#> 6                    <NA>
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
