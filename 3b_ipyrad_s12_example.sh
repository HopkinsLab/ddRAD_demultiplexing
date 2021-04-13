#!/bin/bash
 
#SBATCH -n 8                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -t 2-00:00              # Runtime in D-HH:MM
#SBATCH -p shared		        # Partition to submit to
#SBATCH --mem=48000             # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o ipyrad_s12_%A.out    # File to which STDOUT will be written
#SBATCH -e ipyrad_s12_%A.err    # File to which STDERR will be written
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[you]@g.harvard.edu      # Email to which notifications will be sent

source activate [env_name]

cd /n/holyscratch01/hopkins_lab/[you]/ipyrad/ipyrad_assembly01

ipyrad -p params-[name_of_assembly].txt -s 12