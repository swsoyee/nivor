#' Chord Visualization
#'
#' Chord diagram.
#'
#' @param data data set in data.frame.
#' @param matrix a matrix used to compute the chord diagram.
#' @param keys keys used to identify each cell in the matrix.
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
#' @return a nivo Chord component
#' @export
#' @seealso \href{https://nivo.rocks/chord/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' # generate data
#' set.seed(1)
#' data <- matrix(round(rexp(25) * 100, 0), 5, 5)
#'
#' # the simplest use
#' n_chord(
#'   matrix = data,
#'   keys = c("A", "B", "C", "D", "E")
#' )
n_chord <- function(
  matrix,
  keys,
  render = c("svg", "canvas"),
  ...,
  width = NULL,
  height = NULL,
  element_id = NULL) {
  render <- match.arg(render, c("svg", "canvas"))

  if (missing(matrix)) {
    stop("matrix should be passed in.")
  }
  if (!(is.matrix(matrix) || is.data.frame(matrix))) {
    stop("matrix only accepte a matrix or data.frame.")
  }
  if (nrow(matrix) != ncol(matrix)) {
    stop("row and column are not equal in matrix.")
  }
  if (nrow(matrix) != length(keys)) {
    stop("keys and dimension of matrix are not equal.")
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      ifelse(
        render == "canvas",
        "ResponsiveChordCanvas",
        "ResponsiveChord"
      ),
      list(
        matrix = unname(as.list(as.data.frame(matrix))),
        keys = keys,
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
