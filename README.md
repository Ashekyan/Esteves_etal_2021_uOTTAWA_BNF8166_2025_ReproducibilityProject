# Esteves_etal_2021_uOTTAWA_BNF8166_2025_ReproducibilityProject

# SLURM workflows for ATAC-seq and ChIP-seq analysis

This repository contains example SLURM submission scripts used for running nf-core/atacseq and nf-core/chipseq on the Nibi cluster (Compute Canada / Digital Research Alliance of Canada) using Nextflow and Apptainer.

## Contents

- `workflows/run_atacseq.slurm`: example SLURM script for nf-core/atacseq
- `workflows/run_chipseq.slurm`: example SLURM script for nf-core/chipseq

## Notes

- All paths, account names, and file names have been replaced with placeholders for portability and reproducibility.
- Users should replace the placeholders with values appropriate for their environment.
- These scripts are intended as publication-associated workflow examples.

## Software environment

- SLURM
- Nextflow
- Apptainer
- nf-core/atacseq
- nf-core/chipseq
- StdEnv/2023 module environment on Nibi

## Compute environment

The workflows were run on the Nibi cluster (Compute Canada / Digital Research Alliance of Canada).
