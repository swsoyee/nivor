#' ScatterPlot Visualization
#'
#' @param data data set in data.frame.
#' @param x,y column names of x, y and z (if any, for size) value.
#' @param entry_info column names of additional information for entries (point).
#' Used to set the label or the size of the point, etc.
#' @param group column name of group.
#' @param group_info column names of additional information for groups (serie).
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
#' @return a nivo ScatterPlot component
#' @export
#' @seealso \href{https://nivo.rocks/scatterplot/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' # the simplest use
#' n_scatter(
#'   data = iris,
#'   x = "Sepal.Width",
#'   y = "Sepal.Length",
#'   group = "Species"
#' )
#'
#' # an example of a slightly more complex setup
#' n_scatter(
#'   data = iris,
#'   x = "Sepal.Width",
#'   y = "Sepal.Length",
#'   group = "Species",
#'   margin = list(top = 60, right = 140, bottom = 70, left = 90),
#'   xFormat = htmlwidgets::JS('function(e){return e+" cm"}'),
#'   yFormat = htmlwidgets::JS('function(e){return e+" cm"}'),
#'   axisBottom = list(
#'     orient = "bottom",
#'     tickSize = 5,
#'     tickPadding = 5,
#'     tickRotation = 0,
#'     legend = "Sepal.Width",
#'     legendPosition = "middle",
#'     legendOffset = 46
#'   ),
#'   blendMode = "multiply",
#'   legends = list(
#'     list(
#'       anchor = "bottom-right",
#'       direction = "column",
#'       justify = FALSE,
#'       translateX = 130,
#'       translateY = 0,
#'       itemWidth = 100,
#'       itemHeight = 12,
#'       itemsSpacing = 5,
#'       itemDirection = "left-to-right",
#'       symbolSize = 12,
#'       symbolShape = "circle",
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
#'
#' # Set additional information as size for each point
#' n_scatter(
#'   data = iris,
#'   y = "Sepal.Width",
#'   x = "Sepal.Length",
#'   entry_info = "Petal.Length",
#'   group = "Species",
#'   nodeSize = list(
#'     key = "Petal.Length",
#'     values = list(0, 4),
#'     sizes = list(9, 32)
#'   )
#' )
n_scatter <- function(
                      data,
                      x,
                      y,
                      entry_info = NULL,
                      group = NULL,
                      group_info = NULL,
                      render = c("svg", "canvas"),
                      ...,
                      width = NULL,
                      height = NULL,
                      element_id = NULL) {
  render <- match.arg(render, c("svg", "canvas"))
  if (missing(data)) {
    stop("argument `data` should be passed in.")
  }
  if (missing(x)) {
    stop("argument `x` should be passed in.")
  }
  if (missing(y)) {
    stop("argument `y` should be passed in.")
  }
  if (sum(names(data) == "id") > 0) {
    message(
      paste0(
        "`data` already has id column, which may cause potential problems as ",
        "the `id` is a fixed field for grouping. If you find problems in the ",
        "results, we recommend that renaming the `id` column to try to ",
        "resolve the problem."
      )
    )
  }

  # rename the column to x, y, z
  names(data)[names(data) == x] <- "x"
  names(data)[names(data) == y] <- "y"

  if (!is.null(group)) {
    names(data)[names(data) == group] <- "id"
    group <- "id"
  }

  data <- .data_prop_generator(
    data,
    value = c("x", "y", entry_info),
    group = c(group, group_info)
  )

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      ifelse(
        render == "canvas",
        "ResponsiveScatterPlotCanvas",
        "ResponsiveScatterPlot"
      ),
      list(
        data = data,
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
