#!/bin/sh

FILE=$1
MAX_SIZE=$2

touch ${FILE}
count=0

# preserve leading and trailing spaces
IFS=

while read -r line
do
	echo $line >> ${FILE}
	count=$((count+${#line}+1))
	
	if test $count -gt $MAX_SIZE
        then
            #echo "backup!"
            mv -f ${FILE} ${FILE}.$(date +"%F_%T")
            touch ${FILE}
            count=0
        fi
done
