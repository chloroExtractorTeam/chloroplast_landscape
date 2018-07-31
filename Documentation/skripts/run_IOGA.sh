#!/bin/bash

echo "Start time: $(date -Iseconds)" >> benchmark_IOGA.log

time ~/singularity/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/go_preprint_5M/:/data -w docker://chloroextractorteam/ioga_docker IOGA.py -1 ${1}_1.fastq -2 ${1}_2.fastq -r ${2} -n IOGA_${1}_out
											       
