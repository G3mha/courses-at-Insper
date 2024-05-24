#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <algorithm>
#include <omp.h>

using namespace std;

void initializeGrid(vector<vector<bool>>& grid) {
  int M = grid.size();
  int N = grid[0].size();
  srand(time(nullptr));
  for (int i = M / 2 - 6; i < M / 2 + 6; ++i) {
    for (int j = N / 2 - 6; j < N / 2 + 6; ++j) {
      grid[i][j] = rand() % 4 < 3; // Alive with probability 3/4
    }
  }
}

int countAliveNeighbors(const vector<vector<bool>>& grid, int x, int y) {
  int aliveNeighbors = 0;
  int M = grid.size();
  int N = grid[0].size();
  for (int i = -1; i <= 1; ++i) {
    for (int j = -1; j <= 1; ++j) {
      if (i == 0 && j == 0) continue; // Skip the cell itself
      int newX = (x + i + M) % M; // Wrap around for periodic boundary
      int newY = (y + j + N) % N;
      if (grid[newX][newY]) {
        ++aliveNeighbors;
      }
    }
  }
  return aliveNeighbors;
}

void nextGeneration(vector<vector<bool>>& grid, const vector<int>& Ssurvive, const vector<int>& Sbirth) {
  int M = grid.size();
  int N = grid[0].size();
  vector<vector<bool>> newGrid(M, vector<bool>(N, false));

  #pragma omp parallel for collapse(2)
  for (int i = 0; i < M; ++i) {
    for (int j = 0; j < N; ++j) {
      int neighbors = countAliveNeighbors(grid, i, j);
      if (grid[i][j] && find(Ssurvive.begin(), Ssurvive.end(), neighbors) != Ssurvive.end()) {
        newGrid[i][j] = true;
      } else if (!grid[i][j] && find(Sbirth.begin(), Sbirth.end(), neighbors) != Sbirth.end()) {
        newGrid[i][j] = true;
      }
    }
  }
  grid = newGrid;
}

void printGrid(const vector<vector<bool>>& grid) {
  int M = grid.size();
  int N = grid[0].size();
  // Imprimir a linha superior da borda
  cout << "+"; // Canto superior esquerdo
  for (int j = 0; j < N; ++j) {
    cout << "-"; // Linha superior da borda
  }
  cout << "+" << endl; // Canto superior direito

  for (int i = 0; i < M; ++i) {
    cout << "|"; // Início da linha da borda
    for (int j = 0; j < N; ++j) {
      cout << (grid[i][j] ? 'O' : ' '); // Célula viva ou morta
    }
    cout << "|" << endl; // Fim da linha da borda
  }

  // Imprimir a linha inferior da borda
  cout << "+"; // Canto inferior esquerdo
  for (int j = 0; j < N; ++j) {
    cout << "-"; // Linha inferior da borda
  }
  cout << "+" << endl; // Canto inferior direito
}

void timestamp() {
  char time_buffer[40];
  time_t now = time(nullptr);
  tm *tm = localtime(&now);
  strftime(time_buffer, sizeof(time_buffer), "%d %B %Y %I:%M:%S %p", tm);
  std::cout << time_buffer << std::endl;
}

int main() {
  timestamp();

  // Print OpenMP environment information
  #pragma omp parallel
  {
    int tid = omp_get_thread_num(); 
    if (tid == 0) {
      int procs = omp_get_num_procs();
      int nthreads = omp_get_num_threads();
      int maxt = omp_get_max_threads();
      int inpar = omp_in_parallel();

      cout << "Thread " << tid << " getting environment info...\n";
      cout << "Number of processors: " << procs << endl;
      cout << "Number of threads: " << nthreads << endl;
      cout << "Max threads: " << maxt << endl;
      cout << "In parallel? " << inpar << endl;
    }
  }

  const vector<int> grid_sizes = {64, 96, 128};
  const vector<int> threads = {2, 3, 4};
  const vector<int> Ssurvive = {3, 4, 5};
  const vector<int> Sbirth = {3};
  const int n_generations = 150;

  for (int grid_size : grid_sizes) {
    for (int num_threads : threads) {
      omp_set_num_threads(num_threads);

      cout << "Grid size: " << grid_size << "x" << grid_size << ", Threads: " << num_threads << endl;
      
      vector<vector<bool>> grid(grid_size, vector<bool>(grid_size, false));
      initializeGrid(grid);
      double start_time = omp_get_wtime();
      for (int generation = 1; generation <= n_generations; ++generation) {
        nextGeneration(grid, Ssurvive, Sbirth);
      }
      double end_time = omp_get_wtime();
      cout << "Time taken: " << (end_time - start_time) << " seconds" << endl;
    }
  }

  return 0;
}