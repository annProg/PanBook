#!/bin/bash
note "use -V device:(pc|mobile|kindle) to produce different size of pdf"
note "use -V cover:(1-60|R|N|filepath) select cover background.R=random,N=no cover,filepath=custom cover file"
note "use -V pagestyle:style to set pagestyle"

# 启用扩展
ext_device
ext_note tex

getArrayVar _V "classoption" "fancyhdr,bookmark"
getArrayVar _V "pagestyle" "fancy"
getArrayVar _V "device" "pc"
getArrayVar _V "cover" "29"
getArrayVar _V "titlepage" "true"

echo ${_V[cover]} |grep -q '[^0-9]'
if [ $? -eq 1 ];then
	if [ ${_V[cover]} -lt 61 -a ${_V[cover]} -gt 0 ];then
		_V[background]="images/${_V[cover]}.png"
	fi
elif [ ${_V[cover]} == "R" ];then
	_V[background]="images/$(($RANDOM%60)).png"
elif [ ${_V[cover]} == "N" ];then
	_V[background]=""
else
	_V[background]=${_V[cover]}
	unset _V[titlepage]
fi