#!/bin/bash

#Running de novo Trinity for both Smooth and Winter skate

#first smooth skate
singularity exec -e ../trinityrnaseq.v2.15.2.simg Trinity \
          --seqType fq \
          --left SRR26062589_1.fastq.gz \
          --right SRR26062589_2.fastq.gz \
          --max_memory 200G --CPU 40 \
          --full_cleanup \
          --output `pwd`/Smooth_trinity_out_dir
          
#assess transcriptome for completeness using bowtie. This will give an output on how many of our raw reads map back to the finished transcriptome. 
#these tests for 'completeness' are described in the Trinity wiki. Should also run BUSCO on them
bowtie2-build Smooth_trinity_out_dir.Trinity.fasta Smooth_trinity_out_dir.Trinity.fasta

bowtie2 -p 10 -q --no-unal -k 20 -x Smooth_trinity_out_dir.Trinity.fasta -1 SRR26062589_1.fastq.gz -2 SRR26062589_2.fastq.gz  \
     2>smoothskate_align_stats.txt| samtools view -@10 -Sb -o smoothskatebowtie2.bam 


#then winter skate
singularity exec -e ../trinityrnaseq.v2.15.2.simg  Trinity \
          --seqType fq \
          --left SRR26071863_1.fastq.gz \
          --right SRR26071863_2.fastq.gz \
          --max_memory 200G --CPU 40 \
          --full_cleanup \
          --output `pwd`/Winter_trinity_out_dir


#assess completeness 
bowtie2-build Winter.Trinity.fasta Winter.Trinity.fasta

bowtie2 -p 10 -q --no-unal -k 20 -x Winter.Trinity.fasta -1 SRR26071863_1.fastq.gz -2 SRR26071863_2.fastq.gz  \
     2>winterskate_align_stats.txt| samtools view -@10 -Sb -o winterskatebowtie2.bam 
