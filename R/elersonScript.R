# Consultar dados do banco incluindo fk_empresa e fk_dado_monitorado

# Instale os pacotes necessários, se ainda não estiverem instalados
install.packages("DBI")
install.packages("RMySQL")

library(DBI)
library(RMySQL)

# Conectar ao banco de dados
con <- dbConnect(
  MySQL(), 
  dbname = "Sparrow",
  host = "localhost",
  user = "ROOT",
  password = "urubu100"
)


# Definir o período em dias (pode ser 7, 15 ou 30)
periodo_dias <- 7

# Ajustar a consulta SQL para considerar apenas os registros dos últimos X dias
query <- sprintf(
  "SELECT fk_empresa, fk_maquina, fk_dado_monitorado, registro, data_hora
   FROM dado_capturado
   WHERE data_hora >= NOW() - INTERVAL %d DAY;", 
  periodo_dias
)

# Executar a consulta e obter os dados filtrados
dados <- dbGetQuery(con, query)

# Calcular média e estatísticas de boxplot agrupadas por empresa, máquina e tipo de dado monitorado
library(dplyr)

resultados <- dados %>%
  group_by(fk_empresa, fk_maquina, fk_dado_monitorado) %>%
  summarise(
    media = mean(registro, na.rm = TRUE),
    minimo = min(registro, na.rm = TRUE),
    primeiro_quartil = quantile(registro, 0.25, na.rm = TRUE),
    mediana = median(registro, na.rm = TRUE),
    terceiro_quartil = quantile(registro, 0.75, na.rm = TRUE),
    maximo = max(registro, na.rm = TRUE)
  ) %>%
  mutate(periodo_dias = periodo_dias)

# Inserir dados tratados na tabela `dados_tratados`
for (i in 1:nrow(resultados)) {
  query_insert <- sprintf(
    "INSERT INTO Sparrow.dados_tratados (fk_empresa, fk_maquina, fk_dado_monitorado, media, minimo, primeiro_quartil, mediana, terceiro_quartil, maximo, periodo_dias)
    VALUES (%d, %d, %d, %f, %f, %f, %f, %f, %f, %d);",
    resultados$fk_empresa[i],
    resultados$fk_maquina[i],
    resultados$fk_dado_monitorado[i],
    resultados$media[i],
    resultados$minimo[i],
    resultados$primeiro_quartil[i],
    resultados$mediana[i],
    resultados$terceiro_quartil[i],
    resultados$maximo[i],
    resultados$periodo_dias[i]
  )
  
  dbExecute(con, query_insert)
}

# Fechar a conexão após a inserção
dbDisconnect(con)
