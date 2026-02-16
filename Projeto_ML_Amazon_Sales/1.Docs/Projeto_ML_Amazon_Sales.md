# 🛒 Projeto de Machine Learning – Previsão de Sucesso de Produtos
🇧🇷 Português

📝 Descrição do Projeto  
Este projeto tem como objetivo a construção de um pipeline completo de Machine Learning aplicado ao contexto de e-commerce, com foco na **classificação do desempenho de produtos** a partir de suas características comerciais.

Os produtos são classificados em três categorias:
- **Fracasso / Nicho**
- **Sucesso Moderado**
- **Viral / Sucesso de Vendas**

O principal objetivo é apoiar decisões estratégicas de negócio, como precificação, marketing e gestão de portfólio, utilizando dados históricos de produtos.

---

✅ Escopo do Projeto

📄 1. Base de Dados  
O projeto utiliza três conjuntos principais de dados:

- **Base Original**: dados brutos de produtos (preço, desconto, categoria, avaliações, etc.).
- **Base Tratada (ETL)**: gerada a partir de um processo de ETL em Python.
- **Base de Teste**: utilizada exclusivamente para validação final e geração de previsões.

---

🧹 2. ETL e Pré-processamento  
O processo de ETL foi desenvolvido em Python e contempla:

- Limpeza de dados inconsistentes e valores ausentes;
- Conversão e padronização de tipos de dados;
- Criação de variáveis relevantes para a modelagem;
- Geração de um dataset estruturado para consumo em ferramentas de Machine Learning.

---

 📊 3. Modelagem e Experimentação  
Após o ETL, os dados foram importados para o Orange Data Mining, onde foi construído um fluxo de experimentação contendo:

- Seleção de atributos relevantes;
- Análise exploratória dos dados;
- Amostragem e separação do conjunto de dados;
- Teste de múltiplos algoritmos de classificação:
  - kNN  
  - Regressão Logística  
  - SVM  
  - Random Forest  
  - Rede Neural  

O widget Rank foi utilizado para avaliar a relevância das variáveis. Variáveis relacionadas a tamanho e dimensões não apresentaram impacto significativo e foram removidas.

---

🏆 4. Seleção do Modelo  
Os modelos foram comparados utilizando as seguintes métricas:

- AUC  
- Acurácia (CA)  
- Precisão  
- Recall  
- F1-score  
- MCC  

Com base nesses critérios, o **Random Forest** foi selecionado como modelo final.

---

⚙️ 5. Implementação em Python  
Após a validação no ambiente visual, o modelo Random Forest foi implementado diretamente em Python, garantindo:

- Reprodutibilidade do treinamento;
- Avaliação consistente das métricas;
- Geração de previsões para novos produtos.

---

## 📚 Acesse o Projeto

- [🛒 Projeto de Machine Learning – Previsão de Sucesso de Produtos](https://github.com/Joao-Nery1/Joao-Nery1/tree/main/Projeto_ML_Amazon_Sales)

## 👨‍💻 Autor

João Batista Nery  
[LinkedIn](https://www.linkedin.com/in/joaobatistanery)

---

## 🇺🇸 English Version

# 🛒 Machine Learning Project – Product Success Prediction

📝 Project Description  
This project aims to build a complete Machine Learning pipeline applied to an e-commerce context, focusing on **product performance classification** based on commercial attributes.

Products are classified into three categories:
- **Failure / Niche**
- **Moderate Success**
- **Viral / High Sales Success**

The main goal is to support strategic business decisions such as pricing, marketing, and product portfolio management.

---

✅ Project Scope

📄 1. Dataset  
The project uses three main datasets:

- **Raw Dataset**: original product data (price, discount, category, ratings, etc.).
- **Processed Dataset (ETL)**: generated through a Python ETL process.
- **Test Dataset**: used exclusively for final validation and predictions.

---

🧹 2. ETL and Preprocessing  
The ETL process includes:

- Data cleaning and missing value handling;
- Data type conversion and standardization;
- Feature engineering;
- Generation of a structured dataset for Machine Learning.

---

📊 3. Modeling and Experimentation  
After ETL, the data was imported into Orange Data Mining for experimentation, including:

- Feature selection;
- Exploratory data analysis;
- Data sampling and splitting;
- Testing multiple classification algorithms:
  - kNN  
  - Logistic Regression  
  - SVM  
  - Random Forest  
  - Neural Network  

Low-impact features were removed based on feature ranking analysis.

---

🏆 4. Model Selection  
Models were evaluated using:

- AUC  
- Accuracy  
- Precision  
- Recall  
- F1-score  
- MCC  

The **Random Forest** model achieved the best overall performance and was selected as the final model.

---

⚙️ 5. Python Implementation  
The final model was implemented in Python to ensure:

- Reproducibility;
- Controlled training and evaluation;
- Prediction generation for new products.

## 📚 Go to Project

- [🛒 Machine Learning Project – Product Success Prediction](https://github.com/Joao-Nery1/Joao-Nery1/tree/main/Projeto_ML_Amazon_Sales)


---

## 👨‍💻 Author

João Batista Nery  
[LinkedIn](https://www.linkedin.com/in/joaobatistanery)

---

