#!bin/bash

Rerun="1"

while [ 1 ]; do

    if  squeue -u s229502 -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R %k" | grep -oP "CE_${1}" > /dev/null 
    then
	sleep 60
    else

	echo "End running time: $(date -Iseconds)" >> benchmark_CE.log
	echo "Start evaluating" >> benchmark_CE.log
	
	mkdir raw-data-CE-${1}
	mv *_* raw-data-CE-${1}
       
	mv slurm* CE_${1}.log

	mv raw-data-CE-${1}/benchmark_CE.log .

	if [ -f "raw-data-CE-${1}/CE_${1}_out/fcg.fa" ];
	then
	    
	    cp raw-data-CE-${1}/CE_${1}_out/fcg.fa . && mv fcg.fa CE_${1}_out.fa
	    
	    SeqFilter CE_${1}_out.fa >> Statistic_out.log
	else
	    echo "No Fasta Found" >> Statistic_out.log
   
	    
	fi
	
	
	if tail -n15 CE_${1}.log | grep -o "ptx pipeline completed" > /dev/null;
	then
	    if tail -n25 CE_${1}.log | grep -o "Found 3 different nodes" > /dev/null;
	    then
		mv CE_${1}.log CE_${1}_SUCCESS.log
		mv Statistic_out.log Statistic_out_SUCCESS.log
	    else
		mv CE_${1}.log CE_${1}_INCOMPLETE.log
		mv Statistic_out.log Statistic_out_INCOMPLETE.log
	    fi
	else
	    mv CE_${1}.log CE_${1}_ERROR.log

	    cov=`grep 'Insufficient plastid coverage' CE_${1}_ERROR.log | grep -oP "\d+X\." | grep -oP "\d+"`
	    tr=`grep 'Failed to align minimum amount of reads' CE_${1}_ERROR.log | grep -oP "\(\d+\)" | grep -oP "\d+"` 
	    
	    if [[ $Rerun -eq 1 ]] && [[ $cov -ge 20 ]] && [[ ! -f "raw-data-CE-${1}/rerun_chloroExtractor.sh" ]];
	    then
		echo "Rerun active - coverage too low, set plastid coverage to "${cov} >> benchmark_CE.log
		
		mv raw-data-CE-${1} raw-data-CE-${1}-old
		mv raw-data-CE-${1}-old/*.fastq .
		mv raw-data-CE-${1}-old/ev_chloroExtractor.sh .

		if [[ -f raw-data-CE-${1}-old/ptx_rerun.cfg ]];
		then
		    mv raw-data-CE-${1}-old/ptx_rerun.cfg .
		fi
		
						
		ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/rerun_chloroExtractor.sh
		
		mv CE_${1}_ERROR.log raw-data-CE-${1}-old/.
		mv Statistic_out.log raw-data-CE-${1}-old/.

		sbatch --mem 30G --comment="automated run" -J CE_${1}_cov${cov} rerun_chloroExtractor.sh ${1} $cov &>/dev/null
		bash ev_chloroExtractor.sh ${1} &>/dev/null
		
		exit
	    fi

	    if [[ $Rerun -eq 1 ]] && [[ $tr -ge 3000 ]];
	    then
		let tr_new=$tr-500
		echo "Rerun active - target reads too low, set max_reads to "${tr_new} >> benchmark_CE.log

		mv raw-data-CE-${1} raw-data-CE-${1}-tr-${tr}
		mv raw-data-CE-${1}-tr-${tr}/*.fastq .
		mv raw-data-CE-${1}-tr-${tr}/ev_chloroExtractor.sh .

		ln -s /storage/full-share/chloroplast_landscape/chloroplast_landscape/skripts/rerun_chloroExtractor_tr.sh

		mv CE_${1}_ERROR.log raw-data-CE-${1}-tr-${tr}/.
		mv Statistic_out.log raw-data-CE-${1}-tr-${tr}/.

		sbatch --mem 30G --comment="automated run" -J CE_${1}_tr${tr_new} rerun_chloroExtractor_tr.sh ${1} $tr_new &>/dev/null
		bash ev_chloroExtractor.sh ${1} &>/dev/null

		exit
	    fi
	    
		
	fi
	
	
	echo "End evaluating time: $(date -Iseconds)" >> benchmark_CE.log
	rm -rf raw-data*-tr-*
	exit
   

    fi
done
