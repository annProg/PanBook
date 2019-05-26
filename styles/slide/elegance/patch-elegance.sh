#!/bin/bash
note "use -V background=(simple|plasma-56-kver|circles) to change background style"
getArrayVar _V background "plasma-56-kver"
STYLEIMAGE="${_G[build]}/style/images"
[ ! -d $STYLEIMAGE ] && mkdir -p $STYLEIMAGE
cp -rf ${_G[build]}/style/images-${_V[background]}/* $STYLEIMAGE

(cat fix-elegance.tex;echo) >> ${_G[header]}