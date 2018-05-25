#!/bin/sh
# XARGS="xargs -n 1 -P 4"
# XARGS="parallel"
[ -z "$XARGS" ] && XARGS="xargs"
MSG="hello"
cowsay -l | sed '1d;s/ /\
/g' | $XARGS -I{} cowsay -f {} $MSG
echo -e 'b\nd\ng\np\ns\nt\nw\ny' | $XARGS -I{} cowsay -{} $MSG
