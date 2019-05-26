#!/bin/bash
clear
#https://pingvinus.ru/note/ps-kill-killall
killall -s 9 senddata.sh
killall -s 9 readweb.sh

echo "Download senddata.sh"
remote_file="https://raw.githubusercontent.com/focusdata2018/focusdata2018.github.io/master/agent/senddata.sh" 
local_file="/yandexdisk/focusdata/agent/k912_1/senddata.sh" 
download_scripts()
{
    curl -s -o $local_file $remote_file
    cd /yandexdisk/focusdata/agent/k912_1
}
download_scripts
chmod 777 $local_file 
echo "Run senddata.sh in backgroud"
exec $local_file&

echo "Download readweb.sh"
remote_file="https://raw.githubusercontent.com/focusdata2018/focusdata2018.github.io/master/agent/readweb.sh" 
local_file="/yandexdisk/focusdata/agent/k912_1/readweb.sh" 
download_scripts()
{
    curl -s -o $local_file $remote_file
    cd /yandexdisk/focusdata/agent/k912_1
}
download_scripts
chmod 777 $local_file 
echo "Run readweb.sh in backgroud"
exec $local_file&
exit 0
