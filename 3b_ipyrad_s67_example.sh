#!/bin/bash
 
#SBATCH -n 8                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -t 5-00:00              # Runtime in D-HH:MM
#SBATCH -p shared		        # Partition to submit to
#SBATCH --mem=64000             # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o c3_93_s67_%A.out      # File to which STDOUT will be written
#SBATCH -e c3_93_s67_%A.err      # File to which STDERR will be written
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=bgoulet@g.harvard.edu      # Email to which notifications will be sent

source activate ipyradenv5

cd /n/holyscratch01/hopkins_lab/ben/radseq/coxburg/2_ipyrad

ipyrad -p params-c3_clust93_req4.txt -s 67