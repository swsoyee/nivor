#' Calendar Visualization
#'
#' @param data a data.frame contains day and value for create the calendar.
#' @param day,value column names of day and value. if not provided, it will use
#' the first column as day, and the second column as value.
#' @param from start date
#' @param to end date
#' @param ... additional arguments
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param elementId element id of widgets
#'
#' @import htmlwidgets
#' @importFrom utils tail
#' @return a nivo calendar component
#' @export
#' @seealso \href{https://nivo.rocks/calendar/}{Additional arguments}
#'
#' @examples
#' library(nivor)
#'
#' df <- data.frame(
#'   day = seq.Date(
#'     from = as.Date("2020-04-01"),
#'     length.out = 600,
#'     by = "days"
#'   ),
#'   value = round(runif(600) * 1000, 0)
#' )
#'
#' calendar(df)
calendar <- function(
                    data = NULL,
                    day = NULL,
                    value = NULL,
                    from = NULL,
                    to = NULL,
                    ...,
                    width = NULL,
                    height = NULL,
                    elementId = NULL) {

  # if date and value column name are not provided, use the first column as
  # date, second one as value
  if (is.null(day)) day <- colnames(data)[1]
  if (is.null(value)) value <- colnames(data)[2]

  # from and to are required
  # assume first and last are from and to
  if (is.null(from)) from <- data[day][1, ]
  if (is.null(to)) to <- utils::tail(data, n = 1)[day][1, ]

  # convert data to array of objects or by row list of lists
  data <- mapply(
    function(day, value) {
      list(day = day, value = value)
    },
    data[day][[1]],
    data[value][[1]],
    SIMPLIFY = FALSE
  )

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      "ResponsiveCalendar",
      list(
        data = data,
        from = from,
        to = to,
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

#' Shiny bindings for calendar
#'
#' Output and render functions for using calendar within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a calendar
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#' @param id div id.
#' @param class class name.
#' @param style inline style.
#' @param ... additional arguments
#'
#' @name calendar-shiny
#'
#' @export
calendarOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "calendar",
    width,
    height,
    package = "nivor"
  )
}

#' @rdname calendar-shiny
#' @export
renderCalendar <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, calendarOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @rdname calendar-shiny
calendar_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}
