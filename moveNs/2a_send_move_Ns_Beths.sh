#!/bin/bash
#SBATCH -p shared			       			# Partition to submit to
#SBATCH -n 5	                   			# Number of cores
#SBATCH -N 1                   				# Ensure that all cores are on one machine
#SBATCH -t 7-00:00               			# Runtime in days-hours:minutes
#SBATCH --mem 64000              			# Memory in MB
#SBATCH -J move_Ns             				# job name
#SBATCH -o move_Ns_%A.out        			# File to which standard out will be written
#SBATCH -e move_Ns_%A.err        			# File to which standard err will be written
#SBATCH --mail-type=ALL        				# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[your email]			# Email to which notifications will be sent


source new-modules.sh
module load python/2.7.14-fasrc02

cd /n/holyscratch01/hopkins_lab/[directory containing subdirectory 'scripts' and subdirectory 'demultiplex' or however you want to organize]

# run Beth's script to move N's from sequence to header
# 2a_Move_Ns_to_header_both_seqs.py

# python path/to/Move_Ns_to_header_both_seqs.py path/to/split_raw_reads_R1_aa.fastq.gz path/to/split_raw_reads_R2_aa.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_aa.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_aa.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ab.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ab.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ac.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ac.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ad.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ad.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ae.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ae.fastq.gz &

wait

