#' Parallel coordinates chart
#'
#' Parallel coordinates chart, supports continuous numerical variables and
#' discrete values.
#'
#' @param data a data.frame contains value for create the pie
#' @param variables variables configuration.
#' @param render "svg" (responsive) or "canvas". "canvas" is well suited
#' for large data sets as it does not impact DOM tree depth, however you'll lose
#' the isomorphic rendering ability.
#' @param ... additional arguments.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param elementId element id of widgets
#'
#' @import htmlwidgets
#' @return a parallel coordinates component
#' @export
#' @seealso \href{https://nivo.rocks/parallel-coordinates/}{Additional
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
n_parallel_coordinates <- function(
                                   data,
                                   variables,
                                   render = c("svg", "canvas"),
                                   ...,
                                   width = NULL,
                                   height = NULL,
                                   elementId = NULL) {
  render <- match.arg(render, c("svg", "canvas"))

  if (missing(data)) {
    stop("missing required arguments: `data`.")
  }
  if (missing(variables)) {
    variables <- lapply(colnames(data), function(key) {
      list(
        key = key,
        type = ifelse(
          NA %in% suppressWarnings(as.numeric(as.character(data[[key]]))),
          "point",
          "linear"
        ),
        min = "auto",
        max = "auto",
        ticksPosition = "before",
        legend = key,
        legendPosition = "start",
        legendOffset = 20
      )
    })
  }

  props <- list(
    data = .data_list_generator(data),
    variables = variables,
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
      switch(
        render,
        canvas = {
          "ResponsiveParallelCoordinatesCanvas"
        },
        {
          "ResponsiveParallelCoordinates"
        }
      ),
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
