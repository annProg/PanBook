#!/bin/bash

_P[standalone]=""

FIX=${_G[build]}/fix-ctexart.tex

cat > $FIX << EOF
\renewenvironment*{abstract}[2]{
    \def\invalue{#1}
    \def\english{e}
    \def\keywords{#2}
    % 论文题目
    \begin{center}
        \ifx\invalue\english
            {\Large \bfseries Abstract} \\
        \else
            {\Large \bfseries 摘~要} \\
        \fi
        \vspace{0.2em}
    \end{center}
}{
	\par
	\noindent
	\ifx\invalue\english
		{\bfseries Key Words: }
	\else
		{\bfseries 关键词： }
	\fi
	\keywords
}
EOF

writeHeader $FIX

# 默认模板给xeCJK加了个选项，导致不能编译，见 https://github.com/jgm/pandoc/pull/5855
[ "${_P[template]}"x == ""x ] && _P[template]="${_G[scriptdir]}/${_G[tpldir]}/latex/latex.tpl"
