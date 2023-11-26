# Introduction to Machine Learning

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

## Aprendizado online vs. batch learning

- **Online**: o sistema é capaz de aprender incrementalmente, com velocidade e baixo custo, à medida que novos dados chegam. Alguns algoritmos de online learning são: Stochastic Gradient Descent (SGD), Learning Rate Scheduling, Mini-batch Gradient Descent.

- **Batch**: o sistema é incapaz de aprender incrementalmente. Ele deve ser treinado usando todo o conjunto de dados disponível. Isso geralmente é feito offline. Alguns algoritmos de batch learning são: Linear Regression, Polynomial Regression, Logistic Regression, Support Vector Machines (SVMs), Decision Trees and Random Forests, Neural networks.

## Aprendizado por instância vs. aprendizado por modelo

- **Por instância**: o sistema aprende exemplos específicos do conjunto de treinamento. É semelhante ao aprendizado online, pois pode ser usado para sistemas de aprendizado incremental. Alguns algoritmos de por instância são: k-Nearest Neighbors, Support Vector Machines (SVMs).

- **Por modelo**: o sistema constrói um modelo a partir do conjunto de treinamento e faz previsões para novos casos usando o modelo. É semelhante ao aprendizado batch. Alguns algoritmos de por modelo são: Linear Regression, Polynomial Regression, Logistic Regression, Decision Trees and Random Forests, Neural networks.

## Passos para um projeto de ML

- Estudar o dataset.

- Selecionar um modelo.

- Treinar o modelo.

- *Inference* - usar o modelo para fazer previsões (e esperar que elas sejam boas).

## Desafios de ML

- **Insuficiência de dados**: um modelo de ML precisa de dados para aprender. Se o modelo não tiver dados suficientes, ele não conseguirá fazer boas previsões.

- **Dados não representativos**: para que um modelo de ML generalize bem, é necessário que os dados de treinamento sejam representativos do novo caso. Se os dados não forem representativos, o modelo não conseguirá fazer boas previsões.

- **Dados de baixa qualidade**: é importante que os dados de treinamento estejam limpos, sem ruídos e sem outliers. Se os dados estiverem sujos, o modelo não conseguirá fazer boas previsões.

- **Features irrelevantes**: é importante que o modelo tenha features relevantes para o problema. Se o modelo tiver features irrelevantes, ele não conseguirá fazer boas previsões.

- **Overfitting**: um modelo de ML precisa ser simples o suficiente para generalizar bem. Se o modelo for complexo demais, ele se ajustará demais ao conjunto de treinamento e não conseguirá fazer boas previsões.

- **Underfitting**: um modelo de ML precisa ser complexo o suficiente para capturar a estrutura dos dados de treinamento. Se o modelo for muito simples, ele não conseguirá fazer boas previsões.

## Hyperparameters tuning

- **Hyperparameters**: são parâmetros que não são aprendidos pelo modelo. Eles são definidos antes do treinamento e não mudam durante o treinamento. Exemplos de hyperparameters são: learning rate, batch size, number of hidden layers, number of neurons per layer, activation function, etc.

- **Hyperparameters tuning**: é o processo de encontrar a combinação ideal de hyperparameters para um modelo de ML. É um processo de tentativa e erro. É importante que o modelo seja avaliado em um conjunto de validação (não usado no treinamento) para que o processo de hyperparameters tuning não cause overfitting.

- **Model Selection**: é o processo de comparar vários modelos de ML e selecionar o melhor modelo para o problema. É importante que o modelo seja avaliado em um conjunto de validação (não usado no treinamento) para que o processo de model selection não cause overfitting.
