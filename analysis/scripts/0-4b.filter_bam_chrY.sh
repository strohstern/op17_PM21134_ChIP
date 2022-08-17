#!/bin/bash


params=$1

IFS=' ' read -ra my_array <<< "$params"

input_bam=${my_array[0]}
output=${my_array[1]}

module purge
module load SAMtools/1.15.1-GCC-11.2.0

instruction="samtools view --threads 6 $input_bam 'Y'| cut -f 1  > ${output}.read.names.txt"
                
echo $instruction

samtools view --threads 6 $input_bam 'Y'| cut -f 1  > ${output}.read.names.txt

