# Machine Learning

## Abordagem de treino e avaliação

### Sem separação

- usar todos os dados para treino
- medir o desempenho dos mesmos dados
- **desvantagem**: sem avaliação "honesta"
- **conclusão**: é uma abordagem ruim

### Separação treino-teste

- parte dos dados para treinar
- outra parte independente para testar
- **vantagem**: avaliação "honesta"
- **desvantagem**:
  - não tem conjunto de "validação" para comparar modelos
  - apenas uma medida "honesta" de avaliação
- **conclusão**: não compara modelos

### Separação treino-validação-teste

- parte dos dados para treinar
- parte dos dados para comparar modelo, investigar overfitting, etc
- parte dos dados para uma avaliação final
- **vantagem**: avaliação "honesta" entre modelos
- **desvantagens**:
  - conjunto de treino cada vez menor
  - apenas 1 medida de desempenho para fazer a escolha
- **conclusão**: simples e bom

### Validação cruzada

![asset1.drawio.png](asset1.drawio.png)

- **vantagem**: temos "cv" medidas "honestas" de desempenho => comparamos modelos por teste de hipótese
- **desvantagem**: custo computacional

## Sensibilidade e Especificidade

- _sensibility_ = _recall_ = _TPR_ = $\frac{TP}{P}$ = $\frac{TP}{(TP + FN)}$

_TPR = true positive ratio_;
_P = total positives_;
_TP = true total positives_;
_FN = false total negatives_.

- _specificity_ = _negative "recall"_ = _TNR_ = $\frac{TN}{N}$ = $\frac{TN}{(TN + FP)}$

_TNR = true negative ratio_;
_N = total negatives_;
_TN = true total negatives_;
_FP = false total positives_.

![asset2.drawio.png](asset2.drawio.png)

$A \cup C = Prob(f(x_p)>f(x_n))$
