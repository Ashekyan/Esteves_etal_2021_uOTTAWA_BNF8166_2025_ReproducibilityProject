#!/bin/bash
#SBATCH --job-name=ChIPseq_run
#SBATCH --account=<CCDB_ACCOUNT>
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=32:00:00
#SBATCH --output=ChIPseq_%j.out
#SBATCH --error=ChIPseq_%j.err
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

#### Prevent Nextflow from falling back to an undesired low CPU ceiling
unset NXF_TASK_MAXCPUS
export NXF_TASK_MAXCPUS=8

#### Move to the project working directory
cd <PROJECT_DIRECTORY>

#### Run nf-core/chipseq
nextflow run nf-core/chipseq \
  -profile singularity \
  --max_cpus 8 \
  --max_memory '32.GB' \
  --max_time '32.h' \
  --input <PATH_TO_SAMPLESHEET_CSV> \
  --fasta <PATH_TO_REFERENCE_FASTA> \
  --gtf <PATH_TO_ANNOTATION_GTF> \
  --bwa_index <PATH_TO_BWA_INDEX_DIRECTORY> \
  --macs_gsize 1870000000 \
  --macs_fdr 0.05 \
  --narrow_peak \
  --skip_diff_analysis \
  --outdir <PATH_TO_OUTPUT_DIRECTORY> \
  -work-dir <PATH_TO_WORK_DIRECTORY> \
  -resume
