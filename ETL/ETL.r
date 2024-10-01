install.packages("RMySQL")
library(RMySQL)

con <- dbConnect(MySQL(), user='root', password='#Gf23636497880', dbname='Sparrow', host='localhost')

data_raw <- dbGetQuery(con, 'SELECT * FROM dado_capturado')

data_raw_cpu <- dbGetQuery(con, 'SELECT * FROM dado_capturado WHERE fk_componente_servidor = 1')

summary(data_raw_cpu$registro)
hist(data_raw_cpu$registro)

data_raw_ram <- dbGetQuery(con, 'SELECT * FROM dado_capturado WHERE fk_componente_servidor = 2')

summary(data_raw_ram$registro)
hist(data_raw_ram$registro)

data_raw_disco <- dbGetQuery(con, 'SELECT * FROM dado_capturado WHERE fk_componente_servidor = 3')

summary(data_raw_disco$registro)
hist(data_raw_disco$registro)