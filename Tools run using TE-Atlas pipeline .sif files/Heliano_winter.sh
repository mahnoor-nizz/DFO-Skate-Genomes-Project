#!/bin/bash
#SBATCH --job-name=heliano_winterskate
#SBATCH --account=def-cottenie
#SBATCH --time=7-00:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --output=/scratch/mahnoorn/TE-Atlas/logs/heliano_winterskate_%j.out
#SBATCH --error=/scratch/mahnoorn/TE-Atlas/logs/heliano_winterskate_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mnizaman@uoguelph.ca

module load StdEnv/2020
module load apptainer

TE_ATLAS_DIR=/home/mahnoorn/projects/def-cottenie/mahnoorn/TE-Atlas
GENOME=$SCRATCH/earlgrey_winterskate/genome/GCA_036785375.1_sLeuOce1_p1.0_genomic.fna
OUTDIR=$SCRATCH/heliano_winterskate

mkdir -p $OUTDIR

apptainer run \
    "$TE_ATLAS_DIR/TE_pipeline_sif_files/heliano.sif" \
    heliano \
    -g "$GENOME" \
    -w 10000 \
    -dm 2500 \
    -pt 1 \
    -is1 1 \
    -is2 1 \
    -sim_tir 100 \
    -p 0.001 \
    -s 32 \
    --process 16 \
    -o "$OUTDIR"

    #I would perhaps try using -p 0.00001 next time as that is more stringent and was used in benchmarking studies. Also try reducing -w to 6000 as that reduced mis-annotation in benchmarking studies. 
