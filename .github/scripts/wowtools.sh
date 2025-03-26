#!/bin/bash

wget -O ".wowtools.json" "https://wow.tools/api.php?type=currentbc"
wowbuild="806f4fd265de05a9b328310fcc42eed0"

wget -O "wod_beta_list.csv" "https://wow.tools/casc/listfile/download/csv/build?buildConfig=${wowbuild}&typeFilter=m2"
if [ $? -ne 0 ]; then
    echo "error while downloading wod_beta_list.csv"
else
    lua ./csv_to_lua.lua wod_beta
    if [ $? -ne 0 ]; then
        echo "error while creating lua file"
    else
        mv ModelPaths.lua ../../WeakAurasModelPaths/
    fi
fi
