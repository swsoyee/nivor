#' Line Visualization
#'
#' Line chart with stacking ability.
#'
#' @param data data set in data.frame.
#' @param series,x column names of series and x value. if not provided, it will
#' use the first column as x value, and others as series.
#' @param render "svg" (responsive) or "canvas". "canvas" is well suited for
#' large data sets as it does not impact DOM tree depth, however you'll lose the
#' isomorphic rendering ability.
#' @param ... additional arguments.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param element_id element id of widgets.
#'
#' @import htmlwidgets
#' @return a nivo Line component
#' @export
#' @seealso \href{https://nivo.rocks/line/}{Additional arguments}
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
#' n_line(data)
#'
#' # an example of a slightly more complex setup
#' n_line(
#'   data = data,
#'   margin = list(
#'     top = 50,
#'     right = 110,
#'     bottom = 50,
#'     left = 60
#'   ),
#'   xScale = list(
#'     type = "point"
#'   ),
#'   yScale = list(
#'     type = "linear",
#'     min = "auto",
#'     max = "auto",
#'     stacked = TRUE,
#'     reverse = FALSE
#'   ),
#'   yFormat = " >-.2f",
#'   axisTop = NA,
#'   axisRight = NA,
#'   axisBottom = list(
#'     orient = "bottom",
#'     tickSize = 5,
#'     tickPadding = 5,
#'     tickRotation = 0,
#'     legend = "year",
#'     legendOffset = 36,
#'     legendPosition = "middle"
#'   ),
#'   axisLeft = list(
#'     orient = "left",
#'     tickSize = 5,
#'     tickPadding = 5,
#'     tickRotation = 0,
#'     legend = "count",
#'     legendOffset = -40,
#'     legendPosition = "middle"
#'   ),
#'   pointSize = 10,
#'   pointColor = list(
#'     theme = "background"
#'   ),
#'   pointBorderWidth = 2,
#'   pointBorderColor = list(
#'     from = "serieColor"
#'   ),
#'   pointLabelYOffset = -12,
#'   useMesh = TRUE,
#'   legends = list(
#'     list(
#'       anchor = "bottom-right",
#'       direction = "column",
#'       justify = FALSE,
#'       translateX = 100,
#'       translateY = 0,
#'       itemsSpacing = 0,
#'       itemDirection = "left-to-right",
#'       itemWidth = 80,
#'       itemHeight = 20,
#'       itemOpacity = 0.75,
#'       symbolSize = 12,
#'       symbolShape = "circle",
#'       symbolBorderColor = "rgba(0, 0, 0, .5)",
#'       effects = list(
#'         list(
#'           on = "hover",
#'           style = list(
#'             itemBackground = "rgba(0, 0, 0, .03)",
#'             itemOpacity = 1
#'           )
#'         )
#'       )
#'     )
#'   )
#' )
n_line <- function(
                   data = NULL,
                   series = NULL,
                   x = NULL,
                   render = c("svg", "canvas"),
                   ...,
                   width = NULL,
                   height = NULL,
                   element_id = NULL) {
  render <- match.arg(render, c("svg", "canvas"))

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      ifelse(
        render == "canvas",
        "ResponsiveLineCanvas",
        "ResponsiveLine"
      ),
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
