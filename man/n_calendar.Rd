% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calendar.R
\name{n_calendar}
\alias{n_calendar}
\title{Calendar Visualization}
\usage{
n_calendar(
  data = NULL,
  day = NULL,
  value = NULL,
  from = NULL,
  to = NULL,
  render = c("svg", "canvas"),
  ...,
  width = NULL,
  height = NULL,
  elementId = NULL
)
}
\arguments{
\item{data}{a data.frame contains day and value for create the calendar.}

\item{day, value}{column names of day and value. if not provided, it will use
the first column as day, and the second column as value.}

\item{from}{start date.}

\item{to}{end date.}

\item{render}{"svg" (responsive) or "canvas". "canvas" is well suited for
large data sets as it does not impact DOM tree depth, however you'll lose the
isomorphic rendering ability.}

\item{...}{additional arguments.}

\item{width, height}{Must be a valid CSS unit (like \code{'100\%'},
\code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
string and have \code{'px'} appended.}

\item{elementId}{element id of widgets}
}
\value{
a nivo calendar component
}
\description{
Calendar Visualization
}
\examples{
library(nivor)

# generate data
df <- data.frame(
  day = seq.Date(
    from = as.Date("2016-08-23"),
    length.out = 1500,
    by = "days"
  ),
  value = round(runif(1500) * 1000, 0)
)

# render in responsive (svg) with style.
n_calendar(
  data = df,
  from = "2016-01-01",
  to = "2019-12-31",
  colors = c("#d6e685", "#8cc665", "#44a340", "#1e6823")
)

# render in canvas with customization.
n_calendar(
  df,
  render = "canvas",
  emptyColor = "#aa7942",
  from = "2016-01-01",
  to = "2021-12-31",
  colors = c("#61cdbb", "#97e3d5", "#e8c1a0", "#f47560"),
  margin = list(top = 40, right = 40, bottom = 50, left = 40),
  direction = "vertical",
  monthBorderColor = "#ffffff",
  dayBorderWidth = 0,
  dayBorderColor = "#ffffff",
  legends = list(
    list(
      anchor = "bottom-right",
      direction = "row",
      translateY = 36,
      itemCount = 4,
      itemWidth = 42,
      itemHeight = 36,
      itemsSpacing = 14,
      itemDirection = "right-to-left"
    )
  )
)
}
\seealso{
\href{https://nivo.rocks/calendar/}{Additional arguments}
}
