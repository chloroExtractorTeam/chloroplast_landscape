#!/bin/bash

##### Old Version of bcftools needed
if [ -f ~/bin/bcftools ]
then
    mv ~/bin/bcftools ~/bin/bcftools_new/bcftools
    source ~/.bashrc
else 
    source ~/.bashrc
fi
#####

samtools mpileup -uf ~/Master_thesis/TAIR10_chrC.fa ${1} | bcftools view -bvcg - > ${1}.raw.bcf  
bcftools view ${1}.raw.bcf | /usr/share/samtools/vcfutils.pl varFilter -D50 > ${1}.flt.vcf  
