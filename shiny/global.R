library(iccat.pub.base)
library(iccat.pub.viz)

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinycssloaders)
library(DT)

# THIS IS ***FUNDAMENTAL*** TO HAVE THE DOCKER CONTAINER CORRECTLY LOAD THE .RData FILE WITH THE ORIGINAL UTF-8 ENCODING
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

#library(YesSiR)

ALL_CATCH_TYPES = setNames(as.character(REF_CATCH_TYPES$CODE), paste(REF_CATCH_TYPES$CODE, "-", REF_CATCH_TYPES$NAME_EN))
ALL_SPECIES     = setNames(as.character(REF_SPECIES$CODE),     paste(REF_SPECIES$CODE,     "-", REF_SPECIES$NAME_EN))
ALL_STOCK_AREAS = setNames(as.character(REF_STOCK_AREAS$CODE), paste(REF_STOCK_AREAS$CODE, "-", REF_STOCK_AREAS$NAME_EN))
ALL_GEAR_GROUPS = setNames(as.character(REF_GEAR_GROUPS$CODE), paste(REF_GEAR_GROUPS$CODE, "-", REF_GEAR_GROUPS$NAME_EN))
ALL_FLAGS       = setNames(as.character(REF_FLAGS$NAME_EN),    paste(REF_FLAGS$CODE,       "-", REF_FLAGS$NAME_EN))

UI_select_input = function(id, label, choices, auto_select_first = FALSE) {
  return(
    virtualSelectInput(
      inputId = id,
      label = label,
      width = "100%",
      multiple = TRUE,
      autoSelectFirstOption = auto_select_first,
      choices = choices,
      search = TRUE,
      showValueAsTags = FALSE,
      updateOn = "change"
    )
  )
}

set_flextable_defaults(font.family = "Arial")

set_log_level(LOG_INFO)

load("./NC_all.RData")

MIN_YEAR = min(NC_ALL$YearC)
MAX_YEAR = max(NC_ALL$YearC)

INFO(paste0(nrow(NC_ALL), " rows loaded from NC_ALL"))
