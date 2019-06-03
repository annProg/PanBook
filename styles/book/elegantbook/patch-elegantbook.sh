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
# 默认模板需要禁用mathspec. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
getArrayVar _V mathspec "false"