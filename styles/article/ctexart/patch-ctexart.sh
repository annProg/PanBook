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