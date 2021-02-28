describe("n_waffle()", {
  data <- data.frame(
    id = c("men", "women", "children"),
    label = c("Men", "Women", "Children"),
    value = c(9, 13, 20),
    color = c("#468df3", "#ba72ff", "#a1cfff")
  )
  it("arguments check", {
    expect_error(
      n_waffle(),
      "missing required arguments: `data`, `total`, `rows` or `columns`."
    )

    data <- data.frame(
      idd = c("men", "women", "children"),
      lab = c("Men", "Women", "Children"),
      val = c(9, 13, 20),
      color = c("#468df3", "#ba72ff", "#a1cfff")
    )
    expect_error(
      n_waffle(data = data, total = 100, rows = 10, columns = 10),
      "column `id` is missing, provide a column name to represent the `id`."
    )
    expect_error(
      n_waffle(data = data, id = "idd", total = 100, rows = 10, columns = 10),
      "column `value` is missing, provide a column name to represent the `value`."
    )
  })
})
