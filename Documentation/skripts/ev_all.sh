#!bin/bash

#declare -a tools=('chloroExtractor' 'fast-plast' 'GetOrganelle' 'IOGA' 'NOVOPlasty' 'orgAsm')
declare -a tools=('chloroExtractor')
for i in "${tools[@]}"
do
    

    cd ${i} && bash ev_${i}.sh ${1} &>/dev/null && cd .. &

done


###
#cd fast-plast && bash ev_fast-plast.sh ${1} &>/dev/null && cd ..
#
#cd GetOrganelle && bash ev_GetOrganelle.sh ${1} &>/dev/null && cd ..
#
#cd IOGA && bash ev_IOGA.sh ${1} &>/dev/null && cd ..
#
#cd NOVOPlasty && bash ev_NOVOPlasty.sh ${1} &>/dev/null && cd ..
#
#cd orgAsm && bash ev_orgAsm.sh ${1} &>/dev/null && cd ..
##
