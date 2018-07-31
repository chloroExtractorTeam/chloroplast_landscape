#!/bin/bash

####Old Version of bcftools needed

if [ -f ~/bin/bcftools ]
then
    mv ~/bin/bcftools ~/bin/bcftools_new/bcftools
    source ~/.bashrc
else 
    source ~/.bashrc
fi
#####

samtools mpileup -uD -f ${2} ${1} | bcftools view -vcg - > ${1}.vcf
