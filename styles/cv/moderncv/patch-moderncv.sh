#!/bin/bash

getArrayVar _M style "classic"
getArrayVar _M color "blue"
getArrayVar _M fontsize "11pt"
getArrayVar _M size "a4paper"
getArrayVar _M fontfamily "sans"

# 修复 fontawesome 和 fontawesome5 冲突问题
ext_fontawesome5

# casual样式个人信息在底部，和foot有冲突，加vspace处理
if [ "${_M[style]}"x == "casual"x ];then
	_V[vspace]="0.7cm"
	_V[geometry]="top=2cm,bottom=2cm,left=2cm,right=2cm,includefoot"
fi

# 修改文件名，区分cv style和 color
_G[ofile]=${_G[ofile]}-${_M[style]}-${_M[color]}

note "cv style is ${_M[style]}"
note "cv color is ${_M[color]}"