#!/bin/sh
# XARGS="xargs -n 1 -P 4"
# XARGS="parallel"
[ -z "$XARGS" ] && XARGS="xargs"
MSG="hello"
cowsay -l | sed '1d;s/ /\n/g' | $XARGS -I{} cowsay -f {} $MSG
echo -n 'b d g p s t w y' | $XARGS -d ' ' -I{} cowsay -{} $MSG
