#!/bin/bash

echo "Start time: $(date -Iseconds)" >> benchmark_NP.log

time ~/singularity/bin/singularity exec --bind /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/go_preprint_5M/:/data -w docker://chloroextractorteam/novoplasty_docker perl /NOVOPlasty/NOVOPlasty2.6.5.pl -c ${1}
