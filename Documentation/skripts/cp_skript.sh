#!/bin/bash

#declare -a tools=('chloroExtractor' 'fast-plast' 'GetOrganelle' 'IOGA' 'NOVOPlasty' 'orgAsm')
declare -a tools=('chloroExtractor')
### Make dirs

mkdir ${1} && cd ${1}



for i in "${tools[@]}"
do
    mkdir $i && cd $i && ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/run_${i}.sh && ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/ev_${i}.sh
    #ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/full_sra/${1}_1.fastq
    #ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/full_sra/${1}_2.fastq

    ln -s /data/${1}_1.fastq
    ln -s /data/${1}_2.fastq
    
    if [ $i = 'NOVOPlasty' ] || [ $i = 'GetOrganelle' ] || [ $i = 'IOGA' ]
    then

	ln -s /home/s229502/Master_thesis/runs/ref/cds-nr98-core.fa
    

	if [ $i = 'NOVOPlasty' ]
	then
	    ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/make_NP_config.pl && perl make_NP_config.pl ${1} > config_NP_${1}.txt
	fi

    fi
    
      
       cd ..
 
done



### Copy Data

ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/${1}_1.fastq .

ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/${1}_2.fastq .


### Link run skript
#ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/ev_stat.sh
ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/ev_all.sh
ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/sbatch_run_all.sh

# bash sbatch_run_all.sh ${1}
