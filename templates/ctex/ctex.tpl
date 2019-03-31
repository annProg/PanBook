\documentclass[fancyhdr,bookmark]{ctexbook}
\setCJKmainfont{SimSun}
\setmainfont{DejaVu Sans} 	% 設定英文字型
\setromanfont{DejaVu Sans} 	% 字型
\setmonofont{DejaVu Sans Mono}

% pandoc版本大于1.15时需要\tightlist
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

\usepackage{tikz} % Required for drawing custom shapes
\usepackage[yyyymmdd,hhmmss]{datetime}
\ctexset{today=small}
\usepackage{geometry} 		% 設定邊界
\geometry{
  top=1in,
  inner=1in,
  outer=1in,
  bottom=1in,
  headheight=3ex,
  headsep=2ex
}

\newfontfamily\code{Courier New}

$if(listings)$
\usepackage{listings}
\definecolor{ocre}{RGB}{243,102,25} % Define the orange color used for highlighting throughout the book
\newcommand{\passthrough}[1]{#1}
\lstset{
	%numbers=left,
	%numberstyle=\tiny,
	basicstyle=\small\linespread{1}\code,
	keywordstyle=\color[rgb]{0.13,0.29,0.53}\textbf,
	commentstyle=\color{gray},
	identifierstyle=\color[rgb]{0.00,0.00,0.00},
	stringstyle=\color[rgb]{0.31,0.60,0.02},
	frame=shadowbox,
	rulesepcolor=\color{red!20!green!20!blue!20},
	backgroundcolor=\color[rgb]{0.97,0.97,0.97},
	tabsize=4,
	breaklines=tr,
	showstringspaces=false,
}
\renewcommand{\lstlistingname}{代码}
$endif$

$if(lhs)$
\lstnewenvironment{code}{\lstset{language=Haskell,basicstyle=\small\code}}{}
$endif$

$if(highlighting-macros)$
$highlighting-macros$
$endif$
$if(verbatim-in-note)$
\usepackage{fancyvrb}
$endif$

\ifxetex
  \usepackage[setpagesize=false, % page size defined by xetex
              unicode=false, % unicode breaks when used with xetex
              xetex]{hyperref}
\else
  \usepackage[unicode=true]{hyperref}
\fi
\hypersetup{breaklinks=true,
            bookmarks=true,
            pdfauthor={$author-meta$},
            pdftitle={$title-meta$},
            colorlinks=true,
            urlcolor=$if(urlcolor)$$urlcolor$$else$blue$endif$,
            linkcolor=$if(linkcolor)$$linkcolor$$else$magenta$endif$,
            pdfborder={0 0 0}}
\urlstyle{same}  % don't use monospace font for urls
$if(links-as-notes)$
% Make links footnotes instead of hotlinks:
\renewcommand{\href}[2]{#2\footnote{\url{#1}}}
$endif$

$if(tables)$
\usepackage{longtable,booktabs}
$endif$
$if(graphics)$
\usepackage{graphicx}
\makeatletter
\def\maxwidth{\ifdim\Gin@nat@width>\linewidth\linewidth\else\Gin@nat@width\fi}
\def\maxheight{\ifdim\Gin@nat@height>\textheight\textheight\else\Gin@nat@height\fi}
\makeatother
% Scale images if necessary, so that they will not overflow the page
% margins by default, and it is still possible to overwrite the defaults
% using explicit options in \includegraphics[width, height, ...]{}
\setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}
$endif$

$if(verbatim-in-note)$
\VerbatimFootnotes % allows verbatim text in footnotes
$endif$

$if(title)$
\title{$title$$if(subtitle)$\\\vspace{0.5em}{\large $subtitle$}$endif$}
$endif$
$if(author)$
\author{$for(author)$$author$$sep$ \and $endfor$}
$endif$
\date{$date$}
$for(header-includes)$
$header-includes$
$endfor$

\usepackage{fancyhdr}
%\usepackage{lastpage}
\pagestyle{fancy}


\begin{document}
\frontmatter
%----------------------------------------------------------------------------------------
%	TITLE PAGE
%----------------------------------------------------------------------------------------

\begingroup
\thispagestyle{empty}
\begin{tikzpicture}[remember picture,overlay]
\node[inner sep=0pt] (background) at (current page.center) {\includegraphics[width=\paperwidth]{Pictures/background}};
$if(title)$
\draw (current page.center) node [fill=ocre!30!white,fill opacity=0.6,text opacity=1,inner sep=1cm]
{\Huge\centering\bfseries\sffamily\parbox[c][][t]{\paperwidth}
{\centering $title$\\[13pt] % Book title
$endif$
$if(subtitle)$
{\Large $subtitle$}\\[15pt] % Subtitle
$endif$
$if(author)$
{\huge $for(author)$$author$$sep$ \and $endfor$} % Author name
$endif$
}};
\end{tikzpicture}
\vfill
\endgroup
\addcontentsline{toc}{chapter}{封面}

%----------------------------------------------------------------------------------------
%	COPYRIGHT PAGE
%----------------------------------------------------------------------------------------
$if(copyright)$
\newpage
~\vfill
\thispagestyle{empty}

\noindent Copyright \copyright\ \the\year\  $if(author)$$for(author)$$author$$sep$ \and $endfor$$endif$\\ % Copyright notice

\noindent \textsc{Published by \LaTeX}\\ % Publisher
$if(homepage)$
\noindent \textsc{$homepage$}\\ % URL
$endif$

\noindent Licensed under the Creative Commons Attribution-NonCommercial 3.0 Unported License (the ``License''). You may not use this file except in compliance with the License. You may obtain a copy of the License at \url{http://creativecommons.org/licenses/by-nc/3.0}. Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \textsc{``as is'' basis, without warranties or conditions of any kind}, either express or implied. See the License for the specific language governing permissions and limitations under the License.\\ % License information

\noindent \textit{最后编译日期, \today\ \currenttime } % Printing/edition date
$endif$

$if(showtitle)$
\maketitle
$endif$

$for(include-before)$
$include-before$

$endfor$

$if(toc)$
{
\hypersetup{linkcolor=black}
\setcounter{tocdepth}{$toc-depth$}
\tableofcontents
\addcontentsline{toc}{chapter}{目录}
}
$endif$
$if(lot)$
\listoftables
\addcontentsline{toc}{chapter}{表格列表}
$endif$
$if(lof)$
\listoffigures
\addcontentsline{toc}{chapter}{插图列表}
$endif$



\mainmatter
    % 在此命令之后的页码为阿拉伯数字
    % 以下为正文
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
