#!/bin/bash

####NEW Version of bcftools needed...

if [ -f ~/bin/bcftools ]
then
    source ~/.bashrc
else
    mv ~/bin/bcftools_new/bcftools ~/bin/bcftools
    source ~/.bashrc
fi
#####

base=$(basename ${1} .fa_sorted.bam.vcf.gz)


bcftools stats ${1} > ${base}.vchk 
plot-vcfstats ${base}.vchk -p plots_${base}/
