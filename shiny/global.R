library(iccat.pub.base)
library(iccat.pub.viz)

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinycssloaders)
library(DT)

library(stringr)

# THIS IS ***FUNDAMENTAL*** TO HAVE THE DOCKER CONTAINER CORRECTLY LOAD THE .RData FILE WITH THE ORIGINAL UTF-8 ENCODING
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

#library(YesSiR)

CT_CATCHES  = REF_CATCH_TYPES[CATCH_TYPE_GROUP == "Catches"]
CT_LANDINGS = REF_CATCH_TYPES[CATCH_TYPE_GROUP == "Landings"]
CT_DISCARDS = REF_CATCH_TYPES[CATCH_TYPE_GROUP == "Discards"]

ALL_CATCH_TYPES    = list(
  "Catches"  = setNames(as.character(CT_CATCHES$CODE),  paste0(CT_CATCHES$CODE,  " - ", CT_CATCHES$NAME_EN)),
  "Landings" = setNames(as.character(CT_LANDINGS$CODE), paste0(CT_LANDINGS$CODE, " - ", CT_LANDINGS$NAME_EN)),
  "Discards" = setNames(as.character(CT_DISCARDS$CODE), paste0(CT_DISCARDS$CODE, " - ", CT_DISCARDS$NAME_EN))
)

SP_TEMPERATE    = REF_SPECIES[SPECIES_GROUP == "Temperate tunas"]
SP_TROPICAL     = REF_SPECIES[SPECIES_GROUP == "Tropical tunas"]
SP_SMALL_TUNAS  = REF_SPECIES[SPECIES_GROUP_ICCAT == "Tunas (small)"]
SP_BILLFISH     = REF_SPECIES[SPECIES_GROUP == "Billfishes"]
SP_MAJOR_SHARKS = REF_SPECIES[SPECIES_GROUP_ICCAT == "Sharks (major)"]
SP_OTHER_SHARKS = REF_SPECIES[SPECIES_GROUP_ICCAT == "Sharks (other)"]

ALL_SPECIES = list(
  "Temperate tunas" = setNames(as.character(SP_TEMPERATE$CODE),    paste0(SP_TEMPERATE$CODE,    " - ", SP_TEMPERATE$NAME_EN)),
  "Tropical tunas"  = setNames(as.character(SP_TROPICAL$CODE),     paste0(SP_TROPICAL$CODE,     " - ", SP_TROPICAL$NAME_EN)),
  "Small tunas"     = setNames(as.character(SP_SMALL_TUNAS$CODE),  paste0(SP_SMALL_TUNAS$CODE,  " - ", SP_SMALL_TUNAS$NAME_EN)),
  "Billfish"        = setNames(as.character(SP_BILLFISH$CODE),     paste0(SP_BILLFISH$CODE,     " - ", SP_BILLFISH$NAME_EN)),
  "Sharks (major)"  = setNames(as.character(SP_MAJOR_SHARKS$CODE), paste0(SP_MAJOR_SHARKS$CODE, " - ", SP_MAJOR_SHARKS$NAME_EN)),
  "Sharks (other)"  = setNames(as.character(SP_OTHER_SHARKS$CODE), paste0(SP_OTHER_SHARKS$CODE, " - ", SP_OTHER_SHARKS$NAME_EN))
)

ALL_STOCK_AREAS = setNames(as.character(REF_STOCK_AREAS$CODE), paste(REF_STOCK_AREAS$CODE, "-", REF_STOCK_AREAS$NAME_EN))
ALL_GEAR_GROUPS = setNames(as.character(REF_GEAR_GROUPS$CODE), paste(REF_GEAR_GROUPS$CODE, "-", REF_GEAR_GROUPS$NAME_EN))
ALL_FLAGS       = setNames(as.character(REF_FLAGS$NAME_EN),    paste(REF_FLAGS$CODE,       "-", REF_FLAGS$NAME_EN))

UI_select_input = function(id, label, choices, auto_select_first = FALSE, selected = NA) {
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
      updateOn = "close",
      ifelse(auto_select_first, NA, selected)
    )
  )
}

set_flextable_defaults(font.family = "Arial")

set_log_level(LOG_INFO)

load("./META.RData")
load("./NC_all.RData")

MIN_YEAR = min(NC_ALL$YearC)
MAX_YEAR = max(NC_ALL$YearC)

INFO(paste0(nrow(NC_ALL), " rows loaded from NC_ALL"))
