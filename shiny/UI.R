ui = function() {
  TITLE = "ICCAT interactive trend analysis v1.0"
  return(
    fluidPage(
      title = TITLE,
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
      ),
      tags$div(
        class = "main-container",
        conditionalPanel(
          condition = "$('html').hasClass('shiny-busy')",
          tags$div(id = "glasspane",
                   tags$div(class = "loading", "Filtering data and preparing output...")
          )
        ),
        tags$div(
          fluidRow(
            column(
              width = 8,
              h2(
                img(src = "iccat-logo.jpg", height = "96px"),
                span(TITLE),
                #downloadButton("downloadCSV",  "CSV"),
                #downloadButton("downloadXLSX", "XLSX"), # Does not seem to work consistently
                #downloadButton("downloadHTML", "HTML"), # Does not seem to work consistently
                #downloadButton("downloadPNG",  "PNG")   # Does not seem to work consistently
                downloadButton("downloadCSV",  "Download")
              )
            )
          ),
          fluidRow(
            column(
              width = 2,
              fluidRow(
                column(
                  width = 12,
                  sliderInput("years", "Year range",
                              width = "100%",
                              min = MIN_YEAR, max = MAX_YEAR,
                              value = c(max(MIN_YEAR, MAX_YEAR - 20 + 1), MAX_YEAR),
                              sep = "",
                              step  = 1)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  UI_select_input("species", "Species", ALL_SPECIES, auto_select_first = TRUE)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  UI_select_input("flags", "Flag(s)", ALL_FLAGS)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  UI_select_input("gearGroups", "Gear group(s)", ALL_GEAR_GROUPS)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  UI_select_input("stocks", "Stock(s)", ALL_STOCK_AREAS)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  UI_select_input("catchTypes", "Catch types", ALL_CATCH_TYPES)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  checkboxGroupButtons("show", "Show",
                                       width = "100%",
                                       choices =  c("Species", "Gears", "Stocks", "Type", "Rank"),
                                       selected = c("Species", "Gears", "Stocks"),
                                       status = "primary",
                                       justified = TRUE)

                )
              ),
              fluidRow(
                column(
                  width = 12,
                  sliderInput("sensitivity", "Sensitivity",
                              width = "100%",
                              min = 0, max = 1, value = 0,
                              step = .1)
                )
              )
            ),
            column(
              width = 10,
              uiOutput("trends")
            )
          )
        )
      )
    )
  )
}
