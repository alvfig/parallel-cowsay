#!/bin/sh

BAT="./batch.sh"
RDS="3"

lscpu
AWKSCT='BEGIN { cnt=0 } \
    { if (4 < NR && ! ($3$2 in lst)) { lst[$3$2]=0; ++cnt }} \
    END { print cnt }'
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
