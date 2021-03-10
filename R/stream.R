#' Stream chart
#'
#' @param data a data.frame contains value for create the stream chart
#' @param keys column names of series.
#' @param ... additional arguments.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param elementId element id of widgets
#'
#' @import htmlwidgets
#' @return a sStream component
#' @export
#' @seealso \href{https://nivo.rocks/stream/}{Additional
#' arguments}
#'
#' @examples
#' library(nivor)
#'
#' # the simplest usage
#' n_parallel_coordinates(data = iris)
#'
#' # generate data
#' set.seed(1)
#' data <- data.frame(
#'   temp = round(rexp(32) * 10, 0),
#'   cost = round(rexp(32) * 10000, 0),
#'   color = sample(c("red", "yellow", "green"), size = 32, replace = TRUE),
#'   target = sample(c("A", "B", "C", "D", "E"), size = 32, replace = TRUE),
#'   volume = round(rexp(32) * 3, 0)
#' )
#'
#' # use with default options
#' n_parallel_coordinates(data = data)
#'
#' # customized, only show four series
#' n_parallel_coordinates(
#'   data = data,
#'   variables = list(
#'     list(
#'       key = "temp", type = "linear",
#'       legend = "Temperature", legendPosition = "start", legendOffset = -20
#'     ),
#'     list(
#'       key = "cost", type = "linear", legend = "Cost", min = 0,
#'       legendOffset = -20
#'     ),
#'     list(key = "color", type = "point", padding = 1),
#'     list(key = "target", type = "point", values = c("A", "B", "D", "E"))
#'   )
#' )
n_stream <- function(
                     data,
                     keys,
                     ...,
                     width = NULL,
                     height = NULL,
                     elementId = NULL) {
  if (missing(data)) {
    stop("missing required arguments: `data`.")
  }
  if (missing(keys)) {
    stop("missing required arguments: `keys`.")
  }

  props <- list(
    data = .data_list_generator(data),
    keys = keys,
    ...
  )

  # TODO need refactor
  if (is.null(props$margin$top)) {
    props$margin$top <- 50
  }
  if (is.null(props$margin$right)) {
    props$margin$right <- 60
  }
  if (is.null(props$margin$bottom)) {
    props$margin$bottom <- 50
  }
  if (is.null(props$margin$left)) {
    props$margin$left <- 60
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      "ResponsiveStream",
      props
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
