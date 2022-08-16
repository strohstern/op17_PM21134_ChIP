#!/bin/sh

module purge
module load cutadapt/3.4-GCCcore-10.3.0

fastq_file=$1
out_fastq=$2

instruction="cutadapt --cores=4 -l 100 -o $out_fastq $fastq_file"

echo $instruction

cutadapt --cores=4 -l 100 -o $out_fastq $fastq_file