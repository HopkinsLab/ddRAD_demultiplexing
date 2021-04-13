#!/bin/bash

# do this on an interactive node
srun -p test -n 1 -N 1 --pty --mem 4000 -t 0-04:00 /bin/bash

# load Java module
module load jdk/10.0.1-fasrc01

# set working directory
cd /n/holyscratch01/hopkins_lab/[you]/ipyrad/trimmomatic

# download trimmomatic
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.35.zip

# unzip
unzip Trimmomatic-0.35.zip

# move illumina parameters file to working directory
cp /n/holyscratch01/hopkins_lab/[you]/ipyrad/trimmomatic/Trimmomatic-0.35/adapters/TruSeq3-PE.fa /n/holyscratch01/hopkins_lab/[you]/ipyrad/trimmomatic/ ### this just puts this file into your working directory
