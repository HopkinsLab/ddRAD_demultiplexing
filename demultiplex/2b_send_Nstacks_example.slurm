#!/bin/bash
#SBATCH -p shared       					# Partition to submit to
#SBATCH -n 1                   				# Number of cores
#SBATCH -N 1                   				# Ensure that all cores are on one machine
#SBATCH -t 3-0:00               			# Runtime in days-hours:minutes
#SBATCH --mem 16000              			# Memory in MB
#SBATCH -J stacks_dm             			# job name
#SBATCH -o Nstacks_example_%A.out     		# File to which standard out will be written
#SBATCH -e Nstacks_example_%A.err     		# File to which standard err will be written
#SBATCH --mail-type=ALL        				# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[you]@g.harvard.edu		# Email to which notifications will be sent

# YOUR HOME DIRECTORY HERE
# this directory should include: 
#	your raw reads files
#	a subdirectory named 'scripts' that contains '2a_run_stacks_1PR_example.sh' and '2a_run_stacks_2CF_example.sh'
#	a subdirectory named 'demultiplex' that contains your barcodes file
myhome="/n/holyscratch01/hopkins_lab/[you]/ipyrad"

# YOUR PREFIX HERE
# this should match the beginning of the file names of your unzipped raw reads, which should end with '_R1.fastq' or '_R2.fastq'
prefix="[RADseq_run]"

# YOUR BARCODES FILE HERE
# column 1 = PstI barcode [tab], column 2 = MspI barcode [tab], column 3 = sample_name
barcodes="2a_barcodes_example.txt"


cd $myhome

module purge
module load gcc/7.1.0-fasrc01 stacks/2.4-fasrc01


# call the two scripts to perform the two demultiplexing functions in STACKS (process radtags, clone filtering)
# make sure these scripts are named correctly, are in the correct directory ($myhome/scripts), and are executable

./scripts/2a_run_stacks_1PR_example.sh \
  demultiplex/"$prefix"_R1.fastq \
  demultiplex/"$prefix"_R2.fastq \
  demultiplex/$barcodes

./scripts/2a_run_stacks_2CF_example.sh \
  demultiplex/stacks_1PR
