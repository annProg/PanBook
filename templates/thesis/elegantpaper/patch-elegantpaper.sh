#!/bin/bash

# 默认模板需要禁用mathspec. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
addOptions="$addOptions -V mathspec=false"
TEX_OUTPUT="$ofile-$TPL-$t.tex"

setPandocVar classoption "cn"