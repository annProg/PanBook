#!/bin/bash

# 默认模板需要禁用unicode-math. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
_V[documentclass]="elegantnote"
_P[standalone]=""
_V[mathspec]="true"

# amsmath and mathspec bug: 
# https://tex.stackexchange.com/questions/85696/what-causes-this-strange-interaction-between-glossaries-and-amsmath
FIX=${_G[build]}/fix-elegantnote.tex
cat > $FIX <<EOF
\makeatletter % undo the wrong changes made by mathspec
\let\RequirePackage\original@RequirePackage
\let\usepackage\RequirePackage
\makeatother
EOF

writeHeader $FIX

# wrap 写入的header需要放到 $FIX 后面（修复amsmath and mathspec bug）
ext_wrap tex
#ext_theorem tex