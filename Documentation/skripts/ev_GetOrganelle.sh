 #!bin/bash

while [ 1 ]; do

    if  squeue -u s229502 -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R %k" | grep -oP "GO_${1}" > /dev/null 
    then
        sleep 60
    else

        echo "End running time:\t$(date -Iseconds)" >> benchmark_GO.log
        echo "Start evaluating" >> benchmark_GO.log
        
        mkdir raw-data-GO-${1}
        mv *_* raw-data-GO-${1}
	mv cds* raw-data-GO-${1}
       
        mv slurm* GO_${1}.log

        mv raw-data-GO-${1}/benchmark_GO.log .

        if [ -f "raw-data-GO-${1}/GO_${1}_out/filtered_spades/contigs.fasta" ];
        then
            
            cp raw-data-GO-${1}/GO_${1}_out/filtered_spades/contigs.fasta . && mv contigs.fasta  GO_${1}_out.fa

	    perl ~/Master_thesis/chloroExtractor/bin/find_cyclic_graph.pl -i raw-data-GO-${1}/GO_${1}_out/filtered_spades/assembly_graph.fastg -o GO_fcg_${1}_out.fa > /dev/null
	    perl ~/Master_thesis/chloroExtractor/bin/find_cyclic_graph.pl -i raw-data-GO-${1}/GO_${1}_out/filtered_spades/assembly_graph.fastg.*.fastg -o GO_fcg_${1}_out_extendet.fa > /dev/null
	    
	   # sleep 30

	    SeqFilter GO_fcg_${1}_out_extendet.fa >> Statistic_out.log 
	    SeqFilter GO_fcg_${1}_out.fa >> Statistic_out.log 
            SeqFilter GO_${1}_out.fa >> Statistic_out.log 
	    
        else
	    echo "No fasta found" >> Statistic_out.log
        fi
        
        
        if tail -n15 GO_${1}.log | grep -o "Processing assembly result finished!" > /dev/null;
        then
           
            mv GO_${1}.log GO_${1}_SUCCESS.log
            mv Statistic_out.log Statistic_out_SUCCESS.log
	    
          
        else
            mv GO_${1}.log GO_${1}_ERROR.log
        fi
        
        
        echo "End evaluating time:\t$(date -Iseconds)" >> benchmark_GO.log

        exit
   

    fi
done
