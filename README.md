
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

~~You can install the released version of nivor from
[CRAN](https://CRAN.R-project.org)~~ with:

``` r
# Give me a more time to make the first release!
# install.packages("nivor")
```

And the development version from
[GitHub](https://github.com/swsoyee/nivor) with:

``` r
# install.packages("devtools")
devtools::install_github("swsoyee/nivor")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(nivor)
```

### AreaBump

``` r
data <- data.frame(
  group = 2000:2005,
  "Serie 1" = c(3, 6, 2, 4, 1, 5),
  "Serie 2" = c(1, 4, 5, 2, 3, 6),
  "Serie 3" = c(2, 3, 1, 5, 6, 4),
  "Serie 4" = c(4, 1, 3, 6, 5, 2),
  "Serie 5" = c(6, 5, 4, 1, 2, 3),
  "Serie 6" = c(5, 2, 6, 3, 4, 1)
)

n_area_bump(data)
```

![AreaBump](man/figures/AreaBump.png)

### Bump

``` r
data <- data.frame(
  group = 2000:2005,
  "Serie 1" = c(3, 6, 2, 4, 1, 5),
  "Serie 2" = c(1, 4, 5, 2, 3, 6),
  "Serie 3" = c(2, 3, 1, 5, 6, 4),
  "Serie 4" = c(4, 1, 3, 6, 5, 2),
  "Serie 5" = c(6, 5, 4, 1, 2, 3),
  "Serie 6" = c(5, 2, 6, 3, 4, 1)
)

n_bump(data)
```

![Calendar](man/figures/Bump.png)

### Chord

``` r
set.seed(1)
data <- matrix(round(rexp(25) * 100, 0), 5, 5)

# the simplest use
n_chord(
  matrix = data,
  keys = c("A", "B", "C", "D", "E")
)
```

![Chord](man/figures/Chord.png)

### Scatter

``` r
n_scatter(
  data = iris,
  x = "Sepal.Width",
  y = "Sepal.Length",
  group = "Species"
)
```

![ScatterPlot](man/figures/ScatterPlot.png)

### Line

``` r
data <- data.frame(
  year = 2000:2005,
  JavaScript = runif(6, min = 0, max = 50),
  ReasonML = runif(6, min = 0, max = 50),
  TypeScript = runif(6, min = 0, max = 50),
  Elm = runif(6, min = 0, max = 50),
  CoffeeScript = runif(6, min = 0, max = 50)
)

n_line(data)
```

![Line](man/figures/Line.png)

### Calendar

``` r
df <- data.frame(
  day = seq.Date(
    from = as.Date("2020-04-01"),
    length.out = 600,
    by = "days"
  ),
  value = round(runif(600) * 1000, 0)
)

n_calendar(df)
```

![Calendar](man/figures/Calendar.png)

### Voronoi

``` r
data <- data.frame(
  id = 1:50,
  x = round(rexp(50) * 20, 0),
  y = round(rexp(50) * 20, 0)
)

n_voronoi(
  data = data,
  id = "id",
  x = "x",
  y = "y",
  xDomain = c(0, 100),
  yDomain = c(0, 100),
  enableLinks = TRUE,
  linkLineColor = "#cccccc",
  cellLineColor = "#c6432d",
  pointSize = 6,
  pointColor = "#c6432d"
)
```

![Voronoi](man/figures/Voronoi.png)

### Waffle

``` r
data <- data.frame(
  id = c("men", "women", "children"),
  label = c("Men", "Women", "Children"),
  value = c(12, 15, 30),
  color = c("#468df3", "#ba72ff", "#a1cfff")
)

n_waffle(
  data = data,
  total = 100,
  rows = 18,
  columns = 14
)
```

![Waffle](man/figures/Waffle.png)

## Code of Conduct

Please note that the nivor project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
