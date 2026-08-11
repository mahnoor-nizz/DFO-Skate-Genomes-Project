#!/usr/bin/bash

#Running jupiter and circos plots on reference and query skate genomes

#First align genomes with minimap2 - Jupiter does this too but we can do this first and give it to Jupiter directly

minimap2 -ax asm10 -t 24 SmoothSkate.fna WinterSkate.fna > skatealignments.sam

#Next need to filter reference genome for only chromosomes (remove several thousand unplaced scaffolds)
seqkit grep -r -p "^CM" SmoothSkate.fasta > smooth_26chr_only.fasta
grep -c ">" smooth_26chr_only.fasta #there are 27 >s because we have 26 chromosomes and 1 mitochondrial chromosome

#Now run Jupiter and circos - just went with 30 scaffolds to be safe but there's only 27 in the final figure
jupiter name=skates_chr \
ref=smooth_26chr_only.fasta \
fa=WinterSkate.fna \
t=24 \
maxScaff=30
