describe("n_options()", {
  it("Only use default setting", {
    expected <- list(
      width = 800,
      height = 400,
      margin = list(
        top = 30,
        right = 30,
        bottom = 60,
        left = 80
      )
    )
    expect_equal(
      n_options(),
      expected
    )
  })

  it("Overwrite same options", {
    expected <- list(
      width = 800,
      height = 500,
      margin = list(
        top = 30,
        right = 30,
        bottom = 60,
        left = 80
      )
    )
    expect_equal(
      sort(unlist(n_options(height = 500))),
      sort(unlist(expected))
    )
  })

  it("Add new options", {
    expected <- list(
      width = 800,
      height = 400,
      margin = list(
        top = 30,
        right = 30,
        bottom = 60,
        left = 80
      ),
      other = "other",
      nested = list(
        other = "other"
      )
    )
    expect_equal(
      sort(unlist(n_options(other = "other", nested = list(other = "other")))),
      sort(unlist(expected))
    )
  })
})
