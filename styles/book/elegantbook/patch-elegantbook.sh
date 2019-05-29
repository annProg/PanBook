#!/bin/bash

# use this path to set custom addOptions, PANDOCVARS and LSTSET COPYPAGE

note "use -V device:(pc|mobile|kindel) to produce different size of pdf"
note "use -V cover:path to use custom cover image"
note "use -V logo:path to use custom logo image"

# 启用扩展
ext_device

# 默认模板需要禁用mathspec. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
getArrayVar _V mathspec "false"