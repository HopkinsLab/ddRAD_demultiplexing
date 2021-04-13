#!/bin/bash

dir=$1
mkdir -p demultiplex/stacks_2CF

for i in $dir/*_R1_*; do
  name=${i##*\/}
  prefix=${name%_R1_*}
  suffix=${name#*_R1_}

  clone_filter -1 $dir/"$prefix"_R1_"$suffix" -2 $dir/"$prefix"_R2_"$suffix"\
    -o demultiplex/stacks_2CF/ \
    -P -i fastq -y fastq \
    --oligo_len_1 5 \
    --null_index
done

# rename files
for i in demultiplex/stacks_2CF/*.1.fq; do
  name=${i##*\/}
  prefix=${name%_*}
  mv demultiplex/stacks_2CF/"$name" demultiplex/stacks_2CF/"$prefix"_CF.fastq
done

for i in demultiplex/stacks_2CF/*.2.fq; do
  name=${i##*\/}
  prefix=${name%_*}
  mv demultiplex/stacks_2CF/"$name" demultiplex/stacks_2CF/"$prefix"_CF.fastq
done
