#!/bin/bash
#SBATCH --job-name=mitefinder_winterskate
#SBATCH --account=def-cottenie
#SBATCH --time=7-00:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --output=/scratch/mahnoorn/TE-Atlas/logs/mitefinder_winterskate_%j.out
#SBATCH --error=/scratch/mahnoorn/TE-Atlas/logs/mitefinder_winterskate_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mnizaman@uoguelph.ca

GENOME=$SCRATCH/earlgrey_winterskate/genome/GCA_036785375.1_sLeuOce1_p1.0_genomic.fna
OUTDIR=$SCRATCH/mitefinder_winterskate
MITEFINDER=$SCRATCH/miteFinder/bin/miteFinder
mkdir -p $OUTDIR

$MITEFINDER -input "$GENOME" -output "$OUTDIR/mitefinder_winterskate" -pattern_scoring $SCRATCH/miteFinder/profile/pattern_scoring.txt -threshold 0.5
#Install mitefinder first from https://github.com/jhu99/miteFinder.git
