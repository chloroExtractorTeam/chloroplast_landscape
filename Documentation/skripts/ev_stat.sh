#!bin/bash

echo -e 'SRR\tCE\tFP\tGO\tIOGA\tNP\tOA'
num='^[0-9]+$'
SRR='.RR.+'
declare -a tools=('chloroExtractor' 'fast-plast' 'GetOrganelle' 'IOGA' 'NOVOPlasty' 'orgAsm') 
for dir in * ; do
    if [[ -d $dir ]] && [[ $dir =~ $SRR ]]; then
	
	for i in ${tools[@]}
	do
	    if [[ $i = 'fast-plast' ]];then
		Toolev=fastplastEV
	    else
	    
		Toolev=${i}EV
	    fi
	    
	    if [[ -d $dir/$i ]];then
		if [ -f $dir/$i/Statistic* ]; then
		    
		    reads=`awk 'NR==2{ print $3 }' $dir/$i/Statistic*`
		    bp=`awk 'NR==2{ print $4 }' $dir/$i/Statistic*`

		   
		    
		    if [[ $reads =~ $num ]] && [[ $bp =~ $num ]]; then	 
			if [[ $reads -eq 1 ]] && [[ $bp -ge 110000 ]] && [[ $bp -le 180000 ]]; then
			    
			    eval ${Toolev}="SUCCESS"
			elif [[ $reads -ge 1 ]] && [[ $bp -ge 100000 ]];then
			    
			    eval ${Toolev}="PARTIAL"
			elif [[ $reads -ge 1 ]] && [[ $bp -ge 180000 ]]; then 
			    
			    eval ${Toolev}="INCOMPLETE_high"
			elif [[ $reads -ge 1 ]] && [[ $bp -le 100000 ]]; then
			    eval ${Toolev}="INCOMPLETE_low"
			    
			fi
   		    else
		        eval ${Toolev}="ERROR"
		    fi
		    
		else

		    if [[ $i = 'chloroExtractor' ]];then
			t='CE'
		    elif [[ $i = 'fast-plast' ]];then
			t='FP'
		    elif [[ $i = 'GetOrganelle' ]]; then
			t='GO'
		    elif [[ $i = 'IOGA' ]]; then
			t='IOGA'
		    elif [[ $i = 'NOVOPlasty' ]]; then
			t='NP'
		    elif [[ $i = 'orgAsm' ]]; then
			t='OA'
		    fi
		    

		    
		    if squeue -u s229502 -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R %k" | grep -oP "$t_$dir" > /dev/null
		    then
		        eval ${Toolev}="Running"
		    else
			if [ -f $dir/ERROR_NOPAIR.log ];
			then
			    eval ${Toolev}="NO_PAIR"
			else
			    
			    eval ${Toolev}="ERROR_file"
			fi
			
		    fi
		fi
	    else
		eval ${Toolev}="-"
	    fi	    
	done

	
	
	echo -e "$dir:\t$chloroExtractorEV\t$fastplastEV\t$GetOrganelleEV\t$IOGAEV\t$NOVOPlastyEV\t$orgAsmEV"
	
    fi
done 
