#!/bin/bash
getVar COLORTHEME "dark"
THEMEOPT="$THEMEOPT -V themeoptions=colors=$COLORTHEME"
addOptions="--template=classyslides.tpl"
note "THEMEOPT: $THEMEOPT"
sed -i '/shadowbox/d' listings-set.tex