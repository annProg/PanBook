\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{inkbook}[2019/6/29 v1.0 Book template.]
\LoadClass[UTF8,a4paper,openany]{ctexbook}
\RequirePackage{zhnumber}
% \RequirePackage[draft]{graphicx}
\RequirePackage{graphicx}
%\RequirePackage{subfigure}
\AtEndOfClass{\RequirePackage{microtype}}
\RequirePackage{latexsym, amsmath, amssymb, amsfonts, mathrsfs, amsthm}
\RequirePackage{siunitx}
\RequirePackage{cite}
\RequirePackage{cases}
\RequirePackage{etoolbox}
\RequirePackage{multirow}
\RequirePackage{textcomp}
\RequirePackage[top=2.54cm, bottom=2.54cm, left=3.18cm, right=3.18cm]{geometry}
\RequirePackage[toc,lof]{multitoc}

\RequirePackage[colorlinks,linkcolor=blue]{hyperref}

\SetupKeyvalOptions{family=INK, prefix=INK@, setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{INK}{#1}}
\DeclareStringOption[cn]{lang}
\DeclareVoidOption{cn}{\ekv{lang = cn}}
\DeclareVoidOption{en}{\ekv{lang = en}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ExecuteOptions{12pt}
\ProcessKeyvalOptions*\relax
\ProcessOptions

\setcounter{secnumdepth}{3} %使subsubsection也有编号

\RequirePackage{fancyhdr}	%页眉页脚
\RequirePackage{ifxetex}
% \ifxetex
% 	\RequirePackage{fontenc}
% 	\RequirePackage[no-math]{fontspec}
%     \setsansfont{Arial}
%     \setmonofont[Scale=0.7]{Courier New}
% 	%\setmonofont[Scale=0.7]{Courier New}
% 	\RequirePackage{xeCJK}
% 	\RequirePackage{xunicode}
% 	\setCJKmainfont[BoldFont={SimHei},ItalicFont={KaiTi}]{SimSun}
% 	\setCJKsansfont[BoldFont={SimHei},ItalicFont={KaiTi}]{KaiTi}
% 	\setCJKmonofont[BoldFont={SimHei},ItalicFont={KaiTi},Scale=0.7]{Microsoft YaHei}
% 	\XeTeXlinebreaklocale "zh"
% 	\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt
% 	\RequirePackage{newtxmath}
% 	%\DeclareSymbolFont{operators}{OT1}{ntxtlf}{m}{n}
% 	%\SetSymbolFont{operators}{bold}{OT1}{ntxtlf}{b}{n}
% 	\setCJKfamilyfont{zhsong}{SimSun}
% 	\setCJKfamilyfont{zhhei}{SimHei}
% 	\setCJKfamilyfont{zhkai}{KaiTi}
% 	\setCJKfamilyfont{zhfs}{FangSong}
% 	\renewcommand*{\songti}{\CJKfamily{zhsong}} 
% 	\renewcommand*{\heiti}{\CJKfamily{zhhei}}   
% 	\renewcommand*{\kaishu}{\CJKfamily{zhkai}} 
% 	\renewcommand*{\fangsong}{\CJKfamily{zhfs}} 
% \else
% \relax
% \fi
\RequirePackage[inline]{enumitem}
\setlist[enumerate,1]{leftmargin=0pt,itemindent=2em,itemsep=0ex,listparindent=2em,parsep = 0ex,topsep = 1ex}
\setlist[enumerate,2]{leftmargin=1em,itemsep=0ex,itemindent=2em,listparindent=2em,parsep = 0ex,topsep = 1ex}
\setlist[enumerate,3]{leftmargin=1em,itemsep=0ex,itemindent=2em,listparindent=2em,parsep = 0ex,topsep = 1ex}
\setlist[itemize,1]{itemsep = 0ex, parsep = 0ex, topsep = 1ex}
\setlist[description]{listparindent=2em, itemsep=0ex, parsep = 0ex,topsep = 1ex}
\ctexset{
	figurename={\kaishu 图},
	tablename={表},
	contentsname={目\quad 录},
	listfigurename={插图目录}
}



\newcommand{\mypart}[1]{
\begin{tabular}{p{0.01\textwidth}p{0.99\textwidth}}
	\arrayrulewidth=0.4pt
	\cellcolor{black} & \cellcolor{partcolor} \textcolor{white}
	{\newline\heiti\Huge 第\thepart 部分}\\
	\hline
	\cellcolor{black} & \multicolumn{1}{r}{\cellcolor{partcolor} \textcolor{white}
	{\huge #1}}
\end{tabular}
\arrayrulewidth=0.4pt
}
 
\newcommand{\mytitle}[1]{
\begin{tabular}{p{0.01\textwidth}p{0.98\textwidth}}
\cellcolor{black} &\cellcolor{titlecolor} \textcolor{white}
{\newline\heiti\LARGE 第\zhnumber{\thechapter}章 \  \ #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
 
\newcommand{\mycont}[1]{
\vspace{-0.5cm}
\begin{tabular}{p{0.01\textwidth}p{0.98\textwidth}}
\cellcolor{black} &\cellcolor{contentcolor} \textcolor{white}
{\newline\heiti\LARGE #1}
\end{tabular}
\arrayrulewidth=0.4pt
\vspace{-1.5cm}
}
 
\newcommand{\mysection}[1]{
\setlength\arrayrulewidth{1pt}\arrayrulecolor{titlecolor}
\begin{tabular}{p{0.01\textwidth}p{0.98\textwidth}}
\hline
\cellcolor{titlecolor} &  \textcolor{black}{\heiti\LARGE \thesection ~ #1}
\end{tabular}
\arrayrulewidth=0.4pt
\vspace{-0.7cm}
}

\newcommand{\mysubsection}[1]{
\setlength\arrayrulewidth{1pt}\arrayrulecolor{titlecolor}
\begin{tabular}{p{0.01\textwidth}p{0.98\textwidth}}
\hline
\cellcolor{titlecolor} &  \textcolor{black}{\heiti\Large \thesubsection ~ #1} \\
\hline
\end{tabular}
\arrayrulewidth=0.4pt
\vspace{-0.5cm}
}

\newcommand{\mysubsubsection}[1]{
\setlength\arrayrulewidth{1pt}\arrayrulecolor{titlecolor}
\begin{tabular}{p{0.01\textwidth}p{0.975\textwidth}p{0.01\textwidth}}
\hline
\cellcolor{titlecolor} &  \textcolor{black}{\heiti\large \thesubsubsection ~ #1} & \cellcolor{titlecolor} \\
\hline
\end{tabular}
\arrayrulewidth=0.4pt
\vspace{-0.5cm}
}

\newcommand{\myappendix}[1]{
\begin{tabular}{p{0.01\textwidth}p{0.98\textwidth}}
\cellcolor{black} &\cellcolor{backcolor} \textcolor{white}
{\newline\heiti\LARGE 附录\thechapter \  \ #1}
\end{tabular}
\arrayrulewidth=0.4pt
}

 
\newcommand{\appendixsection}[1]{
\setlength\arrayrulewidth{1pt}\arrayrulecolor{backcolor}
\begin{tabular}{p{0.01\textwidth}p{0.99\textwidth}}
\hline
\cellcolor{backcolor} &  \textcolor{black}{\heiti\LARGE \thesection ~ #1}
\end{tabular}
\arrayrulewidth=0.4pt
\vspace{-0.7cm}
}

\newcommand{\appendixsubsection}[1]{
\setlength\arrayrulewidth{1pt}\arrayrulecolor{backcolor}
\begin{tabular}{p{0.01\textwidth}p{0.99\textwidth}}
\hline
\cellcolor{backcolor} &  \textcolor{black}{\heiti\Large \thesubsection ~ #1} \\
\hline
\end{tabular}
\arrayrulewidth=0.4pt
\vspace{-0.5cm}
}

\newcommand{\appendixsubsubsection}[1]{
\setlength\arrayrulewidth{1pt}\arrayrulecolor{backcolor}
\begin{tabular}{p{0.01\textwidth}p{0.95\textwidth}p{0.01\textwidth}}
\hline
\cellcolor{backcolor} &  \textcolor{black}{\heiti\large \thesubsubsection ~ #1} & \cellcolor{backcolor} \\
\hline
\end{tabular}
\arrayrulewidth=0.4pt
\vspace{-0.5cm}
}

\newcommand{\mybackmatter}[1]{
\begin{tabular}{p{0.01\textwidth}p{0.99\textwidth}}
\cellcolor{black} &\cellcolor{backcolor} \textcolor{white}
{\newline\heiti\LARGE #1}
\end{tabular}
\arrayrulewidth=0.4pt
}


\newtheoremstyle{theoremwithoutdot}% 类型名
  {}%                   Space above, empty = `usual value'
  {}%                   Space below
  {\kaishu}%                   Body font
  {}%         Indent amount (empty = no indent, \parindent = para indent)
  {\heiti}%          Thm head font
  {}%                   Punctuation after thm head
  {1em}%                Space after thm head
  {\thmname{#1}\thmnumber{~#2}\thmnote{~(#3)}}%                   Thm head spec
  
 \newtheoremstyle{solutionstyle}% 类型名
  {}%                   Space above, empty = `usual value'
  {}%                   Space below
  {}%                   Body font
  {}%         Indent amount (empty = no indent, \parindent = para indent)
  {\heiti}%          Thm head font
  {}%                   Punctuation after thm head
  {1em}%                Space after thm head
  {\thmname{#1}\thmnumber{~#2}\thmnote{~(#3)}}%                   Thm head spec


%去掉证明后面的点
\makeatletter
\renewenvironment{proof}[1][\proofname]{\par%
\pushQED{\qed}%
\normalfont \topsep6\p@\@plus6\p@\relax%
\trivlist%
\item[\hskip\labelsep%
#1]\ignorespaces%
}{%
\popQED\endtrivlist\@endpefalse%
}
\renewcommand*{\tableofcontents}{
	\titleformat{\chapter}[hang]{\heiti\LARGE}
{}{0mm}{\hspace{-0.4cm}\mycont}
\chapter*{\contentsname}
\vspace*{50pt}
	\@starttoc{toc}
	\titleformat{\chapter}[hang]{\heiti\LARGE}
{}{0mm}{\hspace{-0.4cm}\mytitle}
}
\makeatother


%\renewcommand{\thefootnote}{\fnsymbol{footnote}}
%带圈脚注
% \RequirePackage{pifont}
% \RequirePackage[perpage,stable]{footmisc}  %每页脚注重新编号
% \renewcommand{\thefootnote}{\ding{\numexpr191+\value{footnote}}}
% % 脚注中的脚注序号不用上标，正文中的脚注号保持不变
% \makeatletter
% \def\my@makefnmark{\hbox{\normalfont\@thefnmark\space}}
% \let\my@save@makefntext\@makefntext
% \long\def\@makefntext#1{{%
%   \let\@makefnmark\my@makefnmark
%   \my@save@makefntext{#1}}}
% \makeatother

% Blocked theorem environment
\RequirePackage[framemethod=TikZ]{mdframed}
\newcommand{\getthecounter}[1]{\csname the#1\endcsname}
\newcommand{\newblocktheorem}[3][]{%
\ifstrempty{#1}%
{\newcounter{#2}\setcounter{#2}{0}%
}%
{\newcounter{#2}[#1]\setcounter{#2}{0}%
\expandafter\renewcommand\csname the#2\endcsname{\csname the#1\endcsname.\arabic{#2}}%
}
\newenvironment{#2}[1][]{%
\refstepcounter{#2}%
\ifstrempty{##1}%
{\mdfsetup{% with title
frametitle={%
\tikz[baseline=(current bounding box.east),outer sep=0pt]
\node[anchor=east,rectangle,fill=blue!20]
{\strut\heiti #3~\csname the#2\endcsname};}}
}%
{\mdfsetup{% without title
frametitle={%
\tikz[baseline=(current bounding box.east),outer sep=0pt]
\node[anchor=east,rectangle,fill=blue!20]
{\strut\heiti #3~\csname the#2\endcsname~(##1)};}}%
}%
\mdfsetup{innertopmargin=10pt,linecolor=blue!20,%
linewidth=2pt,topline=true,%
frametitleaboveskip=\dimexpr-\ht\strutbox\relax
}
\begin{mdframed}[]\relax\kaishu%
}{\end{mdframed}}
}
\RequirePackage{xcolor}
\RequirePackage{color}

\makeatletter
\ifdefstring{\INK@lang}{cn}{
\theoremstyle{theoremwithoutdot}
\newtheorem{example}{例}[chapter]
\newtheorem{question}{题}[section]
\newtheorem*{solution}{解}
\newblocktheorem[section]{theorem}{定理}
\newblocktheorem[section]{fancylemma}{引理} %
\newtheorem{lemma}{引理}[section]
\newblocktheorem[section]{proposition}{性质} %
\newblocktheorem[section]{corollary}{推论} %
\newblocktheorem[section]{law}{定律}
\newblocktheorem[section]{definition}{定义} %
\newblocktheorem[section]{conjecture}{猜想} %
\theoremstyle{remark} %
\newtheorem*{remark}{\normalfont\bfseries 评论} %
\newtheorem*{note}{\normalfont\bfseries 注} %
\newtheorem{case}{\normalfont\bfseries 案例} %
\renewcommand*{\proofname}{\normalfont\bfseries\color{black}证明} %
\renewcommand*{\contentsname}{目录}

}{\relax}


\ifdefstring{\INK@lang}{en}{
\theoremstyle{theoremwithoutdot}
\newtheorem{example}{Example}[chapter]
\newtheorem{question}{Question}[section]
\newtheorem*{solution}{Solution}
\newblocktheorem[section]{theorem}{Theorem}
\newblocktheorem[section]{fancylemma}{Lemma} %
\newtheorem{lemma}{Lemma}[section]
\newblocktheorem[section]{proposition}{Proposition} %
\newblocktheorem{corollary}{Corollary} %
\newblocktheorem{law}{Law} %
\newblocktheorem[section]{definition}{Definition} %
\newblocktheorem[section]{conjecture}{Conjecture} %
\theoremstyle{remark} %
\newtheorem*{remark}{\normalfont\bfseries Remark} %
\newtheorem*{note}{\normalfont\bfseries Note} %
\newtheorem{case}{\normalfont\bfseries Case} %
\renewcommand*{\proofname}{\normalfont\bfseries\color{black}Proof} %
\renewcommand*{\contentsname}{Contents} %
\renewcommand\bibname{Bibliography} %
}{\relax}
\makeatother

\RequirePackage{listings}
\lstset{
    frame           = lines, 
    basicstyle      = \footnotesize,
    keywordstyle    = \color{blue},
    stringstyle     = \color{green},
    commentstyle    = \color{red}\ttfamily
}

\allowdisplaybreaks[3]

%样式定义
\RequirePackage{titlesec}
\RequirePackage{xcolor,colortbl}
\RequirePackage{tgpagella}
\RequirePackage[T1]{fontenc}
\definecolor{covercolor}{RGB}{255,2,108}
\definecolor{partcolor}{RGB}{255,0,128}
\definecolor{titlecolor}{RGB}{129,129,188}
\definecolor{contentcolor}{RGB}{129,188,129}
\definecolor{backcolor}{RGB}{129,188,129}

\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace*{\fill}

\vspace{\fill}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\newtoks\equote
\newtoks\titheader
\renewcommand*{\maketitle}{
	\renewcommand{\and}{\quad}
	\let\footnotesize\small
	%\let\footnoterule\hrule\vspace{5pt}
	\let \footnote \thanks
	\thispagestyle{empty}
	\vspace*{50pt}
	\begin{flushright}
	{\heiti\large\the\titheader\par}
	\vspace*{50pt}
	\begin{tabular}{p{0.01\textwidth}p{0.98\textwidth}}
	\cellcolor{black} &\cellcolor{covercolor}\textcolor{white}
		\newline\heiti\LARGE \@title \par
	\end{tabular}
	
	\end{flushright}
	\vspace*{50pt}
	\begin{center}
		{\kaishu\Large \the\equote \par}
	\end{center}
	
	\begin{flushright}
		\vspace*{50pt}
	\hrule
	\vspace*{20pt}
	{\heiti\Large \@author \par}
	{\heiti\Large \@date \par}
	\end{flushright}
	
	\newpage
	\thispagestyle{empty}
	\@thanks
	\cleardoublepage
\global\let\thanks\relax
\global\let\maketitle\relax
\global\let\@thanks\@empty 
\global\let\@author\@empty
\global\let\@date\@empty
\global\let\@title\@empty
\global\let\title\relax
\global\let\author\relax
\global\let\date\relax
\global\let\and\relax
}

\makeatother

%在插图目录图编号前加上“图”
%\RequirePackage{titletoc}
%\titlecontents{figure}[0.5cm]{\songti}{\figurename~\thecontentslabel\quad}{\hspace*{-1.5cm}}{\titlerule*[0.12cm]{.}\contentspage}[\addvspace{6pt}]



\pagestyle{fancy}
\ifdefstring{\INK@lang}{cn}{
	\renewcommand{\chaptermark}[1]{\markboth{第\zhnumber{\thechapter}章\ \ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ \ \rm #1}{}}	%这两个命令第一次必须出现在\pagestyle{fancy}之后，否则\pagestyle{fancy}会覆盖掉其效果
}{\relax}
\ifdefstring{\INK@lang}{en}{
	\renewcommand{\chaptermark}[1]{\markboth{Chapter \arabic{\thechapter}\ \ #1}{}}
	\renewcommand{\sectionmark}[1]{\markright{\thesection\ \ \rm #1}{}}	%这两个命令第一次必须出现在\pagestyle{fancy}之后，否则\pagestyle{fancy}会覆盖掉其效果
}{\relax}

\markboth{\leftmark}{\rightmark}
\fancyhf{}
\fancyhead[CO]{\rightmark}
\fancyhead[LE,RO]{$\cdot$\, \thepage\, $\cdot$}
\fancyhead[CE]{\leftmark}

\newcommand{\aka}{\textsc{a.k.a.}}


\AtEndOfClass{
\renewcommand{\headrulewidth}{0.4pt}
\titleformat{\part}[hang]{\heiti\Huge}
{}{0mm}{\hspace{-0.4cm}\mypart}
 
\titleformat{\chapter}[hang]{\heiti\LARGE}
{}{0mm}{\hspace{-0.4cm}\mytitle}
 
\titleformat{\section}[hang]{\heiti\LARGE}
{}{0mm}{\hspace{-0.5cm}\mysection}

\titleformat{\subsection}[hang]{\heiti\large}
{}{0mm}{\hspace{-0.5cm}\mysubsection}

\titleformat{\subsubsection}[hang]{\heiti\large}
{}{0mm}{\hspace{-0.5cm}\mysubsubsection}
 
\titlespacing{\chapter}
{0pc}{1.5ex plus .1ex minus .2ex}{.2pc}
}

\let\oldAppendix\appendix
\newcommand{\inkAppendix}{%
\oldAppendix%  
\titleformat{\chapter}[hang]{\heiti\LARGE}{}{0mm}{\hspace{-0.4cm}\myappendix}%
\titleformat{\section}[hang]{\heiti\LARGE}{}{0mm}{\hspace{-0.5cm}\appendixsection}%
\titleformat{\subsection}[hang]{\heiti\large}{}{0mm}{\hspace{-0.5cm}\appendixsubsection}%
\titleformat{\subsubsection}[hang]{\heiti\large}{}{0mm}{\hspace{-0.5cm}\appendixsubsubsection}%
\renewcommand{\chaptermark}[1]{\markboth{附录\ \ ##1}{}}%
\renewcommand{\sectionmark}[1]{\markright{\thesection\ \ \rm ##1}{}}
\markboth{\leftmark}{\rightmark}%
\part{\appendixname}
}
\renewcommand{\appendix}{\inkAppendix}

\makeatletter
\let\oldlof\listoffigures
\newcommand{\inklof}{
	\titleformat{\chapter}[hang]{\heiti\LARGE}{}{0mm}{\hspace{-0.4cm}\mycont}
	\chapter*{插图目录}
	\vspace*{50pt}
	\@starttoc{lof}
}
\renewcommand{\listoffigures}{\inklof}
\makeatother