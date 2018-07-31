#!/bin/bash

minimap2 -ax asm5 /home/s229502/Master_thesis/TAIR10_chrC.fa ${1} > ${1}.sam
samtools view -Sb ${1}.sam > ${1}.bam
samtools sort ${1}.bam ${1}_sorted
samtools index ${1}_sorted.bam ${1}_sorted.bam.bai  

#rm ${1}.sam
#mv sorted.bam ${1}_sorted.bam
