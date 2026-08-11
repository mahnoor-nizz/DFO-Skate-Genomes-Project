#!/bin/bash
#SBATCH --job-name=annosine_smoothskate
#SBATCH --account=def-cottenie
#SBATCH --time=7-00:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --output=TE-Atlas/logs/annosine_smoothskate_%j.out
#SBATCH --error=TE-Atlas/logs/annosine_smoothskate_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mnizaman@uoguelph.ca

module load StdEnv/2020
module load apptainer

TE_ATLAS_DIR=/home/mahnoorn/projects/def-cottenie/mahnoorn/TE-Atlas
GENOME=$SCRATCH/earlgrey_smoothskate/genome/GCA_038087875.1_sMalSen1_p1.0_genomic.fna
OUTDIR=$SCRATCH/annosine_smoothskate
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTDIR

apptainer run \
    "$TE_ATLAS_DIR/TE_pipeline_sif_files/annosine_v2.sif" \
    AnnoSINE_v2 -t $THREADS 3 "$GENOME" "$OUTDIR"
