#!/bin/bash
REGEX_SESSION='\>.*days,\s\K(.*)(?=\s*\|)'  
REGEX_TOTAL='\sup\s*\K(.*)(?=\s*\|)' 
 
SESSION=$(uprecords | grep -Po $REGEX_SESSION)
SESSION=${SESSION::-5}
#echo "$SESSION"

TOTAL=$(uprecords | grep -Po $REGEX_TOTAL)
TOTAL=${TOTAL::-1}
#echo "$TOTAL"

DIA=$(echo $TOTAL | cut -d' ' -f 1)
#echo "$DIA"

HORA=$(echo $TOTAL | cut -d' ' -f 3 | cut -d':' -f 1 | sed 's/^0*//')
#echo "$HORA"

USE_TIME=0
let "USE_TIME=$DIA * 24 + $HORA"

echo "$SESSION" 
echo "$USE_TIME HORAS"
#echo "${TOTAL/'days'/'días'}"

