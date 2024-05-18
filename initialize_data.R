library(iccat.dev.data)

LAST_N_YEARS = 100

NC_ALL = t1nc(db_connection = DB_T1(username = Sys.getenv("DB_USERNAME"),
                                    password = Sys.getenv("DB_PASSWORD")))

#temp = tempfile(tmpdir = tempdir(), fileext = ".csv")

fwrite(NC_ALL, file = "./shiny/NC_all.csv.gz", encoding = "UTF-8", sep = ",", row.names = FALSE, compress = "gzip")
