#' Convert data for NIVO
#'
#' @param data a data set in data.frame.
#' @param series series name (column name). if not provided, use all column but
#' the first column.
#' @param x column name of x value. if not provided, use the first column.
#' @param fill if TRUE, then expand the result list.
#'
#' @noRd
#' @return data in list for NIVO visualization
#' @keywords internal
.convert_data <- function(data, series, x, fill = FALSE) {
  if (missing(data)) {
    stop("data should be passed in.")
  }

  # if serie id is not provided, use all column exclude the first column
  if (missing(series)) {
    series <- colnames(data)[2:(ncol(data))]
  }

  x <- data[, ifelse(missing(x), 1, x)]

  result <- lapply(series, function(serie) {
    list(
      id = serie,
      data = unname(
        mapply(
          function(x, y) {
            list(x = x, y = y)
          },
          x,
          data[, serie],
          SIMPLIFY = FALSE
        )
      )
    )
  })

  if (fill) {
    difference <- abs(length(series) - length(x))
    while (difference) {
      result <- append(result, result[1])
      difference <- difference - 1
    }
  }
  result
}
