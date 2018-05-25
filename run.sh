#!/bin/sh

BAT="./batch.sh"
RDS="3"

lscpu
AWKSCT='BEGIN{prvs=-1}{if(4<NR&&prvs!=$2){++cnt;prvs=$2}}END{print cnt}'
CPUCNT=`lscpu -p | awk -F , "$AWKSCT"`
CRECNT=`nproc`

for i in `seq $RDS`; do
    echo "\n====> ROUND #$i <====\n"
    xargs -I{} echo "env XARGS='{}' time -p $BAT > /dev/null" <<-ARGS | sh -v 2>&1
    xargs -P 0
    xargs -P $CRECNT
    xargs -P $CPUCNT
    parallel
    xargs -P 1
ARGS
done
