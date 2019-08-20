#!/bin/bash
note "use -V background=(simple|plasma-56-kver|circles) to change background style"
getArrayVar _V background "plasma-56-kver"
STYLEIMAGE="${_G[build]}/style/images"
[ ! -d $STYLEIMAGE ] && mkdir -p $STYLEIMAGE
cp -rf ${_G[build]}/style/images-${_V[background]}/* $STYLEIMAGE

(cat fix-elegance.tex;echo) >> ${_G[header]}

# 修复caption报错
# ! Undefined control sequence. \beamer@thmffamily@caption name ->\Book
sed -i '/setbeamerfont{caption name}/d' ${_G[build]}/beamerthemeelegance.sty