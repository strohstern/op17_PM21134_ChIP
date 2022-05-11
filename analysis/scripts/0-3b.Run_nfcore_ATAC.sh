#!/bin/sh

module purge

# check that this is the appropriate nextflow version
module load nextflow/21.04.0-edge 
module load Singularity/3.6.4
module load CAMP_proxy

# Path to where the Singularity containers are stored

export NXF_SINGULARITY_CACHEDIR=/camp/apps/misc/stp/babs/nf-core/singularity/atacseq/1.2.1

# Pull latest version of pipeline locally

nextflow pull nf-core/atacseq

## Output Nextflow “work” directory to scratch space

export NXF_WORK=`echo $PWD/work/ | sed 's:^/camp/stp/babs/working/:/camp/stp/babs/scratch/:'`
if [ ! -d "$NXF_WORK" ]; then
  mkdir -p $NXF_WORK 
  ln -s $NXF_WORK .
fi

# Run pipeline
    #--narrow_peak \

GENOME_DIR=/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh37/release-75

nextflow run nf-core/atacseq \
    --input design.csv \
    --macs_gsize 2.7e9 \
    --min_reps_consensus 1 \
    --narrow_peak \
    --fasta $GENOME_DIR/genome/Homo_sapiens.GRCh37.75.dna_sm.primary_assembly.fa \
    --gtf $GENOME_DIR/gtf/Homo_sapiens.GRCh37.75.gtf \
    --email stephanie.strohbuecker@crick.ac.uk \
    -c custom.config\
    -profile crick \
    -r 1.2.1 \
    -resume
