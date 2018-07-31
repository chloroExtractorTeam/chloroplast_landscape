#!bin/bash

ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/cp_skript.sh
ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/ev_stat.sh
ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/percent_stat.sh
#declare -a SRR=('SRR1503730') 

for i in $(ls /storage/full-share/chloroplast_landscape/chloroplast_landscape/data/nocpbase/*_1.fastq);
do

    base=$(basename $i _1.fastq)

#for base in "${SRR[@]}"
    #do

    FILE=${base}/${base}
    
    if [ -f "${FILE}_1.fastq" ]
    then
	echo "skipping $base, allready exists"
	continue
    fi
    
    
    
    bash cp_skript.sh $base

    #FILE=${base}/${base}
    
    if [ -f "${FILE}_1.fastq" ] && [ -f "${FILE}_2.fastq" ]
    then
	
	cd $base && bash sbatch_run_all.sh $base && bash ev_all.sh $base && cd ..
    else
	echo "NO PAIRED READS FOUND" >> ${base}/ERROR_NOPAIR.log
    fi
    
done

