#!/bin/bash

remote_file="https://raw.githubusercontent.com/focusdata2018/focusdata2018.github.io/master/agent/senddata.sh" 
local_file="/yandexdisk/focusdata/agent/k912_1/senddata.sh" 

download_scripts()
{
curl -o $local_file $remote_file
cd /yandexdisk/focusdata/agent/k912_1
}

download_scripts
chmod 777 $local_file

exec $local_file
