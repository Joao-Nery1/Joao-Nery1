# Projeto de Machine Learning – Previsão de Sucesso de Produtos

## 1. Escopo do Projeto

Este projeto tem como objetivo desenvolver e avaliar um modelo de Machine Learning capaz de classificar produtos de e-commerce em três categorias de desempenho:

- **Fracasso / Nicho**
- **Sucesso Moderado**
- **Viral / Sucesso de Vendas**

A motivação central é apoiar decisões estratégicas — como precificação, marketing e gestão de portfólio — a partir de características dos produtos, como preço, desconto, categoria e avaliações de usuários.

---

## 1.1 Base de Dados

O projeto utiliza três conjuntos principais de dados:

- **Base original**: arquivo contendo dados brutos de produtos (ex.: preços, categorias, ratings, descontos).
- **Base tratada (ETL)**: gerada a partir de um processo de ETL em Python, onde os dados são limpos, transformados e preparados para modelagem.
- **Base de teste**: utilizada exclusivamente para validação final e geração de previsões.

---

## 1.2 ETL e Pré-processamento

O processo de ETL foi implementado em Python e contempla:

- Limpeza de dados inconsistentes e ausentes;
- Conversão de tipos de dados;
- Criação e padronização de variáveis relevantes;
- Geração de um novo arquivo estruturado para consumo no :contentReference[oaicite:0]{index=0}.

O notebook de ETL é responsável por garantir que os dados estejam prontos para análise e modelagem, reduzindo ruídos e vieses.

---

## 1.3 Modelagem

Após o ETL, os dados foram utilizados em dois ambientes distintos:

### Modelagem Visual

No Orange Data Mining, foi construído um fluxo de experimentação com os seguintes passos:

- Seleção de colunas relevantes;
- Análise exploratória via Data Table;
- Amostragem e separação de dados;
- Teste de múltiplos algoritmos de classificação:
  - kNN  
  - Regressão Logística  
  - SVM  
  - Random Forest  
  - Rede Neural  

O widget **Rank** foi utilizado para avaliar a relevância das variáveis. A partir dessa análise, constatou-se que variáveis relacionadas a tamanho e dimensões não apresentavam impacto significativo no desempenho do modelo e foram desconsideradas.

---

## 1.4 Seleção do Modelo

Os algoritmos foram comparados utilizando as seguintes métricas:

- AUC  
- Acurácia (CA)  
- Precisão  
- Recall  
- F1-score  
- MCC  

Com base nesses critérios, o **Random Forest** apresentou o melhor desempenho geral e foi selecionado como modelo final.

---

## 1.5 Implementação em Python

Após a validação no ambiente visual, o modelo de Random Forest foi implementado diretamente em Python, reproduzindo:

- O processo de treinamento;
- A avaliação com métricas de classificação;
- A geração de previsões para novos produtos.

Essa etapa garante reprodutibilidade, maior controle do pipeline e possibilidade de integração futura com aplicações reais.

