#!/bin/bash
#SBATCH --job-name=mitefinder_smoothskate
#SBATCH --account=def-cottenie
#SBATCH --time=7-00:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --output=/scratch/mahnoorn/TE-Atlas/logs/mitefinder_smoothskate_%j.out
#SBATCH --error=/scratch/mahnoorn/TE-Atlas/logs/mitefinder_smoothskate_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mnizaman@uoguelph.ca

GENOME=$SCRATCH/earlgrey_smoothskate/genome/GCA_038087875.1_sMalSen1_p1.0_genomic.fna
OUTDIR=$SCRATCH/mitefinder_smoothskate
MITEFINDER=$SCRATCH/miteFinder/bin/miteFinder
mkdir -p $OUTDIR

$MITEFINDER -input "$GENOME" -output "$OUTDIR/mitefinder_smoothskate" -pattern_scoring $SCRATCH/miteFinder/profile/pattern_scoring.txt -threshold 0.5

#Install mitefinder first from https://github.com/jhu99/miteFinder.git
