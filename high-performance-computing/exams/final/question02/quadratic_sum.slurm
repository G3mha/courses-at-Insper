#!/bin/bash
#SBATCH --partition=espec
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=500M

export OMP_NUM_THREADS=10

mpirun --allow-run-as-root -np 4 ./quadratic_sum
