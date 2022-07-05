#!/bin/sh

module purge
module load BamTools/2.5.1-intel-2017b

bam_files=$1
outdir_file=$2

instruction="samtools merge \
    -@ 8 \
    $outdir_file \
    $bam_files"

echo $instruction

samtools merge \
    -@ 8 \
    ${outdir_file}.bam \
    $bam_files

instruction2="samtools sort \
    -@ 8 \
    -o ${outdir_file}.sorted.bam \
    ${outdir_file}.bam"

echo $instruction2

samtools sort \
    -@ 8 \
    -o ${outdir_file}.sorted.bam \
    ${outdir_file}.bam

instruction3="samtools index \
    -@ 8 \
    ${outdir_file}.sorted.bam"

echo $instruction3

samtools index \
    -@ 8 \
    ${outdir_file}.sorted.bam