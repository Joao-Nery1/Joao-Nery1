# 🏬 Projeto de ETL Business Intelligence - Loja Esportiva

## 🇧🇷 Português

## 📝 Descrição do Projeto

Este projeto visa a construção de um pipeline completo de Business Intelligence utilizando o cenário fictício de uma **Loja Esportiva**. O fluxo contempla desde a modelagem relacional em um banco OLTP até a criação de um **Data Warehouse (DW)** alimentado via **Pentaho Data Integration (PDI)**, passando por uma camada intermediária de staging (STG).

O objetivo principal é demonstrar as práticas recomendadas de modelagem dimensional, extração, transformação e carga (ETL), e organização dos dados para facilitar análises futuras.

---

## ✅ Fases do Projeto

### 📄 1. Modelagem OLTP (Sistema Transacional)

- **Banco de Dados:** `LojaEsporte` (SQL Server)
- **Tabelas Modeladas:**
  - `CLIENTE`, `PEDIDO`, `ITEM`, `PRODUTO`, `CATEGORIAPRODUTO`, `PAGAMENTO`, `FORMAPAGAMENTO`, `TIPOCLIENTE`
- **Relacionamentos:** Normalização até a 3ª Forma Normal, com chaves estrangeiras bem definidas.
- **Povoamento:** Dados de exemplo inseridos para simulação de vendas, produtos, e pagamentos.


---

### 🏗️ 2. Área de Staging (STG)

- **Banco de Dados:** `STG` (SQL Server)
- **Objetivo:** Receber os dados brutos do OLTP para posterior tratamento e carga no DW.
- **Ferramenta de ETL:** Pentaho Data Integration (PDI)
- **Tabelas Criadas:**
  - `TB_STG_CLIENTE`, `TB_STG_PRODUTO`, `TB_STG_PEDIDO`, `TB_STG_ITEM_PEDIDO`, `TB_STG_CATEGORIA_PRODUTO`, `TB_STG_TIPO_CLIENTE`
- **Transformações Desenvolvidas:** Extração e inserção dos dados OLTP.


---

### 🏛️ 3. Data Warehouse (DW)

- **Banco de Dados:** `DW` (SQL Server)
- **Modelo:** Dimensional (Estrela)
- **Tabelas Fato e Dimensão:**
  - **Fato:** `TB_FATO_PEDIDO`
  - **Dimensões:** `TB_DIM_CLIENTE`, `TB_DIM_PRODUTO`, `TB_DIM_CATEGORIA_PRODUTO`, `TB_DIM_TIPO_CLIENTE`, `TB_DIM_ESTADO`, `TB_DIM_MES`
- **Versões e Vigência:** Controle de versão em dimensões historificadas (SCD).


---

### ⚙️ 4. ETL - Transformações e Jobs

- **Ferramenta:** Pentaho Data Integration (PDI)
- **Arquivos KJB (Jobs):**
  - `JOB_STG.kjb`: Realiza a carga completa da área de staging.
  - `JOB_CARGA_DIM_FATO.kjb`: Carrega as tabelas dimensão e fato no DW.
  - `JOB_CARGA_FRIA.kjb`: Job completo de carga inicial.
  - `JOB_INCREMENTAL_MENSAL_PEDIDO.kjb`: Exemplo de carga incremental mensal.

## 📂 Estrutura de Pastas do Repositório

```
/Projeto_ETL_DW_Loja
├── /1.Docs
├── /2.Modelo_Relacional_SQL
├── /3.Staging_Area_PDI
├── /4.Modelo_Dimensional_DW_PDI
├── /5.Jobs_Pentaho_Data_Integration
```

---

## 🚀 Próximos Passos

- 📊 **Criação de Dashboards:** Utilizar Power BI ou Tableau para construir dashboards analíticos.
- 🧹 **Tratamento de Dados Sujos:** Incluir validações e filtros no ETL.
- 📁 **Controle de Qualidade de Dados:** Criar regras de consistência e log de execuções.

---

## 🛠️ Tecnologias Utilizadas

- **Banco de Dados:** SQL Server
- **ETL:** Pentaho Data Integration (PDI / Kettle)
- **Modelagem:** Entidade-Relacionamento e Dimensional (Estrela)
- **Outros:** GitHub

---

## 📚 Acesse o Projeto

- [📊 Projeto de ETL Business Intelligence - Loja Esportiva](https://github.com/Joao-Nery1/Joao-Nery1/tree/main/Projeto_ETL_DW_Loja)

---

## 👨‍💻 Autor

João Batista Nery  
[LinkedIn](https://www.linkedin.com/in/joaobatistanery)

---

---

## 🇺🇸 English Version

# 🏬 Business Intelligence ETL Project - Sports Store

## 📝 Project Description

This project focuses on building a complete Business Intelligence pipeline using a fictitious **Sports Store** scenario. The flow includes the creation of a relational model in an OLTP database, a **Staging Area (STG)**, and a **Data Warehouse (DW)** populated via **Pentaho Data Integration (PDI)**.

The main goal is to demonstrate best practices in dimensional modeling, ETL processes, and data organization for analysis.

---

## ✅ Project Phases

### 📄 1. OLTP Modeling (Transactional System)

- **Database:** `LojaEsporte` (SQL Server)
- **Main Tables:**
  - `CLIENTE`, `PEDIDO`, `ITEM`, `PRODUTO`, `CATEGORIAPRODUTO`, `PAGAMENTO`, `FORMAPAGAMENTO`, `TIPOCLIENTE`
- **Relationships:** Normalized up to 3NF with foreign keys.
- **Population:** Example data inserted to simulate transactions and records.


---

### 🏗️ 2. Staging Area (STG)

- **Database:** `STG` (SQL Server)
- **Goal:** Receive raw OLTP data for further processing before loading into the DW.
- **ETL Tool:** Pentaho Data Integration (PDI)
- **Tables Created:**
  - `TB_STG_CLIENTE`, `TB_STG_PRODUTO`, `TB_STG_PEDIDO`, `TB_STG_ITEM_PEDIDO`, `TB_STG_CATEGORIA_PRODUTO`, `TB_STG_TIPO_CLIENTE`
- **Transformations:** Basic data extraction and loading from OLTP.

---

### 🏛️ 3. Data Warehouse (DW)

- **Database:** `DW` (SQL Server)
- **Model:** Dimensional (Star Schema)
- **Fact and Dimension Tables:**
  - **Fact:** `TB_FATO_PEDIDO`
  - **Dimensions:** `TB_DIM_CLIENTE`, `TB_DIM_PRODUTO`, `TB_DIM_CATEGORIA_PRODUTO`, `TB_DIM_TIPO_CLIENTE`, `TB_DIM_ESTADO`, `TB_DIM_MES`
- **Versioning:** Slowly Changing Dimensions (SCD) handled in dimensions.


---

### ⚙️ 4. ETL - Transformations and Jobs

- **Tool:** Pentaho Data Integration (PDI)
- **KJB (Job) Files:**
  - `JOB_STG.kjb`: Loads STG tables.
  - `JOB_CARGA_DIM_FATO.kjb`: Loads DW dimension and fact tables.
  - `JOB_CARGA_FRIA.kjb`: Complete cold load job.
  - `JOB_INCREMENTAL_MENSAL_PEDIDO.kjb`: Example of incremental monthly load.

## 📂 Repository Folder Structure

```
/Projeto_ETL_DW_Loja
├── /1.Docs
├── /2.Modelo_Relacional_SQL
├── /3.Staging_Area_PDI
├── /4.Modelo_Dimensional_DW_PDI
├── /5.Jobs_Pentaho_Data_Integration
```

---

## 🚀 Next Steps

- 📊 **Dashboard Creation:** Use Power BI or Tableau to analyze the DW data.
- 🧹 **Data Cleaning:** Add validations and filters in ETL flow.
- 📁 **Data Quality Controls:** Add consistency rules and logging.

---

## 🛠️ Technologies Used

- **Database:** SQL Server
- **ETL Tool:** Pentaho Data Integration (PDI / Kettle)
- **Modeling:** ER and Star Schema
- **Others:** GitHub

---

## 📚 Go to Project

- [📊 Business Intelligence ETL Project - Sports Store](https://github.com/Joao-Nery1/Joao-Nery1/tree/main/Projeto_ETL_DW_Loja)


---

## 👨‍💻 Author

João Batista Nery  
[LinkedIn](https://www.linkedin.com/in/joaobatistanery)

---
