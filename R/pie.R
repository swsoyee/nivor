#' Pie Visualization
#'
#' @param data a data.frame contains value for create the pie
#' @param id the name of the column used to represent the group.
#' @param value column names for value.
#' @param label column names for label. If not provided, id is used as the label
#' by default.
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
#' @return a pie component
#' @export
#' @seealso \href{https://nivo.rocks/waffle/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' # generate data
#' set.seed(1)
#' data <- data.frame(
#'   id = c("Elixir", "Haskell", "Scala", "JavaScript", "Hack"),
#'   label = c("Elixir", "Haskell", "Scala", "JavaScript", "Hack"),
#'   value = round(rexp(5) * 100, 0),
#'   color = c(
#'     "hsl(208, 70%, 50%)",
#'     "hsl(275, 70%, 50%)",
#'     "hsl(141, 70%, 50%)",
#'     "hsl(104, 70%, 50%)",
#'     "hsl(119, 70%, 50%)"
#'   )
#' )
#'
#' # the simplest use
#' n_pie(data)
#'
#' # render with customization.
#' n_pie(
#'   data = data,
#'   margin = list(top = 40, right = 80, bottom = 80, left = 80),
#'   innerRadius = 0.5,
#'   padAngle = 0.7,
#'   cornerRadius = 3,
#'   colors = list(scheme = "nivo"),
#'   borderWidth = 1,
#'   borderColor = list(
#'     from = "color",
#'     modifiers = list(
#'       c("darker", 0.2)
#'     )
#'   ),
#'   radialLabelsSkipAngle = 10,
#'   radialLabelsTextColor = "#333333",
#'   radialLabelsLinkColor = list(
#'     from = "color"
#'   ),
#'   sliceLabelsSkipAngle = 10,
#'   sliceLabelsTextColor = "#333333",
#'   defs = list(
#'     list(
#'       id = "dots",
#'       type = "patternDots",
#'       background = "inherit",
#'       color = "rgba(255, 255, 255, 0.3)",
#'       size = 4,
#'       padding = 1,
#'       stagger = TRUE
#'     ),
#'     list(
#'       id = "lines",
#'       type = "patternLines",
#'       background = "inherit",
#'       color = "rgba(255, 255, 255, 0.3)",
#'       rotation = -45,
#'       lineWidth = 6,
#'       spacing = 10
#'     )
#'   ),
#'   fill = list(
#'     list(
#'       match = list(id = "JavaScript"),
#'       id = "dots"
#'     ),
#'     list(
#'       match = list(id = "Haskell"),
#'       id = "lines"
#'     )
#'   ),
#'   legends = list(
#'     list(
#'       anchor = "bottom",
#'       direction = "row",
#'       justify = FALSE,
#'       translateX = 0,
#'       translateY = 56,
#'       itemsSpacing = 0,
#'       itemWidth = 100,
#'       itemHeight = 18,
#'       itemTextColor = "#999",
#'       itemDirection = "left-to-right",
#'       itemOpacity = 1,
#'       symbolSize = 18,
#'       symbolShape = "circle",
#'       effects = list(
#'         list(
#'           on = "hover",
#'           style = list(
#'             itemTextColor = "#999"
#'           )
#'         )
#'       )
#'     )
#'   )
#' )
n_pie <- function(
  data,
  id = NULL,
  value = NULL,
  label = NULL,
  render = c("svg", "canvas"),
  ...,
  width = NULL,
  height = NULL,
  elementId = NULL) {
  render <- match.arg(render, c("svg", "canvas"))

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
  if (is.null(value)) {
    if (!"value" %in% names(data)) {
      stop(
        paste(
          "column `value` is missing,",
          "provide a column name to represent the `value`."
        )
      )
    }
  } else {
    data$value <- data[value]
  }
  if (is.null(label) && is.null(data$label)) {
    data$label <- data$id
  } else {
    data$id <- data$label
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      switch(
        render,
        canvas = {
          "ResponsivePieCanvas"
        },
        {
          "ResponsivePie"
        }
      ),
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
