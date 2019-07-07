#!/bin/bash

# use this path to set custom addOptions, PANDOCVARS and LSTSET COPYPAGE

note "use -V device:(pc|mobile|kindel) to produce different size of pdf"
note "use -V cover:path to use custom cover image"
note "use -V logo:path to use custom logo image"

# 启用扩展
ext_device

# introduction和problemset文档类中已有定义，取消writeHeader
unset _G[ext-wrap-introduction]
unset _G[ext-wrap-problemset]
ext_wrap tex
ext_theorem

if [ "${_P[template]}"x != "" ];then
	_V[documentclass]="elegantbook"
	getArrayVar _V classoption "cn"
	getArrayVar _V cover "cover.jpg"
	getArrayVar _V logo "logo.png"
	getArrayVar _V extrainfo "使用~PanBook~编译"
	
	FIXHYPERREF=${_G[build]}/fix-elegantpaper-hyperref.tex
	echo "\hypersetup{pageanchor=true}" > $FIXHYPERREF
	_P[include-before-body__]=$FIXHYPERREF
	FIX=${_G[build]}/fix-elegantpaper.tex
	echo "\cover{${_V[cover]}}" > $FIX
	echo "\logo{${_V[logo]}}" >> $FIX
	echo "\extrainfo{${_V[extrainfo]}}" >> $FIX
	writeHeader $FIX
fi

# 默认模板需要禁用unicode-math. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
_V[mathspec]="true"