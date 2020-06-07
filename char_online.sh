#!/bin/bash

file='./data/char_onlinetime.txt'
rm -fr $file
timestamp=$(date +%s%N)
while read -a row
do
    echo "char_online,char_name=${row[0]} value=${row[1]} $timestamp" >> $file
done < <(echo "SELECT char_name,onlinetime FROM characters" | mysql l2jgs -u root)

sed -i '1d' $file
curl -i -XPOST 'http://localhost:8086/write?db=l2j' --data-binary @$file
