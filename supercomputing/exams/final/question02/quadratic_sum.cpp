#include <iostream>
#include <vector>
#include <ctime>
#include <cstdlib>
#include <omp.h>
#include <mpi.h>
#include <algorithm>
#include <functional>
#include <chrono>

using namespace std;
using namespace std::chrono;

void timestamp();

int main(int argc, char* argv[]) {
  int rank, size;
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);

  std::vector<int> array;
  int array_size, portion_size;
  std::vector<int> local_array;

  if (rank == 0) { // Manager
    srand(static_cast<unsigned>(time(nullptr)));

    timestamp();
    std::cout << "QUADRATIC SUM - MPI/OpenMP version\n"
              << "An example program to find the quadratic sum of an array.\n";

    // Define amount of vector's elements
    array_size = 100000;
    std::cout << "The number of data items is " << array_size << ".\n";

    // Fill the array with 2s
    array.resize(array_size);
    for (int& value : array) {
      value = 2;
    }

    // Determine the portion size for each process
    portion_size = array_size / size;
  }

  // Broadcast array size and portion size to all processes
  MPI_Bcast(&array_size, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(&portion_size, 1, MPI_INT, 0, MPI_COMM_WORLD);

  // Resize array for non-zero processes
  if (rank != 0) {
    array.resize(array_size);
  }

  // Scatter array portions to all processes
  local_array.resize(portion_size);
  MPI_Scatter(array.data(), portion_size, MPI_INT, local_array.data(), portion_size, MPI_INT, 0, MPI_COMM_WORLD);

  // Perform local search
  int local_count = 0;
  omp_set_num_threads(omp_get_max_threads());
  #pragma omp parallel for reduction(+ : local_count) // Reduction Operators: (+, -, *, &, |, ^, && and ||)
  for (int i = 0; i < portion_size; ++i) {
    local_count += local_array[i] * local_array[i];
  }

  // Reduce local counts to rank 0
  int total_count = 0;
  MPI_Reduce(&local_count, &total_count, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

  if (rank == 0) {
    // Print the total count
    std::cout << "Quadratic sum: " << total_count << "\n";
  }

  MPI_Finalize();
  return 0;
}

void timestamp() {
  char time_buffer[40];
  time_t now = time(nullptr);
  tm *tm = localtime(&now);
  strftime(time_buffer, sizeof(time_buffer), "%d %B %Y %I:%M:%S %p", tm);
  std::cout << time_buffer << std::endl;
}
