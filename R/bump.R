#' AreaBump Visualization
#'
#' The AreaBump chart is similar to the Bump chart, but instead of only showing
#' the ranking over time, it also shows the values on the y-axis. If you're only
#' interested in ranking, you can also you use the Bump component.
#'
#' @param data data set in data.frame.
#' @param series,x column names of series and x value. if not provided, it will
#' use the first column as x value, and others as series.
#' @param ... additional arguments.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param element_id element id of widgets.
#'
#' @import htmlwidgets
#' @return a nivo AreaBump component
#' @export
#' @seealso \href{https://nivo.rocks/area-bump/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' # generate data
#' data <- data.frame(
#'   year = 2000:2005,
#'   JavaScript = runif(6, min = 0, max = 50),
#'   ReasonML = runif(6, min = 0, max = 50),
#'   TypeScript = runif(6, min = 0, max = 50),
#'   Elm = runif(6, min = 0, max = 50),
#'   CoffeeScript = runif(6, min = 0, max = 50)
#' )
#'
#' # the simplest use
#' n_area_bump(data)
#'
#' # an example of a slightly more complex setup
#' n_area_bump(
#'   data = data,
#'   margin = list(
#'     top = 40,
#'     right = 100,
#'     bottom = 40,
#'     left = 100
#'   ),
#'   spacing = 8,
#'   colors = list(
#'     scheme = "nivo"
#'   ),
#'   blendMode = "multiply",
#'   startLabel = "id",
#'   defs = list(
#'     list(
#'       id = "dots",
#'       type = "patternDots",
#'       background = "inherit",
#'       color = "#38bcb2",
#'       size = 4,
#'       padding = 1,
#'       stagger = TRUE
#'     ),
#'     list(
#'       id = "lines",
#'       type = "patternLines",
#'       background = "inherit",
#'       color = "#eed312",
#'       rotation = -45,
#'       lineWidth = 6,
#'       spacing = 10
#'     )
#'   ),
#'   fill = list(
#'     list(
#'       match = list(
#'         id = "CoffeeScript"
#'       ),
#'       id = "dots"
#'     ),
#'     list(
#'       match = list(
#'         id = "TypeScript"
#'       ),
#'       id = "lines"
#'     )
#'   ),
#'   axisTop = list(
#'     tickSize = 5,
#'     tickPadding = 5,
#'     tickRotation = 0,
#'     legend = "",
#'     legendPosition = "middle",
#'     legendOffset = -36
#'   ),
#'   axisBottom = list(
#'     tickSize = 5,
#'     tickPadding = 5,
#'     tickRotation = 0,
#'     legend = "",
#'     legendPosition = "middle",
#'     legendOffset = 32
#'   )
#' )
n_area_bump <- function(
                        data = NULL,
                        series = NULL,
                        x = NULL,
                        ...,
                        width = NULL,
                        height = NULL,
                        element_id = NULL) {

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      "ResponsiveAreaBump",
      list(
        data = .convert_data(data),
        # assume extra arguments are props
        ...
      )
    )
  )

  # create widget
  htmlwidgets::createWidget(
    name = "calendar", # TODO it's a bug, should be rename to nivo
    component,
    width = width,
    height = height,
    package = "nivor",
    elementId = element_id
  )
}


#' Bump Visualization
#'
#' The Bump chart can be used to show the ranking of several series over time.
#' It is quite similar to line charts, but instead of graphing some measure on
#' the y-axis, it only shows the ranking of each serie at a given time.
#'
#' If you'd like to show the ranking and also graph the y-axis values, you can
#' also you use the AreaBump visualization.
#'
#' @param data data set in data.frame.
#' @param series,x column names of series and x value. if not provided, it will
#' use the first column as x value, and others as series.
#' @param ... additional arguments.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param element_id element id of widgets.
#'
#' @import htmlwidgets
#' @return a nivo Bump component
#' @export
#' @seealso \href{https://nivo.rocks/bump/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' # generate data
#'
#' # the simplest use
#' n_area_bump(data)
#'
#' # an example of a slightly more complex setup
n_bump <- function(
  data = NULL,
  series = NULL,
  x = NULL,
  ...,
  width = NULL,
  height = NULL,
  element_id = NULL) {

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      "ResponsiveBump",
      list(
        data = .convert_data(data),
        # assume extra arguments are props
        ...
      )
    )
  )

  # create widget
  htmlwidgets::createWidget(
    name = "calendar", # TODO it's a bug, should be rename to nivo
    component,
    width = width,
    height = height,
    package = "nivor",
    elementId = element_id
  )
}
