server = function(input, output, session) {
  COLORIZE_GEARS = FALSE

  filtered_trend_data = reactive({
    NC = NC_ALL

    INFO(paste0("Species: ",   paste0(input$species,    collapse = ",")))
    INFO(paste0("No. years: ", paste0(input$num_years,  collapse = ",")))
    INFO(paste0("Show: ",      paste0(input$show,       collapse = ",")))
    INFO(paste0("Flags: ",     paste0(input$flags,      collapse = ",")))
    INFO(paste0("Gears: ",     paste0(input$gearGroups, collapse = ",")))
    INFO(paste0("Stocks: ",    paste0(input$stocks,     collapse = ",")))

    if(!is.null(input$species) & length(input$species) > 0) {
      NC = NC[Species %in% input$species]
    } else {
      stop("Please select at least one species")
    }

    if(!is.null(input$flags)) {
      NC = NC[FlagName %in% input$flags]
    }

    if(!is.null(input$gearGroups)) {
      NC = NC[GearGrp %in% input$gearGroups]
    }

    if(!is.null(input$stocks)) {
      NC = NC[Stock %in% input$stocks]
    }

    last_year  = max(NC$Year)
    first_year = last_year - input$num_years + 1

    NC = NC[YearC >= first_year]

    if(nrow(NC) == 0)
      stop("Unable to identify any catch data with the provided filtering criteria")

    return(NC)
  })

  output$trends =
    renderUI({
      return(
        htmltools_value(
          t1nc.viz.trends(
            filtered_trend_data(),
            sensitivity = input$sensitivity,
            by_species = "Species" %in% input$show,
            by_gear    = "Gears"   %in% input$show,
            by_stock   = "Stocks"  %in% input$show,
            colorize_gears = COLORIZE_GEARS
          ),
          ft.align = "left"
        )
      )
    })

  compute_filename = function(input, suffix) {
    components = c(paste0(input$species,    collapse = "+"),
                   paste0(input$flags,      collapse = "+"),
                   paste0(input$gearGroups, collapse = "+"),
                   paste0(input$stocks,     collapse = "+"),
                   paste0(input$show,       collapse = "+"),
                   input$num_years)

    components = components[which(components != "")]


    return(
      paste0("trends_", paste0(components, collapse = "_"), ".", suffix)
    )
  }

  output$downloadCSV = downloadHandler(
    filename = function() {
      return(compute_filename(input, "csv"))
    },
    content = function(file) {
      write.table(
        t1nc.summarise(
          filtered_trend_data(),
          by_species = "Species" %in% input$show,
          by_gear    = "Gears"   %in% input$show,
          by_stock   = "Stocks"  %in% input$show
        )$grouped,
        file = file,
        sep = ",",
        na = "",
        row.names = FALSE
      )
    }
  )

  output$downloadXLSX = downloadHandler(
    filename = function() {
      return(compute_filename(input, "xlsx"))
    },
    content = function(file) {
      exportxlsx(
        t1nc.viz.trends(
          filtered_trend_data(),
          sensitivity = input$sensitivity,
          by_species = "Species" %in% input$show,
          by_gear    = "Gears"   %in% input$show,
          by_stock   = "Stocks"  %in% input$show,
          colorize_gears = COLORIZE_GEARS
        ),
        path = file
      )
    }
  )

  output$downloadHTML = downloadHandler(
    filename = function() {
      return(compute_filename(input, "html"))
    },
    content = function(file) {
      flextable::save_as_html(
        t1nc.viz.trends(
          filtered_trend_data(),
          sensitivity = input$sensitivity,
          by_species = "Species" %in% input$show,
          by_gear    = "Gears"   %in% input$show,
          by_stock   = "Stocks"  %in% input$show,
          colorize_gears = COLORIZE_GEARS
        ),
        path = file
      )
    }
  )

  output$downloadPNG = downloadHandler(
    filename = function() {
      return(compute_filename(input, "png"))
    },
    content = function(file) {
      flextable::save_as_image(
        t1nc.viz.trends(
          filtered_trend_data(),
          sensitivity = input$sensitivity,
          by_species = "Species" %in% input$show,
          by_gear    = "Gears"   %in% input$show,
          by_stock   = "Stocks"  %in% input$show,
          colorize_gears = COLORIZE_GEARS
        ),
        path = file
      )
    }
  )
}
