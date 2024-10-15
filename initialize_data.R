library(iccat.dev.data)

META = list(LAST_UPDATE = as.Date(Sys.Date(), format = "%Y-%M-%d"))
save(list = "META", file = "./shiny/META.RData")

NC_ALL = t1nc(db_connection = DB_T1())

save(NC_ALL, file = "./shiny/NC_all.RData")
