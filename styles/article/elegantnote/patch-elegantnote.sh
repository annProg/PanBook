#!/bin/bash

ext_wrap tex
#ext_theorem tex
# 默认模板需要禁用unicode-math. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
_V[documentclass]="elegantnote"
_P[standalone]=""
_V[mathspec]="true"