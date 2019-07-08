#!/bin/bash

# 启用扩展
ext_wrap tex
#ext_theorem tex

_P[standalone]=""

FIX=${_G[build]}/fix-ctexart.tex

cat > $FIX << EOF
\newcommand{\keywords}[1]{\vskip2ex\par\noindent\normalfont{\bfseries 关键词: } #1}
EOF

writeHeader $FIX