#!/bin/bash
#SBATCH --partition=prova
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=3G

export OMP_NUM_THREADS=10

./executavel
