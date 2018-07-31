#!/bin/bash

echo "Start time: $(date -Iseconds)" >> benchmark_OA.log


time ~/singularity/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/go_preprint_5M/:/data -w docker://chloroextractorteam/org.asm_docker oa index ${1}_oa ${1}_1.fastq ${1}_2.fastq
time ~/singularity/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/go_preprint_5M/:/data -w docker://chloroextractorteam/org.asm_docker oa buildgraph --probes protChloroArabidopsis ${1}_oa ${1}_oa.chl
time ~/singularity/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/go_preprint_5M/:/data -w docker://chloroextractorteam/org.asm_docker oa unfold ${1}_oa ${1}_oa.chl | grep -iv docker | grep -v container >${1}_oa.chl.fa

