#!/bin/bash 
declare -A cfgs
CONF="./cfg.ini"
apikey=""
if [ -f "$CONF" ]; then
CFG=$(grep = "$CONF" | sed 's/ *= */=/g' | sed 's/ /_/g')
echo -e "Readed config file: \n$CFG"
echo "$CFG" | while read line; 
do
key=$(echo $line | awk -F '=' '{print $1}')
val=$(echo $line | awk -F '=' '{print $2}')
cfgs[$key]="$val"
echo "key=$key, val=$val"
apikey=${cfgs[apikey]}
echo "Reading config file: apikey=$apikey"
done
else
echo -n "API key for focusdata.ru? " 
read apikey
echo "apikey=$apikey">./cfg.ini
fi

pipe1="/tmp/pipe1"
rm -f "$pipe1"
#https://rtfm.co.ua/bash-ispolzovanie-komandy-trap-dlya-perexvata-signalov-preryvaniya-processa/
trap "rm -f $pipe1" EXIT
if [[ ! -p $pipe1 ]]; then 
mkfifo "$pipe1"
echo "pipe1 created"
fi 

while true
do
 if read line <$pipe1; then
 echo "no data">$pipe1
    date=$(date +%T)
    echo -e "$date#from pipe1: \n$line"
    if [[ "$line" == 'quit' ]]; then 
         break
    fi 
    if [[ "$line" != 'no data' ]]; then 
         echo -e "$date#from pipe1: \n$line"
    fi    
    echo -e "$date#from pipe1: \n$line"
 fi 
done
exit 0
