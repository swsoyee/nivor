describe("n_chord()", {
  it("matrix is not matrix", {
    data <- 1
    expected <- "matrix only accepte a matrix or data.frame."
    expect_error(n_chord(data), expected)
  })

  it("matrix dimension are not equal", {
    data <- matrix(round(rexp(20) * 100, 0), 5, 4)
    expected <- "row and column are not equal in matrix."
    expect_error(n_chord(data), expected)
  })

  it("matrix dimension and keys are not equal", {
    data <- matrix(round(rexp(25) * 100, 0), 5, 5)
    keys <- "a"
    expected <- "keys and dimension of matrix are not equal."
    expect_error(n_chord(data, keys), expected)
  })
})
