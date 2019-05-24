#!/bin/bash 
declare -A cfgs
CONF="./cfg.ini"
if [ -f "$CONF"]; then
CFG=$(grep = $CONF | sed 's/ *= */=/g' | sed 's/ /_/g')
echo "$CFG" | while read line; 
do
key=$(echo $line | awk -F '=' '{print $1}')
val=$(echo $line | awk -F '=' '{print $2}')
cfgs["$key"]="$val"
echo "Reading config file: apikey="
done
else
echo -n "API key for focusdata.ru? " 
read apikey
echo "apikey=$apikey">./cfg.ini
fi

pipe1=/tmp/pipe1
trap "rm -f $pipe1" EXIT
if [[ ! -p $pipe1 ]]; then 
mkfifo $pipe
fi 
exit 0
while true
do
 if read line <$pipe1; then
    if [[ "$line" == 'quit' ]]; then 
         break
    fi 
    echo $line
 fi 
done
