#!bin/bash

while [ 1 ]; do

    if  squeue -u s229502 -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R %k" | grep -oP "FP_${1}" > /dev/null 
    then
	sleep 60
    else

	echo "End running time: $(date -Iseconds)" >> benchmark_FP.log
	echo "Start evaluating" >> benchmark_FP.log
	
	mkdir raw-data-FP-${1}
	mv *_* raw-data-FP-${1}
       
	mv slurm* raw-data-FP-${1}/.

	mv raw-data-FP-${1}/*Fast-Plast_Progress.log .
	
	mv raw-data-FP-${1}/benchmark_FP.log .

	FILE="raw-data-FP-${1}/FP_${1}_out/Final_Assembly/*_FULLCP.fsa"
	FILE2="raw-data-FP-${1}/FP_${1}_out/Final_Assembly/*afin_iter*.fa"
	FILE3="raw-data-FP-${1}/FP_${1}_out/Final_Assembly/*final.scaffolds.fasta"
	if [ -f $FILE ]
	then
	    
	    cp raw-data-FP-${1}/FP_${1}_out/Final_Assembly/*_FULLCP.fsa . && mv *_FULLCP.fsa FP_${1}_out.fa
	    
	    SeqFilter FP_${1}_out.fa  >> Statistic_out.log &
	    sleep 10

	elif [ -f $FILE2 ]
	then
	    
	    cp raw-data-FP-${1}/FP_${1}_out/Final_Assembly/*afin_iter*.fa . && mv *_afin_iter*.fa FP_${1}_out.fa

	    SeqFilter FP_${1}_out.fa  >> Statistic_out.log &
	    sleep 10
	elif [ -f $FILE3 ]
	then
	     cp raw-data-FP-${1}/FP_${1}_out/Final_Assembly/*final.scaffolds.fasta . && mv *final.scaffolds.fasta FP_${1}_out.fa
	    
	    SeqFilter FP_${1}_out.fa  >> Statistic_out.log &
	    sleep 10

	    
	else
	    echo "No fasta found" >> Statistic_out.log
	    sleep 1
	   
	fi
	
	
	if tail -n15 *Fast-Plast_Progress.log | grep -o "known angiosperm chloroplast genes" > /dev/null;
	then
	    if tail -n15 *Fast-Plast_Progress.log | grep -o "FULLCP.fsa" > /dev/null;
	    then
		mv Statistic_out.log Statistic_out_SUCCESS.log
		mv FP_${1}_out_Fast-Plast_Progress.log FP_${1}_out_Fast-Plast_Progress_SUCCESS.log
	    else
		mv Statistic_out.log Statistic_out_INCOMPLETE.log
		mv FP_${1}_out_Fast-Plast_Progress.log FP_${1}_out_Fast-Plast_Progress_INCOMPLETE.log
	    fi
	else
	    	mv Statistic_out.log Statistic_out_ERROR.log
		mv FP_${1}_out_Fast-Plast_Progress.log FP_${1}_out_Fast-Plast_Progress_ERROR.log
	fi
	
	
	echo "End evaluating time: $(date -Iseconds)" >> benchmark_FP.log

	exit
   

    fi
done
