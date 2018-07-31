#!/bin/bash

echo "Rerun start time: $(date -Iseconds)" >> benchmark_CE.log

#cp ~/Master_thesis/chloroExtractor/ptx.cfg .

if [[ -f ptx_rerun.cfg ]];
then
    sed -i s/'target_coverage => 200,'/'target_coverage => '${2}','/ ptx_rerun.cfg
else
    sed  s/'target_coverage => 200,'/'target_coverage => '${2}','/ ~/Master_thesis/chloroExtractor/ptx.cfg > ptx_rerun.cfg
fi

time ~/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/:/data -w docker://chloroextractorteam/chloroextractor bash -c "export LC_ALL="C.UTF-8" && ptx --threads 20 -1 ${1}_1.fastq -2 ${1}_2.fastq -d CE_${1}_out --redo -c ptx_rerun.cfg"
