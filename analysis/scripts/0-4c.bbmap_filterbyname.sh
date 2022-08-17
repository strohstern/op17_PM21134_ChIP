#!/bin/bash


params=$1

IFS=' ' read -ra my_array <<< "$params"

read_ids=${my_array[0]}
new_fastq=${my_array[1]}
fastq_read1=${my_array[2]}
fastq_read2=${my_array[3]}

module purge
module load BBMap/36.20-foss-2016b-Java-1.8.0_92


if [ $fastq_read2 == "NA" ]; then
      echo "\$fastq_read2 is empty: $fastq_read2"
      
      instruction="filterbyname.sh \
          in=$fastq_read1 \
          out=${new_fastq}_read1.fastq.gz \
          include=f \
          usejni=t \
          names=$read_ids"
          
      filterbyname.sh \
          in=$fastq_read1 \
          out=${new_fastq}_read1.fastq.gz \
          include=f \
          usejni=t \
          names=$read_ids
else
      echo "\$fastq_read2 is NOT empty: $fastq_read2"
      
      instruction="filterbyname.sh \
          in=$fastq_read1 \
          in2=$fastq_read2 \
          out=${new_fastq}_read1.fastq.gz \
          out2=${new_fastq}_read2.fastq.gz \
          include=f \
          usejni=t \
          names=$read_ids"
          
      filterbyname.sh \
          in=$fastq_read1 \
          in2=$fastq_read2 \
          out=${new_fastq}_read1.fastq.gz \
          out2=${new_fastq}_read2.fastq.gz \
          include=f \
          usejni=t \
          names=$read_ids
fi

echo " "               
echo $instruction