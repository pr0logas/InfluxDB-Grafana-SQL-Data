#!/bin/bash

timestamp=$(date +%s%N)
count=$(curl -s https://explorer.adeptio.cc/ext/getbalance/ASpLv9c3UTN6SZXYR29iW46xFGjHRRvPWf)

curl -i -XPOST 'http://localhost:8086/write?db=l2j' --data-binary "adeptio_bank,adeptio_bank=countSum value=$count $timestamp"
