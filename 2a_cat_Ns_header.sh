#!/bin/bash
 
#SBATCH -n 16                   # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -t 2-00:00              # Runtime in D-HH:MM
#SBATCH -p shared		        # Partition to submit to
#SBATCH --mem=32000             # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o cat_v11_%A.out     	# File to which STDOUT will be written
#SBATCH -e cat_v11_%A.err    	# File to which STDERR will be written
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[your email]     # Email to which notifications will be sent


cd /n/holyscratch01/hopkins_lab/[directory containing split and edited reads, the output of Beths Move_Ns script]


cat raw_reads_split/Ben_S2_L001_R1_001_aa.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ab.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ac.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ad.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ae.fastq.gzedited > reads_cat/Ben_S2_L001_edited_R1.fastq
cat raw_reads_split/Ben_S2_L001_R2_001_aa.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ab.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ac.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ad.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ae.fastq.gzedited > reads_cat/Ben_S2_L001_edited_R2.fastq
