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
    std::cout << "SEARCH - Serial version\n"
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

    // Send portion size, target value and actual portion to other processes
    for (int i = 1; i < size; ++i) {
      MPI_Send(&portion_size, 1, MPI_INT, i, 0, MPI_COMM_WORLD);
      MPI_Send(&target, 1, MPI_INT, i, 0, MPI_COMM_WORLD);
      MPI_Send(array.data() + i * portion_size, portion_size, MPI_INT, i, 0, MPI_COMM_WORLD);
    }

    // Local array for rank 0
    local_array = std::vector<int>(array.begin(), array.begin() + portion_size);
  } else {
    // Receive portion size and target value
    MPI_Recv(&portion_size, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    MPI_Recv(&target, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

    // Resize local array and receive portion of the array
    local_array.resize(portion_size);
    MPI_Recv(local_array.data(), portion_size, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
  }

  // Perform local search
  int local_count = 0;
  for (int i = 0; i < portion_size; ++i) {
    if (local_array[i] == target) {
      local_count++;
    }
  }
  

  if (rank != 0) { 
    // Send local count to rank 0
    MPI_Send(&local_count, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
  } else { 
    // Collect results from all processes
    int total_count = local_count;
    for (int i = 1; i < size; ++i) {
      int recv_count;
      MPI_Recv(&recv_count, 1, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      total_count += recv_count;
    }

    // Print results
    std::cout << "Number " << target << " occurs " << total_count << " times\n";
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
