#!/bin/bash 
#https://sprosi.pro/questions/2617/kak-ya-mogu-poluchit-razmer-fayla-v-stsenarii-bash
function getfilesize(){
local file=""
if [[ "$1" ]]; then 
file="$1"
else
echo "File unknown in function getfilesize"
exit 1
fi
(
  du --apparent-size --block-size=1 "$file" 2>/dev/null ||
  gdu --apparent-size --block-size=1 "$file" 2>/dev/null ||
  find "$file" -printf "%s" 2>/dev/null ||
  gfind "$file" -printf "%s" 2>/dev/null ||
  stat --printf="%s" "$file" 2>/dev/null ||
  stat -f%z "$file" 2>/dev/null ||
  wc -c <"$file" 2>/dev/null
) | awk '{print $1}'
}

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
#send main process signal ready to write pipe
echo "EOP">$pipe1
echo "pipe1 created"
fi 

while true
do
 if read line <$pipe1; then
 echo "EOP">$pipe1
    m_date=$(date +%T)
    echo -e "$m_date#from pipe1: \n$line"
    if [[ "$line" == 'quit' ]]; then 
         break
    fi 
    if [[ "$line" != 'EOP' ]]; then 
         echo -e "$m_date#from pipe1: \n$line"
    fi    
    echo -e "$m_date#from pipe1: \n$line"
 fi 
done
exit 0
