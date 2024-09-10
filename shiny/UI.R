ui = function() {
  TITLE = paste0("ICCAT SCRS / Task1 NC trends / ", META$LAST_UPDATE)
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
                style = "margin-top: 5px !important",
                img(src = "iccat-logo.jpg", height = "48px"),
                span(TITLE)
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
                  UI_select_input("species", "Species", ALL_SPECIES, selected = "BFT")
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
              ),
              fluidRow(
                column(
                  width = 12,
                  actionButton("resetFilters", "Reset all filters", icon = icon("filter-circle-xmark"))
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  h5(strong("Download current dataset:"))
                )
              ),
              fluidRow(
                column(
                  width = 4,
                  downloadButton("downloadCSV", "Filtered", style = "width: 100px")
                ),
                column(
                  width = 4,
                  span("as ", style = "vertical-align: -5px",
                       code(".csv.gz")
                  )
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  hr(),
                  span("Data last updated on:"),
                  strong(META$LAST_UPDATE)
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
