#!bin/bash

FILE=${1}


declare -a tools=('CE' 'FP' 'GO' 'IOGA' 'NP' 'OA' 'Total')
echo -e "Tool\tSUCCESS %\tERROR\tPARTIAL\tINCOMPl\tNO_PAIR\tRunning\tTotal"
for i in ${tools[@]}
do

    if [[ $i = 'CE' ]];then
	POS='$2'
    elif [[ $i = 'FP' ]];then
	POS='$3'
    elif [[ $i = 'GO' ]];then
	POS='$4'
    elif [[ $i = 'IOGA' ]];then
	POS='$5'
    elif [[ $i = 'NP' ]];then
	POS='$6'
    elif [[ $i = 'OA' ]];then
	POS='$7'
    elif [[ $i = 'Total' ]];then
	POS=""
    fi

    
SUCC=`awk -F' ' '{print '$POS'}' $FILE |grep 'SUCCESS'|wc -l`
ERR=`awk -F' ' '{print '$POS'}' $FILE |grep 'ERROR'|wc -l`
PAR=`awk -F' ' '{print '$POS'}' $FILE |grep 'PARTIAL'|wc -l`
NOPA=`awk -F' ' '{print '$POS'}' $FILE |grep 'NO_PAIR'|wc -l`
INC=`awk -F' ' '{print '$POS'}' $FILE |grep 'INC'|wc -l`
RUN=`awk -F' ' '{print '$POS'}' $FILE |grep 'Running'|wc -l`

TO=`cat $FILE |wc -l`
TOTAL=`expr ${TO} - 1`
TONO=`expr ${TOTAL} - ${NOPA}`
PERSUCC=$(awk "BEGIN { pc=100*${SUCC}/${TONO}; i=int(pc); print (pc-i<0.5)?i:i+1 }")

if [[ $i = 'Total' ]];then
    #TO=`cat $FILE |wc -l`
    #TOTAL=`expr ${TO} - 1`
    echo -e "Summary\t${SUCC} ~$PERSUCC%\t-\t-\t-\t${NOPA}\t-\t${TOTAL}"
else
    
echo -e "${i}\t${SUCC} ~$PERSUCC%\t${ERR}\t${PAR}\t${INC}\t${NOPA}\t${RUN}"

fi


done
