 #!bin/bash

while [ 1 ]; do

    if  squeue -u s229502 -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R %k" | grep -oP "IOGA_${1}" > /dev/null 
    then
        sleep 60
    else

        echo "End running time:\t$(date -Iseconds)" >> benchmark_IOGA.log
        echo "Start evaluating" >> benchmark_IOGA.log
        
        mkdir raw-data-IOGA-${1}
        mv *_* raw-data-IOGA-${1}
        mv cds* raw-data-IOGA-${1}
       
        mv slurm* IOGA_${1}.log

        mv raw-data-IOGA-${1}/benchmark_IOGA.log .

	FASTA=`tail -n15 IOGA_${1}.log |grep 'highest ALE score' |grep -oP 'IOGA_\w+\d+_out.*'| cut -f1 -d' '`.fasta
	
	
        if [ -f raw-data-IOGA-${1}/IOGA_${1}_out.final/$FASTA ];
        then
            
            cp raw-data-IOGA-${1}/IOGA_${1}_out.final/$FASTA . && mv $FASTA  IOGA_${1}_out.fa
            
            SeqFilter IOGA_${1}_out.fa >> Statistic_out.log &
	else
	    echo "No fasta found" >> Statistic_out.log
            
        fi
        
        
        if tail -n15 IOGA_${1}.log | grep -o "final assembly statistics" > /dev/null;
        then
           
            mv IOGA_${1}.log IOGA_${1}_SUCCESS.log
            mv Statistic_out.log Statistic_out_SUCCESS.log
            
          
        else
            mv IOGA_${1}.log IOGA_${1}_ERROR.log
        fi
        
        
        echo "End evaluating time:\t$(date -Iseconds)" >> benchmark_IOGA.log

        exit
   

    fi
done
