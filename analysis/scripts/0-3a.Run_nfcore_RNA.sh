#!/bin/bash

# display the date for future tracking
echo `date`
echo "Bash shell version is: $BASH_VERSION"
echo `$PWD`

## Load modules
ml purge
ml Nextflow/21.10.6
ml Singularity/3.6.4
ml CAMP_proxy


## Path to where Singularity containers are stored
export NXF_SINGULARITY_CACHEDIR=/camp/apps/misc/stp/babs/nf-core/singularity/rnaseq/3.7/

## Output Nextflow “work” directory to scratch space
export NXF_WORK=`echo $PWD/work/ | sed 's:^/camp/stp/babs/working/:/camp/stp/babs/scratch/:'`
if [ ! -d "$NXF_WORK" ]; then
    ln -s $NXF_WORK .
fi

## Insert paths
DATA_DIR=/camp/stp/babs/working/strohbs/projects/guillemotf/oana.paun/op17_PM21134_ChIP_SWI_SNFxASCL1/data/
GENOME_DIR=/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh37/release-75

## Run pipeline
nextflow run nf-core/rnaseq \
    --input design.csv \
    --aligner star_rsem \
    --fasta $GENOME_DIR/genome/Homo_sapiens.GRCh37.75.dna_sm.primary_assembly.fa \
    --gtf $GENOME_DIR/gtf/Homo_sapiens.GRCh37.75.gtf \
    --email stephanie.strohbuecker@crick.ac.uk \
    --outdir $DATA_DIR/derived_data/nfcore_RNA/ \
    -profile crick \
    -r 3.7 \
    -resume

