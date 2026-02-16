# 📈 Discussão dos Resultados
🇧🇷 Português

📝 Visão Geral  
A análise dos resultados evidencia que o modelo **Random Forest** apresentou o melhor desempenho geral entre os algoritmos avaliados, demonstrando maior capacidade de capturar padrões não lineares e interações complexas entre as variáveis do conjunto de dados.

Os resultados obtidos são consistentes com a literatura, que aponta modelos baseados em ensemble como mais robustos em cenários com múltiplas variáveis explicativas e desbalanceamento de classes.

---

🔍 1. Comparação Detalhada entre os Modelos  
A comparação entre os algoritmos testados mostrou que:

- **Random Forest** apresentou o melhor equilíbrio entre *precisão* e *recall*, reduzindo tanto falsos positivos quanto falsos negativos;
- O valor superior de **AUC** indica maior capacidade discriminativa entre as três classes de desempenho;
- Modelos como **Regressão Logística** tiveram desempenho limitado devido à suposição de linearidade;
- **kNN** apresentou sensibilidade excessiva à distribuição dos dados;
- **SVM** teve dificuldades em separar adequadamente as classes minoritárias.

Esses resultados reforçam a adequação do Random Forest para problemas de classificação multiclasse em ambientes reais de negócio.

---

📊 2. Análise da Matriz de Confusão  
A matriz de confusão do Random Forest revela padrões importantes:

- A classe **Sucesso Moderado** foi identificada com alta taxa de acerto, indicando que o modelo consegue reconhecer padrões típicos de produtos com desempenho intermediário;
- A confusão entre **Fracasso / Nicho** e **Sucesso Moderado** sugere uma fronteira menos clara entre essas categorias, o que é esperado em cenários onde produtos possuem desempenho limítrofe;
- A classe **Viral / Sucesso de Vendas** apresentou maior taxa de erro, principalmente devido ao baixo número de exemplos disponíveis para treinamento.

Esse comportamento indica que o modelo tende a privilegiar padrões mais frequentes, característica comum em bases desbalanceadas.

---

📐 3. Avaliação das Métricas de Classificação  
A análise das métricas reforça os pontos observados anteriormente:

- A **acurácia geral**, em torno de **0.77**, indica bom desempenho global;
- O **weighted average** das métricas manteve-se próximo de **0.75**, refletindo boa performance nas classes majoritárias;
- O **macro average** apresentou valores inferiores, evidenciando que o desempenho não é homogêneo entre as classes.

Essa diferença entre métricas confirma o impacto direto do desbalanceamento da base sobre o modelo.

---

🧪 4. Análise das Previsões na Base de Teste  
Ao aplicar o modelo à base de teste, observou-se que:

- A maior parte dos produtos foi classificada como **Sucesso Moderado**, refletindo a distribuição original das classes;
- Produtos classificados como **Fracasso / Nicho** apresentam menor potencial de vendas e podem demandar estratégias específicas;
- Poucos produtos foram classificados como **Viral / Sucesso de Vendas**, o que é coerente com a raridade desse comportamento no conjunto de dados.

Do ponto de vista de negócio, essas previsões podem apoiar decisões de priorização de investimentos em marketing e portfólio.

---

🚧 5. Limitações do Estudo  
Apesar dos resultados satisfatórios, algumas limitações devem ser destacadas:

- Forte **desbalanceamento entre as classes**, especialmente para a classe Viral;
- Quantidade reduzida de exemplos de alto sucesso;
- Dependência exclusiva das variáveis disponíveis na base atual;
- Ausência de informações temporais, que poderiam capturar tendências de vendas.

---

🚀 6. Trabalhos Futuros  
Como extensões naturais do projeto, recomenda-se:

- Aplicar técnicas de balanceamento, como **SMOTE** ou **undersampling**;
- Realizar ajuste fino de hiperparâmetros do Random Forest;
- Avaliar outros métodos baseados em ensemble, como Gradient Boosting;
- Incorporar variáveis temporais e comportamentais;
- Explorar métricas orientadas ao negócio, como custo de erro por classe.

---

## 👨‍💻 Autor

João Batista Nery  
[LinkedIn](https://www.linkedin.com/in/joaobatistanery)

---

🇺🇸 English Version

# 🛒 Machine Learning Project – Product Success Prediction

📈 Results Discussion

📝 Overview  
The results indicate that the **Random Forest** model achieved the best overall performance among the evaluated algorithms, showing strong capability to capture non-linear patterns and complex feature interactions.

These findings align with existing literature, which highlights ensemble-based models as robust solutions for multiclass and imbalanced datasets.

---

🔍 1. Detailed Model Comparison  
The comparison shows that:

- **Random Forest** achieved the best balance between *precision* and *recall*;
- Higher **AUC** values indicate stronger discriminative power;
- **Logistic Regression** was limited by its linear assumptions;
- **kNN** was highly sensitive to data distribution;
- **SVM** struggled with minority class separation.

These results confirm Random Forest as a suitable model for real-world classification tasks.

---

📊 2. Confusion Matrix Analysis  
The confusion matrix reveals that:

- The **Moderate Success** class achieved high accuracy;
- Confusion between **Failure / Niche** and **Moderate Success** reflects unclear boundaries between borderline products;
- The **Viral / High Sales Success** class showed lower performance due to limited training samples.

This behavior highlights the influence of class imbalance.

---

📐 3. Classification Metrics  
Metric analysis shows:

- Overall accuracy around **0.77**;
- Weighted averages close to **0.75**, driven by majority classes;
- Lower macro averages, indicating uneven performance across classes.

---

🧪 4. Test Set Predictions  
When applied to the test set:

- Most products were classified as **Moderate Success**;
- Some were classified as **Failure / Niche**;
- Very few were classified as **Viral / High Sales Success**, consistent with training distribution.

From a business perspective, these predictions can support strategic decision-making.

---

🚧 5. Study Limitations  
Key limitations include:

- Significant class imbalance;
- Few viral examples;
- Limited feature set;
- Lack of temporal data.

---

🚀 6. Future Work  
Future improvements may include:

- Applying class balancing techniques;
- Hyperparameter tuning;
- Testing additional ensemble algorithms;
- Adding temporal and behavioral features;
- Evaluating business-oriented metrics.

## 👨‍💻 Author

João Batista Nery  
[LinkedIn](https://www.linkedin.com/in/joaobatistanery)

---
