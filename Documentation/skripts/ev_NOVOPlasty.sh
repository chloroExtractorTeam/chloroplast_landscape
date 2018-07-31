#!bin/bash

while [ 1 ]; do

    if  squeue -u s229502 -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R %k" | grep -oP "NP_${1}" > /dev/null 
    then
        sleep 60
    else

        echo "End running time:\t$(date -Iseconds)" >> benchmark_NP.log
        echo "Start evaluating" >> benchmark_NP.log
        
        mkdir raw-data-NP-${1}
        mv *_* raw-data-NP-${1}
        mv cds* raw-data-NP-${1}
       
        mv slurm* raw-data-NP-${1}
	mv raw-data-NP-${1}/log_NOVOPlasty_${1}_out.txt NP_${1}.log

        mv raw-data-NP-${1}/benchmark_NP.log .

        if [ -f "raw-data-NP-${1}/Option_1_NOVOPlasty_${1}_out.fasta" ];
        then
            
            cp raw-data-NP-${1}/Option*NOVOPlasty_${1}_out.fasta . && mv Option_1_NOVOPlasty_${1}_out.fasta  NP_${1}_out.fa

	    sed -i 's/\*/N/g' NP_${1}_out.fa
	    
            SeqFilter NP_${1}_out.fa >> Statistic_out.log &
            sleep 10
	    

	elif [ -f "raw-data-NP-${1}/Contigs_1_NOVOPlasty_${1}_out.fasta" ] 
	then
	    cp raw-data-NP-${1}/Contigs*NOVOPlasty_${1}_out.fasta . && mv Contigs_1_NOVOPlasty_${1}_out.fasta  NP_${1}_out.fa

	    sed -ir 's/\*/N/g' NP_${1}_out.fa
	    
            SeqFilter NP_${1}_out.fa >> Statistic_out.log &
            sleep 10
	    
	    
	else
	    echo "No Fasta found" >> Statistic_out.log
	    sleep 1
        fi
        
        
        if tail -n30 NP_${1}.log | grep -oP "Assembly \d+ finished" > /dev/null;
        then
           
            mv NP_${1}.log NP_${1}_SUCCESS.log
            mv Statistic_out.log Statistic_out_SUCCESS.log
            
          
        else
            mv NP_${1}.log NP_${1}_ERROR.log
        fi
        
        
        echo "End evaluating time:\t$(date -Iseconds)" >> benchmark_NP.log

        exit
   

    fi
done
