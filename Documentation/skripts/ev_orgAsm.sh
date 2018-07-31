#!bin/bash

while [ 1 ]; do

    if  squeue -u s229502 -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R %k" | grep -oP "OA_${1}" > /dev/null 
    then
        sleep 60
    else

        echo "End running time:\t$(date -Iseconds)" >> benchmark_OA.log
        echo "Start evaluating" >> benchmark_OA.log
        
        mkdir raw-data-OA-${1}
        mv *_* raw-data-OA-${1}
        mv cds* raw-data-OA-${1}
       
        mv slurm* OA_${1}.log

        mv raw-data-OA-${1}/benchmark_OA.log .

        if [ -f "raw-data-OA-${1}/${1}_oa.chl.fa" ];
        then
            
            cp raw-data-OA-${1}/${1}_oa.chl.fa . && mv ${1}_oa.chl.fa  OA_${1}_out.fa
            
            SeqFilter OA_${1}_out.fa >> Statistic_out.log &
            sleep 10

        else
            echo "No Fasta found" >> Statistic_out.log
            sleep 1
        fi
        
        
        if tail -n15 OA_${1}.log | grep -o "Path is" > /dev/null;
        then
            if tail -n10 OA_${1}.log | grep -o "Path is linear" > /dev/null;
	    then
	       mv OA_${1}.log OA_${1}_INCOMPLETE.log
               mv Statistic_out.log Statistic_out_INCOMPLETE.log
	    elif tail OA_${1}.log | grep -o "Path is circular" > /dev/null;
	    then
		
		   
		 mv OA_${1}.log OA_${1}_SUCCESS.log
		 mv Statistic_out.log Statistic_out_SUCCESS.log
            fi
	    
	    
          
        else
   
            mv OA_${1}.log OA_${1}_ERROR.log
        fi
        
        
        echo "End evaluating time:\t$(date -Iseconds)" >> benchmark_OA.log

        exit
   

    fi
done
