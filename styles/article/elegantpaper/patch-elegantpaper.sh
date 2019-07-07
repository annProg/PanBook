#!/bin/bash

# 启用扩展
ext_wrap tex
#ext_theorem tex
_P[standalone]=""

# 默认模板需要禁用unicode-math. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
_V[mathspec]="true"
_V[documentclass]="elegantpaper"
getArrayVar _V classoption "cn"
unset _P[toc]