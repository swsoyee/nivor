#' Voronoi Visualization
#'
#' Delaunay/Voronoi Tessellation.
#'
#' @param data a data.frame contains value for create the voronoi.
#' @param id column name of id.
#' @param x,y column names of x and y value.
#' @param ... additional arguments.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param elementId element id of widgets
#'
#' @import htmlwidgets
#' @return a nivo Voronoi component
#' @export
#' @seealso \href{https://nivo.rocks/voronoi/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' # generate data
#' data <- data.frame(
#'   id = 1:50,
#'   x = round(rexp(50) * 20, 0),
#'   y = round(rexp(50) * 20, 0)
#' )
#'
#' # the simplest use
#' n_voronoi(
#'   data = data,
#'   id = "id",
#'   x = "x",
#'   y = "y",
#'   xDomain = c(0, 100),
#'   yDomain = c(0, 100),
#'   enableLinks = TRUE,
#'   linkLineColor = "#cccccc",
#'   cellLineColor = "#c6432d",
#'   pointSize = 6,
#'   pointColor = "#c6432d"
#' )
n_voronoi <- function(
                      data,
                      id,
                      x,
                      y,
                      ...,
                      width = NULL,
                      height = NULL,
                      elementId = NULL) {
  if (missing(data)) {
    stop("missing required arguments: `data`.")
  }
  if (is.null(id)) {
    if (!"id" %in% names(data)) {
      stop(
        paste(
          "column `id` is missing,",
          "provide a column name to represent the `id`."
        )
      )
    }
  } else {
    data$id <- data[id]
  }
  if (missing(x)) {
    stop("column name of `x` should be passed in.")
  } else {
    data$x <- data[x]
  }
  if (missing(y)) {
    stop("column name of `y` should be passed in.")
  } else {
    data$y <- data[y]
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      "ResponsiveVoronoi",
      list(
        data = .data_list_generator(data),
        # assume extra arguments are props
        ...
      )
    )
  )

  # create widget
  htmlwidgets::createWidget(
    name = "calendar",
    component,
    width = width,
    height = height,
    package = "nivor",
    elementId = elementId
  )
}
