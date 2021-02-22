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

#' Convert data for scatter plot
#'
#' @param data dataset
#' @param x name of x column
#' @param y name of y column
#' @param group name of group (if possible)
#'
#' @noRd
#' @return a datas list for ScatterPlot
#' @keywords internal
.convert_data_scatter <- function(data, x, y, z, group) {
  # TODO more attribute should be accepted not only x,y,z, need refactor.
  if (is.null(z)) {
    is_sizing <- FALSE
  } else {
    is_sizing <- TRUE
  }

  if (is.null(group)) {
    series <- NA
    is_grouping <- FALSE
  } else {
    series <- unique(data[group])[[1]]
    is_grouping <- TRUE
  }

  result <- lapply(series, function(serie) {
    if (is_grouping) {
      x <- data[data[[group]] == serie, x]
      y <- data[data[[group]] == serie, y]
      z <- ifelse(
        is_sizing,
        data[data[[group]] == serie, z],
        rep(NA, nrow(data[data[[group]] == serie, ]))
      )
    } else {
      x <- data[, x]
      y <- data[, y]
      z <- ifelse(
        is_sizing,
        data[, z],
        rep(NA, nrow(data))
      )
    }

    list(
      id = serie,
      data = unname(
        mapply(
          function(x, y, z) {
            list(x = x, y = y, z = z)
          },
          x,
          y,
          z,
          SIMPLIFY = FALSE
        )
      )
    )
  })
  result
}
