#!/bin/bash

file='./data/char_adena.txt'
rm -fr $file
timestamp=$(date +%s%N)
while read -a row
do
    echo "char_adena,char_name=${row[0]} value=${row[1]} $timestamp" >> $file
done < <(echo "SELECT characters.char_name,items.count FROM characters INNER JOIN items ON characters.charId=items.owner_id WHERE item_id=57 AND loc='INVENTORY' GROUP BY count ORDER BY count DESC" | mysql l2jgs -u root)

sed -i '1d' $file
curl -i -XPOST 'http://localhost:8086/write?db=l2j' --data-binary @$file
