library(R.utils)
library(iccat.pub.base)
library(iccat.pub.viz)

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinycssloaders)
library(DT)
#library(YesSiR)

ALL_CATCH_TYPES = setNames(as.character(REF_CATCH_TYPES$CODE), paste(REF_CATCH_TYPES$CODE, "-", REF_CATCH_TYPES$NAME_EN))
ALL_SPECIES     = setNames(as.character(REF_SPECIES$CODE),     paste(REF_SPECIES$CODE,     "-", REF_SPECIES$NAME_EN))
ALL_STOCK_AREAS = setNames(as.character(REF_STOCK_AREAS$CODE), paste(REF_STOCK_AREAS$CODE, "-", REF_STOCK_AREAS$NAME_EN))
ALL_GEAR_GROUPS = setNames(as.character(REF_GEAR_GROUPS$CODE), paste(REF_GEAR_GROUPS$CODE, "-", REF_GEAR_GROUPS$NAME_EN))
ALL_FLAGS       = setNames(as.character(REF_FLAGS$NAME_EN),    paste(REF_FLAGS$CODE,       "-", REF_FLAGS$NAME_EN))

set_flextable_defaults(font.family = "Arial")

set_log_level(LOG_INFO)

load("./NC_all.RData")

MIN_YEAR = min(NC_ALL$YearC)
MAX_YEAR = max(NC_ALL$YearC)

INFO(paste0(nrow(NC_ALL), " rows loaded from NC_ALL"))
