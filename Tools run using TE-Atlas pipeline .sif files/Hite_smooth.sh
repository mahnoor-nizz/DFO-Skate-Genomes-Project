#!/bin/bash
#SBATCH --job-name=hite_smoothskate
#SBATCH --account=def-cottenie
#SBATCH --time=7-00:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --output=/scratch/mahnoorn/TE-Atlas/logs/hite_smoothskate_%j.out
#SBATCH --error=/scratch/mahnoorn/TE-Atlas/logs/hite_smoothskate_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mnizaman@uoguelph.ca

module load StdEnv/2020
module load apptainer

TE_ATLAS_DIR=/home/mahnoorn/projects/def-cottenie/mahnoorn/TE-Atlas
GENOME=$SCRATCH/earlgrey_smoothskate/genome/GCA_038087875.1_sMalSen1_p1.0_genomic.fna
OUTDIR=$SCRATCH/hite_smoothskate

mkdir -p $OUTDIR

apptainer run -B "$TE_ATLAS_DIR:$TE_ATLAS_DIR" -B "$SCRATCH:$SCRATCH" --pwd /HiTE \
    "$TE_ATLAS_DIR/TE_pipeline_sif_files/HiTE_V3.3.3.sif" \
    python main.py \
        --genome "$GENOME" \
        --thread 16 \
        --chunk_size 200 \
        --plant 0 \
        --out_dir "$OUTDIR" \
        --work_dir "$OUTDIR"
