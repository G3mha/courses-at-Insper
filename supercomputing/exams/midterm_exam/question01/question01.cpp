#include <iostream>
#include <algorithm>
#include <vector>

bool subsetSum(const std::vector<int>& set, int sum) {
  std::vector<int> sortedSet = set;
  // Método de sorting extraído de: https://www.geeksforgeeks.org/sort-c-stl/
  std::sort(sortedSet.rbegin(), sortedSet.rend());

  int currentSum = 0;
  int i = 0;

  while (i < sortedSet.size() && currentSum < sum) {
    if (currentSum + sortedSet[i] <= sum) {
      currentSum += sortedSet[i];
      i++;
    } else {
      i++;
    }
  }

  return currentSum == sum;
}

int main() {
    std::vector<int> set = {3, 34, 4, 12, 5, 2};
    int sum = 9;

    bool solutionExists = subsetSum(set, sum);

    if (solutionExists) {
        std::cout << "Existe um subconjunto com a soma: " << sum;
    } else {
        std::cout << "Não existe um subconjunto com a soma: " << sum;
    }

    return 0;
}
