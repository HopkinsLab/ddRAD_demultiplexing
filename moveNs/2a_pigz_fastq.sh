#!/bin/bash
#SBATCH -p serial_requeue	# Partition to submit to
#SBATCH -n 16               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 2-0:00           # Runtime in days-hours:minutes
#SBATCH --mem 32000         # Memory in MB
#SBATCH -J pigz             # job name
#SBATCH -o pigz_%A.out         # File to which standard out will be written
#SBATCH -e pigz_%A.err         # File to which standard err will be written
#SBATCH --mail-type=ALL        				# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[your email]	# Email to which notifications will be sent

source new-modules.sh
module load GCC/8.2.0-2.31.1 pigz/2.4


cd /n/holyscratch01/hopkins_lab/[directory that contains only your split raw reads files ending in .fastq]


pigz -p 16 --best *.fastq