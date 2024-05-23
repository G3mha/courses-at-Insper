def subset_sum_combinada(set, sum, limite_profundidade):
  if sum == 0:
    return []
  if set.empty() or limite_profundidade == 0:
    return None

  ordenado = sorted(set, reverse=True)
  melhor_solucao = None

  for i in range(len(ordenado)):
    if ordenado[i] <= sum:
      solucao_rec = subset_sum_combinada(ordenado[i+1:], sum - ordenado[i], limite_profundidade - 1)
      if solucao_rec is not None:
        solucao_completa = [i] + solucao_rec
        if melhor_solucao is None or sum(solucao_completa) > sum(melhor_solucao):
          melhor_solucao = solucao_completa

  return melhor_solucao
