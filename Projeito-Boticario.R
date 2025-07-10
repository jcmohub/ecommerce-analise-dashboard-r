##################################################################################################################
################################# Projeto Boticario #############################################################
library(DBI)
library(RSQLite)
library(readr)
library(dplyr)



# Caminho do CSV
caminho_csv <- "C:/Users/jcmonate/Desktop/Projeito - Boticario/ecommerce_dataset.csv"
ecom_df <- read_delim(caminho_csv, delim = ";", show_col_types = FALSE)
# Reescreva a tabela no banco
dbWriteTable(con, "ecommerce", ecom_df, overwrite = TRUE)

# Teste a visualização
dbGetQuery(con, "SELECT * FROM ecommerce LIMIT 5")


# Recriar conexão com o banco SQLite
con <- dbConnect(SQLite(), "ecommerce.sqlite")

# Regravar a tabela (se necessário)
dbWriteTable(con, "ecommerce", ecom_df, overwrite = TRUE)


# Consulta 1 – Vendas por categoria
query1 <- "
SELECT category,
       ROUND(SUM(price * quantity - discount), 2) AS total_vendas
FROM ecommerce
GROUP BY category
ORDER BY total_vendas DESC;
"

dbGetQuery(con, query1)


###################### gráfico de barras ######################
library(ggplot2)

# Executar novamente a consulta (caso precise do dataframe)
query1 <- "
SELECT category,
       ROUND(SUM(price * quantity - discount), 2) AS total_vendas
FROM ecommerce
GROUP BY category
ORDER BY total_vendas DESC;
"
vendas_categoria <- dbGetQuery(con, query1)

# Criar gráfico
ggplot(vendas_categoria, aes(x = reorder(category, -total_vendas), y = total_vendas)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(
    title = "Total de Vendas por Categoria de Produto",
    x = "Categoria",
    y = "Total de Vendas (R$)"
  ) +
  theme_minimal()



################# — Consulta 2: Ticket Médio por Canal #######################
query2 <- "
SELECT channel,
       ROUND(AVG((price * quantity - discount)), 2) AS ticket_medio
FROM ecommerce
GROUP BY channel
ORDER BY ticket_medio DESC;
"

ticket_canal <- dbGetQuery(con, query2)
ticket_canal


ggplot(ticket_canal, aes(x = reorder(channel, -ticket_medio), y = ticket_medio)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  labs(
    title = "Ticket Médio por Canal de Compra",
    x = "Canal",
    y = "Ticket Médio (R$)"
  ) +
  theme_minimal()


################ – Cruzamento: Categoria × Canal #####################################
######################################################################################
query_cross <- "
SELECT category, channel,
       ROUND(SUM(price * quantity - discount), 2) AS total_vendas
FROM ecommerce
GROUP BY category, channel
ORDER BY total_vendas DESC;
"

cat_canal <- dbGetQuery(con, query_cross)

# Corrigir acentuação corrompida na coluna 'channel'
cat_canal <- cat_canal |>
  mutate(channel = stri_trans_general(channel, "Latin-ASCII"),
         channel = recode(channel,
                          "Loja Fisica" = "Loja Física"))

# Criar gráfico
ggplot(cat_canal, aes(x = category, y = total_vendas, fill = channel)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Total de Vendas por Categoria e Canal",
    x = "Categoria",
    y = "Total de Vendas (R$)",
    fill = "Canal"
  ) +
  theme_minimal()



################# Construir Dashboard Interativo (com flexdashboard) ###############################
##############################################################################################################
install.packages("flexdashboard")
install.packages("plotly")          # Para interatividade nos gráficos
install.packages("DT")              # Tabelas interativas























