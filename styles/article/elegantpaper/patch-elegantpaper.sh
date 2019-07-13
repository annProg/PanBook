#!/bin/bash

_P[standalone]=""

# 默认模板需要禁用unicode-math. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
_V[mathspec]="true"
_V[documentclass]="elegantpaper"
getArrayVar _V classoption "cn"
unset _P[toc]


# amsmath and mathspec bug: 
# https://tex.stackexchange.com/questions/85696/what-causes-this-strange-interaction-between-glossaries-and-amsmath
FIX=${_G[build]}/fix-elegantpaper.tex
cat > $FIX <<EOF
\makeatletter % undo the wrong changes made by mathspec
\let\RequirePackage\original@RequirePackage
\let\usepackage\RequirePackage
\makeatother
\renewenvironment*{abstract}[2]{
    \def\invalue{#1}
    \def\english{e}
    \def\keywords{#2}
    % 论文题目
    \begin{center}
        \ifx\invalue\english
            {\small \bfseries Abstract} \\
        \else
            {\small \bfseries 摘~要} \\
        \fi
        \vspace{0.2em}
    \end{center}
	\itshape
}{
	\par
	\noindent
	\ifx\invalue\english
		{\bfseries Key Words: }
	\else
		{\bfseries 关键词： }
	\fi
	\upshape
	\keywords
}
EOF

writeHeader $FIX

# wrap 写入的header需要放到 $FIX 后面（修复amsmath and mathspec bug）
ext_wrap tex
#ext_theorem tex
