#!/bin/bash

R1file=$1
R2file=$2
name=${R1file##*\/}
prefix=${name%_R1*}
barcodes=$3
mkdir -p demultiplex/stacks_1PR

process_radtags -1 $R1file -2 $R2file \
  --paired \
  -b $barcodes \
  -o demultiplex/stacks_1PR/ \
  -i fastq -y fastq \
  -c -q \
  --retain_header \
  --inline_inline \
  --renz_1 'pstI' --renz_2 'mspI'


mkdir -p demultiplex/stacks_1PR/rem/
mkdir -p demultiplex/logs
mv demultiplex/stacks_1PR/*.rem.* demultiplex/stacks_1PR/rem/
mv demultiplex/stacks_1PR/process_radtags* logs/"$prefix"_PR.log

# rename files
for i in demultiplex/stacks_1PR/*.1.fq; do
  name=${i##*\/}
  prefix=${name%%.*}
  mv demultiplex/stacks_1PR/"$name" demultiplex/stacks_1PR/"$prefix"_R1_PR.fastq
done

for i in demultiplex/stacks_1PR/*.2.fq; do
  name=${i##*\/}
  prefix=${name%%.*}
  mv demultiplex/stacks_1PR/"$name" demultiplex/stacks_1PR/"$prefix"_R2_PR.fastq
done
