#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <mpi.h>

void timestamp();

int main(int argc, char* argv[]) {
  int rank, size;
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);

  std::vector<int> array;
  int array_size, target, portion_size;
  std::vector<int> local_array;

  if (rank == 0) { // Manager
    srand(static_cast<unsigned>(time(nullptr)));

    timestamp();
    std::cout << "SEARCH - MPI version\n"
              << "An example program to search an array.\n";

    // Define amount of vector's elements
    array_size = 1000 + (rand() % 151);
    std::cout << "The number of data items is " << array_size << ".\n";

    // Fill the array with random values between 0 and 1000
    array.resize(array_size);
    for (int& value : array) {
      value = rand() % 1001;
    }

    // Select the target value to search
    target = array[array_size / 2];
    std::cout << "The target value is " << target << ".\n";

    // Determine the portion size for each process
    portion_size = array_size / size;
  }

  // Broadcast array size and portion size to all processes
  MPI_Bcast(&array_size, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(&portion_size, 1, MPI_INT, 0, MPI_COMM_WORLD);

  // Broadcast target to all processes
  MPI_Bcast(&target, 1, MPI_INT, 0, MPI_COMM_WORLD);

  // Scatter array portions to all processes
  local_array.resize(portion_size);
  MPI_Scatter(array.data(), portion_size, MPI_INT, local_array.data(), portion_size, MPI_INT, 0, MPI_COMM_WORLD);

  // Perform local search and collect indices
  int local_count = 0;
  std::vector<int> local_indices;
  for (int i = 0; i < portion_size; ++i) {
    if (local_array[i] == target) {
      local_indices.push_back(i + rank * portion_size);
      local_count++;
    }
  }

  // Gather all counts and indices at rank 0
  std::vector<int> all_counts(size);
  MPI_Gather(&local_count, 1, MPI_INT, all_counts.data(), 1, MPI_INT, 0, MPI_COMM_WORLD);

  // Calculate the total number of occurrences and prepare to receive all indices
  std::vector<int> recv_counts(size);
  std::vector<int> displs(size);
  int total_count = 0;

  if (rank == 0) {
    for (int i = 0; i < size; ++i) {
      total_count += all_counts[i];
      recv_counts[i] = all_counts[i];
      displs[i] = (i == 0) ? 0 : displs[i - 1] + recv_counts[i - 1];
    }
  }

  // Gather all indices at rank 0
  std::vector<int> all_indices(total_count);
  MPI_Gatherv(local_indices.data(), local_count, MPI_INT, all_indices.data(), recv_counts.data(), displs.data(), MPI_INT, 0, MPI_COMM_WORLD);

  if (rank == 0) {
    // Print the total count and indices
    std::cout << "Number " << target << " occurs " << total_count << " times at indices: ";
    for (int index : all_indices) {
      std::cout << index << " ";
    }
    std::cout << std::endl;
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
