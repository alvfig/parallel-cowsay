#!/bin/sh

BAT="./batch.sh"
RDS="3"

lscpu
AWKSCT='BEGIN{prvs=-1}{if(4<NR&&prvs!=$1){++cnt;prvs=$1}}END{print cnt}'
CPUCNT=`lscpu -p | awk -F , "$AWKSCT"`

for i in `seq $RDS`; do
    echo "\n====> ROUND #$i <====\n"
    xargs -I{} echo "env XARGS='{}' time $BAT > /dev/null" <<-ARGS | sh -v 2>&1
    xargs -P 0
    xargs -P $CPUCNT
    parallel
    xargs -P 1
ARGS
done
