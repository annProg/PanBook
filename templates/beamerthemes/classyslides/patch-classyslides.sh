#!/bin/bash
getEnv COLORTHEME "dark"
THEMEOPT="$THEMEOPT -V themeoptions=colors=$COLORTHEME"
customHeader="--template=classyslides.tpl"
note "THEMEOPT: $THEMEOPT"
sed -i '/shadowbox/d' listings-set.tex