#!bin/bash

declare -a tools=('chloroExtractor' 'fast-plast' 'GetOrganelle' 'IOGA' 'NOVOPlasty' 'orgAsm')

for dir in $(ls .);
do
    if [ -d "$dir" ];
    then
	cd $dir
	echo "enter $dir"

	for tool in "${tools[@]}"
	do
	    if [ -d "$tool" ];
	    then
		
		cd $tool
		echo "enter $tool"
		echo "removing raw data"
		rm -rf raw-data-*
		echo "done $dir/$tool"
		cd ..
	    else
		echo "no dir - $tool"
	    fi

	done
	cd ..
    fi
    
done
