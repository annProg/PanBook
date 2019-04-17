\documentclass[$if(elegantoption)$$elegantoption$$else$cn$endif$]{elegantbook}

% pandoc版本大于1.15时需要\tightlist
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

\usepackage[yyyymmdd,hhmmss]{datetime}

% 设备类型
\newcommand{\devicemobile}{
	\geometry{
		paperwidth=9.0cm,
		paperheight=16cm,
		margin=0.5cm,
		left=0.1cm,
		right=0.1cm,
		top=0.1cm,
		bottom=0.2cm
	}
}

\newcommand{\devicekindle}{
	\geometry{
		paperwidth=9.0cm,
		paperheight=11.7cm,
		margin=0.5cm,
		left=0.1cm,
		right=0.1cm,
		top=0.1cm,
		bottom=0.2cm
	}
}

\newcommand{\devicepc}{
	\geometry{
		top=1in,
		inner=1in,
		outer=1in,
		bottom=1in,
		headheight=3ex,
		headsep=2ex
	}
}

$if(device)$
\device$device$
$else$
\devicepc
$endif$

$if(listings)$
\definecolor{lightgray}{rgb}{0.97,0.97,1}
\newcommand{\passthrough}[1]{\colorbox{lightgray}{#1}}
\lstset{
	basicstyle=\small\linespread{0.9}\ttfamily,
	frame=shadowbox,
	backgroundcolor=\color[rgb]{0.97,0.97,0.97},
	tabsize=4,
	breaklines=tr,
	showstringspaces=false,
}
\renewcommand{\lstlistingname}{代码}
$endif$

$if(lhs)$
\lstnewenvironment{code}{\lstset{language=Haskell,basicstyle=\small\ttfamily}}{}
$endif$

$if(highlighting-macros)$
$highlighting-macros$
$endif$
$if(verbatim-in-note)$
\usepackage{fancyvrb}
$endif$

$if(tables)$
\usepackage{longtable,booktabs}
$endif$

$if(graphics)$
\usepackage{graphicx,grffile}
\makeatletter
\def\maxwidth{\ifdim\Gin@nat@width>\linewidth\linewidth\else\Gin@nat@width\fi}
\def\maxheight{\ifdim\Gin@nat@height>\textheight\textheight\else\Gin@nat@height\fi}
\makeatother
$endif$

$if(title)$
\title{$title$}
$endif$
$if(subtitle)$
\subtitle{$subtitle$}
$endif$
$if(author)$
\author{$for(author)$$author$$sep$, $endfor$}
$endif$
\date{\today}

$for(header-includes)$
$header-includes$
$endfor$


$if(equote)$
\equote{$equote$}
$else$
\equote{使用PanBook编译}
$endif$

$if(logo)$
\logo{$logo$}
$else$
\logo{logo.png}
$endif$

$if(cover)$
\cover{$cover$}
$else$
\cover{cover.jpg}
$endif$


\begin{document}
\frontmatter

\maketitle

$if(graphics)$
% 这条命令要放在封面后面，否则封面不能铺满整页
% Scale images if necessary, so that they will not overflow the page
% margins by default, and it is still possible to overwrite the defaults
% using explicit options in \includegraphics[width, height, ...]{}
\setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}
$endif$


$if(copyright)$
\newpage
%~\vfill
\thispagestyle{empty}

\noindent Copyright \copyright\ \the\year\  $if(author)$$for(author)$$author$$sep$, $endfor$$endif$\\ % Copyright notice

\noindent \textsc{Published by \href{https://github.com/annProg/PanBook}{PanBook}}\\ % Publisher
$if(homepage)$
\noindent \textsc{$homepage$}\\ % URL
$endif$

$if(licence)$
\l$licence$

$else$
\noindent 版权所有，未经许可，不得复制本书任何内容。\\

$endif$
\noindent \textit{最后编译日期, \today\ \currenttime } % Printing/edition date
$endif$

\tableofcontents

$if(lot)$
\listoftables
\addcontentsline{toc}{chapter}{表格列表}
$endif$
$if(lof)$
\listoffigures
\addcontentsline{toc}{chapter}{插图列表}
$endif$

\clearpage
\thispagestyle{empty}

$for(include-before)$
$include-before$
$endfor$

\mainmatter
\hypersetup{pageanchor=true}

$body$

\backmatter

$if(natbib)$
$if(biblio-files)$
$if(biblio-title)$
$if(book-class)$
\renewcommand\bibname{$biblio-title$}
$else$
\renewcommand\refname{$biblio-title$}
$endif$
$endif$
\bibliography{$biblio-files$}

$endif$
$endif$
$if(biblatex)$
\printbibliography$if(biblio-title)$[title=$biblio-title$]$endif$

$endif$

$for(include-after)$
$include-after$
$endfor$

\end{document}
