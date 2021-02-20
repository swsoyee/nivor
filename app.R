library(shiny)
library(nivor)

ui <- fluidPage(
  titlePanel("Calendar Example"),
  calendarOutput("calender")
)

server <- function(input, output, session) {
  output$calender <- renderCalendar({
    df <- data.frame(
      day = seq.Date(
        from = as.Date("2020-04-01"),
        length.out = 600,
        by = "days"
      ),
      value = round(runif(600) * 1000, 0)
    )

    n_calendar(
      data = df,
      emptyColor = "#eeeeee",
      colors = c("#d6e685", "#8cc665", "#44a340", "#1e6823"),
      yearSpacing = 40,
      monthBorderColor = "#ffffff",
      dayBorderWidth = 2,
      dayBorderColor = "#ffffff"
    )
  })
}

shinyApp(ui, server)
