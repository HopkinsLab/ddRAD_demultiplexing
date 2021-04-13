#!/bin/bash
#SBATCH -p shared                                               # Partition to submit to
#SBATCH -n 16                                           # Number of cores
#SBATCH -N 1                                            # Ensure that all cores are on one machine
#SBATCH -t 3-0:00                                       # Runtime in days-hours:minutes
#SBATCH --mem 100000                                    # Memory in MB
#SBATCH -J trimmomatic                                  # job name
#SBATCH -o trimmomatic_%A.out                   # File to which standard out will be written
#SBATCH -e trimmomatic_%A.err                   # File to which standard err will be written
#SBATCH --mail-type=ALL                                 # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=schaturvedi@fas.harvard.edu     # Email to which notifications will be sent

# load a java module
module load jdk/10.0.1-fasrc01

# move to working directory
cd /n/holyscratch01/hopkins_lab/Chaturvedi/ddrad_sam_april2021/trimmomatic/

# make directories for paired and unpaired reads
#mkdir trim_paired
#mkdir trim_unpaired

for i in $(ls *.fastq | sed -r 's/_R[12]_CF.fastq//' | uniq)
do
        java -jar Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 "${i}_R1_CF.fastq" "${i}_R2_CF.fastq" /n/holyscratch01/hopkins_lab/Chaturvedi/ddrad_sam_april2021/trimmomatic/trim_paired/"${i}_R1_paired.fastq" /n/holyscratch01/hopkins_lab/Chaturvedi/ddrad_sam_april2021/trimmomatic/trim_unpaired/"${i}_R1_unpaired.fastq" /n/holyscratch01/hopkins_lab/Chaturvedi/ddrad_sam_april2021/trimmomatic/trim_paired/"${i}_R2_paired.fastq" /n/holyscratch01/hopkins_lab/Chaturvedi/ddrad_sam_april2021/trimmomatic/trim_unpaired/"${i}_R2_unpaired.fastq" ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
