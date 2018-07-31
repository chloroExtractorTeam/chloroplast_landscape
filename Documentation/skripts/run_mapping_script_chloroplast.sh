#!/bin/bash/

bowtie2 -x /home/s229502/Master_thesis/mapping_chloro/chloro_index/chloro_tair10_index -1 ${1}_1.fq -2 ${1}_2.fq -S ${1}.sam || bowtie2 -x /home/s229502/Master_thesis/mapping_chloro/chloro_index/chloro_tair10_index -1 ${1}_1.fastq -2 ${1}_2.fastq -S ${1}.sam
samtools view -Sb ${1}.sam > ${1}.bam
samtools sort ${1}.bam sorted
samtools index sorted.bam ${1}.bam.bai  

rm ${1}.sam
rm sorted.bam
