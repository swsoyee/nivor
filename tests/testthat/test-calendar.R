describe("calendar()", {
  df <- data.frame(
    day = seq.Date(
      from = as.Date("2020-04-01"),
      length.out = 600,
      by = "days"
    ),
    value = round(runif(600) * 1000, 0)
  )

  expect_visible(n_calendar(df))
})
