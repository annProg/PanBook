\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2011/04/05 v0.1 Thesis Template for Doctor]

\LoadClass[cs4size,a4paper,fancyhdr,fntef, UTF8]{ctexbook}
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm}
\RequirePackage{epigraph, titlesec, textcomp}
\RequirePackage{natbib}

\renewcommand\title[1]{\def\IHEP@value@title{#1}}
\renewcommand\author[1]{\def\IHEP@value@author{#1}}

\renewcommand{\maketitle}{%
      \clearpage
      \thispagestyle{empty}
      \vspace*{50pt}
      \begin{center}
      \bf\songti\zihao{-1}中国科学院研究生院\\博士学位论文
      \vskip 50pt
      \bf\heiti\zihao{3} \underline{~\IHEP@value@title~}
      \vskip 20pt
      \bf\kaishu\zihao{4} \underline{~\IHEP@value@author~}
      \end{center}
}

\makeatletter
\def\IHEP@value@title{~~~~~（论~文~题~目）~~~~~}
\def\IHEP@value@author{~~~~~（作~者~姓~名）~~~~~}
\makeatother

\endinput