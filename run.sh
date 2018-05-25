#!/bin/sh

BAT="./batch.sh"
RDS="3"

CPUCNT=4
CRECNT=2

for i in `seq $RDS`; do
    echo "\n====> ROUND #$i <====\n"
    xargs -I{} echo "env XARGS='{}' time -p $BAT > /dev/null" <<-ARGS | sh -v 2>&1
    xargs -P $CRECNT
    xargs -P $CPUCNT
    xargs -P 1
ARGS
done
