#!/bin/bash

echo "Start time: $(date -Iseconds)" >> benchmark_GO.log

time ~/singularity/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/go_preprint_5M:/data -w docker://chloroextractorteam/getorganelle_docker get_organelle_reads.py -1 ${1}_1.fastq -2 ${1}_2.fastq -s ${2} -w 90 -o GO_${1}_out -R 10 -k 77,85,91 -P 300000 --spades-options "--careful --phred-offset 33"
