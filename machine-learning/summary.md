# Machine Learning

## O que é Machine Learning?

Campo de estudo que dá aos computadores a habilidade de aprender sem serem explicitamente programados.

## Conceitos básicos

- **training set**: conjunto de dados usados para treinar o modelo.

- **training instance (ou sample)**: um item do training set.

- **accuracy**: a proporção de instâncias corretamente classificadas.

- **data mining**: a ciência de extrair conhecimento útil de grandes conjuntos de dados.

- **overfitting**: quando o modelo é bom demais para ser verdade. O modelo se ajusta demais ao training set e não consegue generalizar bem para novos casos.

- **underfitting**: quando o modelo é muito simples para capturar a estrutura dos dados de treinamento.

- **attribute**: característica do dado (*e.g., "peso"*).

- **feature**: representa o **attribute** e o seu valor (*e.g., "peso = 90kg"*).

## Onde aplicar ML?

- Para conseguir insights sobre problemas complexos e grandes quantidades de dados.

- Para ambientes flutuantes (muitas mudanças que exigem adaptação do algoritmo).

- Para problemas complexos para os quais não existe uma solução boa usando uma abordagem tradicional.

- Para simplificar código existente (com muitas regras, que exigem manutenção) e obter melhor performance.

## Tipos de ML (divisões não excludentes)

1. Se são ou não treinados com supervisão humana (supervisionado, não supervisionado, semissupervisionado e por reforço).

2. Se podem ou não aprender incrementalmente em dados em fluxo (online versus batch learning).

3. Se trabalham simplesmente comparando novos dados com dados conhecidos ou se detectam padrões nos dados e constroem um modelo preditivo (aprendizado por instância versus aprendizado por modelo).

## Aprendizado supervisionado vs. não supervisionado

- **Supervisionado**: o conjunto de treinamento é composto de instâncias (amostras) e suas classificações (labels). É frequentemente utilizado para **classificação** (prever uma classe) e **regressão** (prever um valor). Alguns algoritmos de classificação são: k-Nearest Neighbors, Linear Regression, Logistic Regression, Support Vector Machines (SVMs), Decision Trees and Random Forests, Neural networks.

- **Não supervisionado**: o conjunto de treinamento é composto apenas de instâncias (amostras), sem classificações (labels). É frequentemente utilizado para **clustering** (agrupar instâncias similares) e **visualization** (encontrar padrões em dados de alta dimensão). Alguns algoritmos de clustering são: k-Means, Hierarchical Cluster Analysis (HCA), Expectation Maximization. Alguns algoritmos de visualization são: Principal Component Analysis (PCA), Kernel PCA, Locally-Linear Embedding (LLE), t-distributed Stochastic Neighbor Embedding (t-SNE).

- **Semissupervisionado**: o conjunto de treinamento é composto de instâncias (amostras) e algumas de suas classificações (labels). É frequentemente utilizado quando o conjunto de treinamento é grande e apenas uma pequena parte dele está classificada. Alguns algoritmos de semissupervisionado são: Deep Belief Networks (DBNs), Autoencoders.

- **Por reforço**: o algoritmo aprende através de tentativa e erro, recebendo feedbacks em forma de recompensas ou punições. Ao longo do tempo, o algoritmo aprende a melhor estratégia para maximizar a recompensa, e essa estratégia é chamada de **policy**. Um policy define o que o agente deve fazer em determinada situação. Alguns algoritmos de por reforço são: Q-Learning, Temporal Difference (TD), Deep Q-Networks (DQN), Policy Gradients.
