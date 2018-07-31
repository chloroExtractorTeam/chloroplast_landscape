#!/bin/bash

cd chloroExtractor && sbatch --mem 20G --exclude=jupiter --comment="nocpbase run" -J CE_${1} run_chloroExtractor.sh ${1} && cd ..

#cd GetOrganelle && sbatch --mem 50G --comment="automated run" -J GO_${1}  run_GetOrganelle.sh ${1} cds-nr98-core.fa && cd ..

#cd IOGA && sbatch --exclude=saturn[1-2],jupiter --mem 50G --comment="automated run" -J IOGA_${1} run_IOGA.sh ${1} cds-nr98-core.fa && cd ..

#cd orgAsm && sbatch --exclude=saturn[1-2],jupiter --mem 30G --comment="automated run" -J OA_${1} run_orgAsm.sh ${1} && cd ..

#cd NOVOPlasty && sbatch --exclude=saturn[1-2],jupiter --mem 30G --comment="automated run" -J NP_${1} run_NOVOPlasty.sh config_NP_${1}.txt && cd ..

#cd fast-plast && sbatch --mem 60G --exclude=jupiter --comment="nocpbase run" -J FP_${1} run_fast-plast.sh ${1} && cd .. 
