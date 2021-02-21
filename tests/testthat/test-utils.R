describe(".convert_data()", {
  data <- data.frame(
    year = 2000:2005,
    JavaScript = c(45, 15, 20, 234, 12, 12),
    TypeScript = c(10, 456, 20, 234, 18, 56),
    CoffeeScript = c(12, 23, 24, 234, 12, 7)
  )

  it("Args checking", {
    expect_error(
      .convert_data(),
      "data should be passed in."
    )
  })

  it("Convertion is correct when only pass data.", {
    expeceted <- list(
      list(
        id = "JavaScript",
        data = list(
          list(
            x = 2000,
            y = 45
          ),
          list(
            x = 2001,
            y = 15
          ),
          list(
            x = 2002,
            y = 20
          ),
          list(
            x = 2003,
            y = 234
          ),
          list(
            x = 2004,
            y = 12
          ),
          list(
            x = 2005,
            y = 12
          )
        )
      ),
      list(
        id = "TypeScript",
        data = list(
          list(
            x = 2000,
            y = 10
          ),
          list(
            x = 2001,
            y = 456
          ),
          list(
            x = 2002,
            y = 20
          ),
          list(
            x = 2003,
            y = 234
          ),
          list(
            x = 2004,
            y = 18
          ),
          list(
            x = 2005,
            y = 56
          )
        )
      ),
      list(
        id = "CoffeeScript",
        data = list(
          list(
            x = 2000,
            y = 12
          ),
          list(
            x = 2001,
            y = 23
          ),
          list(
            x = 2002,
            y = 24
          ),
          list(
            x = 2003,
            y = 234
          ),
          list(
            x = 2004,
            y = 12
          ),
          list(
            x = 2005,
            y = 7
          )
        )
      )
    )

    expect_equal(.convert_data(data), expeceted)
  })

  it("Convertion is correct when x is character", {
    data <- data.frame(
      year = as.character(2000:2005),
      JavaScript = c(45, 15, 20, 234, 12, 12),
      TypeScript = c(10, 456, 20, 234, 18, 56),
      CoffeeScript = c(12, 23, 24, 234, 12, 7)
    )

    expeceted <- list(
      list(
        id = "JavaScript",
        data = list(
          list(
            x = "2000",
            y = 45
          ),
          list(
            x = "2001",
            y = 15
          ),
          list(
            x = "2002",
            y = 20
          ),
          list(
            x = "2003",
            y = 234
          ),
          list(
            x = "2004",
            y = 12
          ),
          list(
            x = "2005",
            y = 12
          )
        )
      ),
      list(
        id = "TypeScript",
        data = list(
          list(
            x = "2000",
            y = 10
          ),
          list(
            x = "2001",
            y = 456
          ),
          list(
            x = "2002",
            y = 20
          ),
          list(
            x = "2003",
            y = 234
          ),
          list(
            x = "2004",
            y = 18
          ),
          list(
            x = "2005",
            y = 56
          )
        )
      ),
      list(
        id = "CoffeeScript",
        data = list(
          list(
            x = "2000",
            y = 12
          ),
          list(
            x = "2001",
            y = 23
          ),
          list(
            x = "2002",
            y = 24
          ),
          list(
            x = "2003",
            y = 234
          ),
          list(
            x = "2004",
            y = 12
          ),
          list(
            x = "2005",
            y = 7
          )
        )
      )
    )

    # TODO fix the test
    skip_if(
      condition = R.version$major < "4",
      message = "If the R version is under 4,
      the 'x' seems to be convert as an S3 object of class <factor>, but not a
      character vector."
    )
    expect_equal(.convert_data(data), expeceted)
  })

  it("Convertion is correct when only pass series name", {
    expeceted <- list(
      list(
        id = "JavaScript",
        data = list(
          list(
            x = 2000,
            y = 45
          ),
          list(
            x = 2001,
            y = 15
          ),
          list(
            x = 2002,
            y = 20
          ),
          list(
            x = 2003,
            y = 234
          ),
          list(
            x = 2004,
            y = 12
          ),
          list(
            x = 2005,
            y = 12
          )
        )
      )
    )

    expect_equal(.convert_data(data, series = "JavaScript"), expeceted)
  })
})
