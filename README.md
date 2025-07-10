# Dashboard Interativo de E-commerce com R e SQLite

Este projeto apresenta uma análise de dados de vendas em um ambiente de e-commerce, utilizando **R**, **SQLite**, **Plotly** e **Flexdashboard**.

---

## 📦 Tecnologias utilizadas

- **R** e **RStudio**
- **SQLite** para persistência de dados
- **`dplyr`, `ggplot2`, `plotly`** para análise e visualização
- **Flexdashboard** para construção de dashboard interativo
- **DT** para tabelas interativas (caso necessário)

---

## 📊 Etapas do projeto

1. **Importação da base de dados CSV**
2. **Criação de banco de dados SQLite**
3. **Consultas SQL diretas com `dbGetQuery()`**
4. **Criação de gráficos estáticos e interativos**
5. **Construção de Dashboard interativo (arquivo `.Rmd` + `.html`)**
6. **Exportação e publicação no GitHub**

---

## 📂 Arquivos no repositório

- `ecommerce_dashboard.Rmd` — código-fonte do dashboard
- `ecommerce_dashboard.html` — versão renderizada do dashboard
- `ecommerce_dataset.csv` — base de dados original
- `ecommerce.sqlite` — banco de dados relacional
- `Projeto-Boticario.R` — script auxiliar de consultas e gráficos
- Gráficos em `.png` para visualização estática

---

## ▶️ Como executar

1. Clone o repositório:
```bash
git clone https://github.com/jcmohub/ecommerce-analise-dashboard-r.git
