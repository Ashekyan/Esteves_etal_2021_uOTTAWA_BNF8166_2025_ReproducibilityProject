#!/bin/bash
#SBATCH --job-name=ATACseq_run
#SBATCH --account=<CCDB_ACCOUNT>
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --output=ATACseq_%j.out
#SBATCH --error=ATACseq_%j.err
# Optional: uncomment if your cluster requires an explicit partition
# SBATCH --partition=<PARTITION_NAME>

set -euo pipefail

#### Load required modules on Nibi / Compute Canada
module purge
module load StdEnv/2023
module load apptainer
module load nextflow

#### Define Nextflow and Apptainer cache / temporary directories
export NXF_HOME=<PATH_TO_NEXTFLOW_HOME>
export NXF_SINGULARITY_CACHEDIR=<PATH_TO_APPTAINER_CACHE>
export NXF_APPTAINER_CACHEDIR=<PATH_TO_APPTAINER_CACHE>
export TMPDIR=<PATH_TO_TEMP_DIR>
export APPTAINERENV_TMPDIR=<PATH_TO_TEMP_DIR>
mkdir -p "$TMPDIR"

#### Move to the project working directory
cd <PROJECT_DIRECTORY>

#### Run nf-core/atacseq
nextflow run nf-core/atacseq \
  -profile singularity \
  --input <PATH_TO_SAMPLESHEET_CSV> \
  --fasta <PATH_TO_REFERENCE_FASTA> \
  --bwa_index <PATH_TO_BWA_INDEX_DIRECTORY> \
  --gtf <PATH_TO_ANNOTATION_GTF> \
  --macs_gsize 1870000000 \
  --narrow_peak \
  --macs_pvalue 0.0000001 \
  --outdir <PATH_TO_OUTPUT_DIRECTORY> \
  -work-dir <PATH_TO_WORK_DIRECTORY>
