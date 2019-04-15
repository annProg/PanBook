#!/bin/bash
note "use -E background=(simple|plasma-56-kver|circles) to change background style"
getVar background "plasma-56-kver"
STYLEIMAGE="$cwd/build/style/images"
info "StyleImage: $STYLEIMAGE-$background"
[ ! -d $STYLEIMAGE ] && mkdir -p $STYLEIMAGE
cp -rf $cwd/build/style/images-$background/* $STYLEIMAGE
addOptions="-H fix-elegance.tex"