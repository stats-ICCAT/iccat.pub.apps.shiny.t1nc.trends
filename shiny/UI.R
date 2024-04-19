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
                strong("Download: "),
                #downloadButton("downloadXLSX", "XLSX"),
                downloadButton("downloadCSV",  "CSV"),
                downloadButton("downloadHTML", "HTML"),
                downloadButton("downloadPNG",  "PNG")
              )
            )
          ),
          fluidRow(
            column(
              width = 2,
              fluidRow(
                column(
                  width = 12,
                  virtualSelectInput("species", "Species",
                                     width = "100%",
                                     multiple = TRUE,
                                     choices = ALL_SPECIES,
                                     search = TRUE,
                                     showValueAsTags = TRUE,
                                     selected = "BFT")
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  virtualSelectInput("flags", "Flag(s)",
                                     width = "100%",
                                     choices = ALL_FLAGS,
                                     search = TRUE,
                                     showValueAsTags = TRUE,
                                     multiple = TRUE)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  virtualSelectInput("gearGroups", "Gear group(s)",
                                     width = "100%",
                                     choices = ALL_GEAR_GROUPS,
                                     search = TRUE,
                                     showValueAsTags = TRUE,
                                     multiple = TRUE)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  virtualSelectInput("stocks", "Stock(s)",
                                     width = "100%",
                                     choices = ALL_STOCK_AREAS,
                                     search = TRUE,
                                     showValueAsTags = TRUE,
                                     multiple = TRUE)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  numericInput("num_years", "No. years",
                               width = "100%",
                               min = 10,
                               value = 20,
                               step = 1)
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  checkboxGroupButtons("show", "Show",
                                       width = "100%",
                                       choices = c("Species", "Gears", "Stocks"),
                                       selected = c("Species", "Gears", "Stocks"),
                                       status = "primary")

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
