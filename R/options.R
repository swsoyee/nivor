#' Add additional settings to the default
#'
#' @param default some common or default setting
#' @param ... additional options for nivo components
#'
#' @return a list contains settings for nivo components
#' @export
n_options <- function(default, ...) {
  if (missing(default)) {
    default <- list(
      width = 800,
      height = 400,
      margin = list(
        top = 30,
        right = 30,
        bottom = 60,
        left = 80
      )
    )
  }

  settings <- c(list(...), default)

  settings[!duplicated(names(settings))]
}
