#!/bin/sh
xargs -I{} echo sudo apt {} <<PKGS | sh -v
update
install cowsay -y
install parallel -y
PKGS
