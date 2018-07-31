#!/bin/bash

echo "Start time: $(date -Iseconds)" >> benchmark_FP.log

time ~/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/nocpbase:/data -w docker://chloroextractorteam/fast-plast_docker bash -c "export LC_ALL="C.UTF-8" && perl /fast-plast/fast-plast.pl -1 ${1}_1.fastq -2 ${1}_2.fastq --name FP_${1}_out --coverage_analysis --threads 40"

