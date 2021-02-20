
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nivor

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/nivor)](https://CRAN.R-project.org/package=nivor)
[![Codecov test
coverage](https://codecov.io/gh/swsoyee/nivor/branch/main/graph/badge.svg)](https://codecov.io/gh/swsoyee/nivor?branch=main)
[![R-CMD-check](https://github.com/swsoyee/nivor/workflows/R-CMD-check/badge.svg)](https://github.com/swsoyee/nivor/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of nivor is to …

## Installation

You can install the released version of nivor from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("nivor")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(nivor)

# Calendar
df <- data.frame(
  day = seq.Date(
    from = as.Date("2020-04-01"),
    length.out = 600,
    by = "days"
  ),
  value = round(runif(600) * 1000, 0)
)

calendar(df)
```

![calendar](man/figures/calendar.png)

## Code of Conduct

Please note that the nivor project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
