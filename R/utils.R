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

#' Convert value (data.frame) to a list of data value
#'
#' @param data value (data.frame)
#'
#' @noRd
#' @return a list of data value
#' @keywords internal
.data_list_generator <- function(data) {
  lapply(asplit(data, 1), function(element) {
    as.list(element)
  })
}

#' Convert data to a list of data property for React side
#'
#' @param data data set (data.frame)
#' @param value column name for create data list of value
#' @param group column name for attribute
#'
#' @noRd
#' @return a list of property for React side
#' @keywords internal
.data_prop_generator <- function(data, value, group = NULL) {
  result_list <- list()

  if (is.null(group)) {
    result_list[[1]] <- list(
      id = "1",
      data = .data_list_generator(data[, value, drop = FALSE])
    )
  } else {
    temp_list <- list()
    for (row_index in seq(nrow(data))) {
      temp_list[[row_index]] <- list(
        index = as.list(data[row_index, group, drop = FALSE]),
        data = as.list(data[row_index, value, drop = FALSE]),
        temp = lapply(
          as.list(data[row_index, group, drop = FALSE]),
          function(x) {
            as.character(x)
          }
        )
      )
    }
    # get unique group
    result_list <- .data_list_generator(data[, group, drop = FALSE])
    result_list <- unique(result_list)
    group_list <- result_list

    for (group_index in seq(length(result_list))) {
      for (data_index in seq(nrow(data))) {
        isPaired <- identical(
          group_list[[group_index]],
          temp_list[[data_index]]$temp
        )
        if (isPaired) {
          data_point <- result_list[[group_index]]$data
          # First time
          if (is.null(data_point)) {
            result_list[[group_index]]$data[[1]] <- temp_list[[data_index]]$data
          } else {
            this_index <- length(result_list[[group_index]]$data)
            result_list[[group_index]]$data[[this_index + 1]] <-
              temp_list[[data_index]]$data
          }
        }
      }
    }
  }
  result_list
}
