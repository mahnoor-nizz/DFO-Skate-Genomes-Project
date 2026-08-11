#!/bin/bash
#SBATCH --job-name=earlgrey_winterskate
#SBATCH --account=def-cottenie
#SBATCH --time=7-00:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --output=earlgrey_winterskate/logs/%x_%j.out
#SBATCH --error=earlgrey_winterskate/logs/%x_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mnizaman@uoguelph.ca

# I downloaded and configured for Dfam partition 12 (vertabrata) before this so -r chondrichthyes could be used

# Environment
source /home/mahnoorn/miniforge3/etc/profile.d/conda.sh
conda activate earlgrey2

# Paths
GENOME=$SCRATCH/earlgrey_winterskate/genome/GCA_036785375.1_sLeuOce1_p1.0_genomic.fna
OUTDIR=$SCRATCH/earlgrey_winterskate/outputs

# Run EarlGrey
earlGrey -g "$GENOME" -s winterskate -o "$OUTDIR" -t 16 -r chondrichthyes -q yes
