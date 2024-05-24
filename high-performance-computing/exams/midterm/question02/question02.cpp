#include <iostream>
#include <vector>

bool subsetSum(const std::vector<int>& set, int sum) {
  if (sum == 0) {
    return true;
  }
  if (set.empty()) { 
    return false;
  }

  if (set.back() > sum) {
    return subsetSum(std::vector<int>(set.begin(), set.end() - 1), sum);
  }

    return subsetSum(std::vector<int>(set.begin(), set.end() - 1), sum) || 
           subsetSum(std::vector<int>(set.begin(), set.end() - 1), sum - set.back()); 
}

int main() {
  std::vector<std::vector<int>> sets = {{1, 2, 3},
                                        {1, 2, 3, 4},
                                        {1, 2, 3, 4, 5},
                                        {1, 2, 3, 4, 5, 6},
                                        {1, 2, 3, 4, 5, 6, 7},
                                        {1, 2, 3, 4, 5, 6, 7, 8},
                                        {1, 2, 3, 4, 5, 6, 7, 8, 9},
                                        {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
                                        {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
                                        {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}};
  std::vector<int> sums = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50};

  for (int i = 0; i < sets.size(); i++) {
    bool exists = subsetSum(sets[i], sums[i]);
    std::cout << "Conjunto " << i + 1 << " (" << sets[i].size() << " elementos): " << (exists ? "Sim" : "Não") << std::endl;
  }

  return 0;
}
