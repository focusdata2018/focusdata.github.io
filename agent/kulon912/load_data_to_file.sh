#!/system/bin/sh
cd /storage/sdcard0/agent912
[ -f "/storage/sdcard0/agent912/src_data.cfg" ] || ./wget -U Mozilla -O /storage/sdcard0/agent912/src_data.cfg https://focusdata2018.github.io/agent/kulon912/src_data.cfg;
[ -d "/storage/sdcard0/agent912/data" ] || mkdir ./data;
for URL in `cat ./src_data.cfg`; 
do echo $URL;
./wget -U Mozilla -O ./data/output__$("%m_%d_%Y__%H_%M_%S").txt $URL
done
