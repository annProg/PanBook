#!/bin/bash

# use this path to set custom addOptions, PANDOCVARS and highLight

note "use -E device=(pc|mobile|kindel) to produce different size of pdf"
note "use -E cover=path to use custom cover image"
note "use -E logo=path to use custom logo image"
note "use -E privatetpl=(true|false) to use custom template define by this class"

getVar privatetpl "true"
[ "$privatetpl"x == "true"x ] && addOptions="--template=elegantbook.tpl"

# 默认模板需要禁用mathspec. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
addOptions="$addOptions -V device=$device -V mathspec=false"
division="--top-level-division=chapter"
highLight=""

[ "$cover"x != ""x ] && addOptions="$addOptions -V cover=$cover"
[ "$logo"x != ""x ] && addOptions="$addOptions -V logo=$logo"