#!/bin/sh

module purge
module load Anaconda3/2021.11
module load BEDTools/2.29.2-GCC-9.3.0

source deactivate
source activate final-abc-env

H3K27ac_bam_file_list=$1 #comma delimited
ATAC_bam_file_list=$2 #comma delimited
RNA_file_list=$3 #comma delimited
outdir=$4

chrom_sizes="/camp/stp/babs/working/strohbs/projects/guillemotf/oana.paun/op17_PM21134_ChIP_SWI_SNFxASCL1/data/derived_data/Tables/3-2.ABC_algorithm_TSS_annotation/Homo_sapiens.GRCh37.75.chr_sizes"
genes_file="/camp/stp/babs/working/strohbs/projects/guillemotf/oana.paun/op17_PM21134_ChIP_SWI_SNFxASCL1/data/derived_data/Tables/3-2.ABC_algorithm_TSS_annotation/Homo_sapiens.GRCh37.75.CollapsedGeneBounds.sort.bed"
ubi_genes_file="/camp/stp/babs/working/strohbs/projects/guillemotf/oana.paun/op17_PM21134_ChIP_SWI_SNFxASCL1/data/derived_data/Tables/3-2.ABC_algorithm_TSS_annotation/UbiquitouslyExpressedGenesHG19_BioMartExport_EnsemblID.txt"
cand_peaks="/camp/stp/babs/working/strohbs/projects/guillemotf/oana.paun/op17_PM21134_ChIP_SWI_SNFxASCL1/data/derived_data/Tables/3-3.ABC_algorithm_alt_step1/consensus_DiffBind_macs_narrowPeak_candidateRegions_sorted.bed"

instruction="python  ~/software/ABC-Enhancer-Gene-Prediction/src/run.neighborhoods.py \
    --candidate_enhancer_regions $cand_peaks \
    --genes $genes_file \
    --H3K27ac $H3K27ac_bam_file_list \
    --ATAC $ATAC_bam_file_list \
    --expression_table $RNA_file_list \
    --chrom_sizes $chrom_sizes \
    --ubiquitously_expressed_genes $ubi_genes_file \
    --outdir ${outdir}/Neighborhoods/"

echo $instruction

python  ~/software/ABC-Enhancer-Gene-Prediction/src/run.neighborhoods.py \
    --candidate_enhancer_regions $cand_peaks \
    --genes $genes_file \
    --H3K27ac $H3K27ac_bam_file_list \
    --ATAC $ATAC_bam_file_list \
    --expression_table $RNA_file_list \
    --chrom_sizes $chrom_sizes \
    --ubiquitously_expressed_genes $ubi_genes_file \
    --outdir ${outdir}/Neighborhoods/

source deactivate