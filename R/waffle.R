#' Waffle Visualization
#'
#' @param data a data.frame contains value for create the waffle
#' @param id the name of the column used to represent the group.
#' @param value column names for value.
#' @param label column names for label. If not provided, id is used as the label
#' by default.
#' @param total max value.
#' @param rows number of rows.
#' @param columns number of columns.
#' @param render "svg" (responsive) "html", or "canvas". "canvas" is well suited
#' for large data sets as it does not impact DOM tree depth, however you'll lose
#' the isomorphic rendering ability.
#' @param ... additional arguments.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param elementId element id of widgets
#'
#' @import htmlwidgets
#' @return a waffle calendar component
#' @export
#' @seealso \href{https://nivo.rocks/waffle/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' # generate data
#' data <- data.frame(
#'   id = c("men", "women", "children"),
#'   label = c("Men", "Women", "Children"),
#'   value = c(9, 13, 20),
#'   color = c("#468df3", "#ba72ff", "#a1cfff")
#' )
#'
#' # the simplest use
#' n_waffle(
#'   data = data,
#'   total = 100,
#'   rows = 18,
#'   columns = 14
#' )
#'
#' # render with customization.
#' n_waffle(
#'   data = data,
#'   total = 100,
#'   rows = 18,
#'   columns = 14,
#'   margin = list(
#'     top = 10,
#'     right = 10,
#'     bottom = 10,
#'     left = 120
#'   ),
#'   colors = list(scheme = "nivo"),
#'   borderColor = list(
#'     from = "color",
#'     modifiers = list(
#'       c("darker", 1.3)
#'     )
#'   ),
#'   animate = TRUE,
#'   motionStiffness = 90,
#'   motionDamping = 11,
#'   legends = list(
#'     list(
#'       anchor = "top-left",
#'       direction = "column",
#'       justify = FALSE,
#'       translateX = -100,
#'       translateY = 0,
#'       itemsSpacing = 4,
#'       itemWidth = 100,
#'       itemHeight = 20,
#'       itemDirection = "left-to-right",
#'       itemOpacity = 1,
#'       itemTextColor = "#777",
#'       symbolSize = 20,
#'       effects = list(
#'         list(
#'           on = "hover",
#'           style = list(
#'             itemTextColor = "#000",
#'             itemBackground = "#f7fafb"
#'           )
#'         )
#'       )
#'     )
#'   )
#' )
n_waffle <- function(
                     data,
                     id = NULL,
                     value = NULL,
                     label = NULL,
                     total,
                     rows,
                     columns,
                     render = c("svg", "html", "canvas"),
                     ...,
                     width = NULL,
                     height = NULL,
                     elementId = NULL) {
  render <- match.arg(render, c("svg", "html", "canvas"))

  if (missing(data) || missing(total) || missing(rows) || missing(columns)) {
    stop("missing required arguments: `data`, `total`, `rows` or `columns`.")
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
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      switch(
        render,
        canvas = {
          "ResponsiveWaffleCanvas"
        },
        html = {
          "ResponsiveWaffleHtml"
        },
        {
          "ResponsiveWaffle"
        }
      ),
      list(
        data = .data_list_generator(data),
        total = total,
        rows = rows,
        columns = columns,
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
