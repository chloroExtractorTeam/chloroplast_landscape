#!/bin/bash

echo "Start time: $(date -Iseconds)" >> benchmark_CE.log

time ~/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data:/data -w docker://chloroextractorteam/chloroextractor bash -c "export LC_ALL="C.UTF-8" && ptx --threads 20 -1 ${1}_1.fastq -2 ${1}_2.fastq -d CE_${1}_out"
