#' Convert data for NIVO
#'
#' @param data a data set in data.frame.
#' @param series series name (column name). if not provided, use all column but
#' the first column.
#' @param x column name of x value. if not provided, use the first column.
#'
#' @noRd
#' @return data in list for NIVO visualization
#' @keywords internal
.convert_data <- function(data, series, x) {
  if (missing(data)) {
    stop("data should be passed in.")
  }

  # if serie id is not provided, use all column exclude the first column
  if (missing(series)) {
    series <- colnames(data)[2:(ncol(data))]
  }

  x <- data[, ifelse(missing(x), 1, x)]

  lapply(series, function(serie) {
    list(
      id = serie,
      data = mapply(
        function(x, y) {
          list(x = x, y = y)
        },
        x,
        data[, serie],
        SIMPLIFY = FALSE
      )
    )
  })
}
