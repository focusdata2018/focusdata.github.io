#!/bin/bash
function get_http(){
DEST=""
if [[ "$1" ]]; then 
DEST="$1"
fi

PORT="80"
if [[ "$2" ]]; then 
PORT="$2"
fi

echo "DEBUG: I will get info from $DEST:$PORT"

local out=$(echo -n "GET / HTTP/1.1\r\nhost: http://$DEST\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0\r\nConnection:     close\r\n\r\n" | nc "$DEST" "$PORT")
local iserror=$(echo "$out" | grep "Bad Request")

if ! [[ "$iserror" ]]; then
  echo "$out"
else
  echo "BAD REQUEST to $DEST"
fi
}

pipe1=/tmp/pipe1

if [[ ! -p $pipe1 ]]; then 
echo "Reader not running"
exit 1 
fi 
 

date=$(date +%T)
line="Hello from $$"
echo -e "\n$date#to pipe1: \n$line"
echo "$line" >$pipe1

line=$(get_http "balsat-msk.ru")
echo -e "$date#to pipe1: \n$line"

echo -e "$date#to pipe1: \nquit"
echo "quit" >$pipe1
exit 0
