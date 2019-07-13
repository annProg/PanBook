% start of file `thesis.cls'.
% This work is part of PanBook (https://github.com/annProg/PanBook)

% % !Mode:: "TeX:UTF-8"
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2019/07/13 PanBook default thesis class]

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{setkeys=\kvsetkeys}

% ----- Options -----
\DeclareStringOption[bachelor]{degree}
\DeclareVoidOption{bachelor}{\kvsetkeys{degree=bachelor}}
\DeclareVoidOption{master}{\kvsetkeys{degree=master}}
\DeclareVoidOption{phd}{\kvsetkeys{degree=phd}}
% ----- Default Options -----
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*\relax

\LoadClass{ctexbook}

%\RequirePackage{indentfirst}
%\setlength\parindent{2em}

\RequirePackage{graphicx}
\graphicspath{ {figure/} }
\RequirePackage[a4paper,width=150mm,top=25mm,bottom=25mm]{geometry}
\RequirePackage{fancyhdr}
\pagestyle{fancy}

\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\esubtitle}[1]{\def\@esubtitle{#1}}
\newcommand{\xuehao}[1]{\def\@xuehao{#1}}
\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\college}[1]{\def\@college{#1}}
\newcommand{\etitle}[1]{\def\@etitle{#1}}
%\newcommand{\xuehao}[1]{\def\@xuehao{#1}}


% abstract
\newenvironment*{abstract}[2]{
	%\parindent{2em}
    \def\invalue{#1}
    \def\english{e}
    \def\keywords{#2}
    % 论文题目
    \begin{center}
        \ifx\invalue\english
        	{\Large \bfseries \@etitle} \\
        	\vspace{1.5em}
            {\LARGE \bfseries Abstract} \\
			\addcontentsline{toc}{chapter}{Abstract}
        \else
		    {\Large \bfseries \@title} \\
        	\vspace{1.5em}
            {\LARGE \bfseries 摘~~~~要} \\
			\addcontentsline{toc}{chapter}{摘要}
        \fi
        \vspace{0.5em}
    \end{center}
}{
	\par
	\vspace{1cm}
	\noindent
	\ifx\invalue\english
		{\bfseries Key Words: }
	\else
		{\bfseries 关键词： }
	\fi
	\keywords
	\cleardoublepage
}

\newcommand{\makecoverbachelor}{
\begin{titlepage}
   \cleardoublepage
   \thispagestyle{empty}
   \begin{center}
       \vspace*{1cm}\par
       {\Huge\bfseries \@title}\par
       \vspace{0.5cm}
       {\LARGE \@subtitle }\par
       \includegraphics[width=0.4\textwidth]{logo}\par
       \vspace{1.5cm}
       \vspace{1cm}
       {\LARGE \bfseries 本科毕业设计（论文）}\par
       \vspace{0.8cm}
	   \large
	   \begin{tabular}[h]{rc}
       \textbf{姓~~~~~名：} & \@author\\
	   \textbf{学~~~~~号：} & \@xuehao\\
	   \textbf{指导老师：} & \@supervisor\\
	   \textbf{学~~~~~院：} & \@college
	   \end{tabular}
	   \vfill
       \@date
   \end{center}
\end{titlepage}
\addcontentsline{toc}{chapter}{封面}
}

\newcommand{\makecovermaster}{
\begin{titlepage}
   \cleardoublepage
   \thispagestyle{empty}
   \begin{center}
       \vspace*{1cm}\par
       {\Huge\bfseries \@title}\par
       \vspace{0.5cm}
       {\LARGE \@subtitle }\par
       \includegraphics[width=0.4\textwidth]{logo}\par
       \vspace{1.5cm}
       \vspace{1cm}
       {\LARGE \bfseries 硕士学位论文}\par
       \vspace{0.8cm}
	   \large
	   \begin{tabular}[h]{rc}
       \textbf{姓~~~~~名：} & \@author\\
	   \textbf{学~~~~~号：} & \@xuehao\\
	   \textbf{指导老师：} & \@supervisor\\
	   \textbf{学~~~~~院：} & \@college
	   \end{tabular}
	   \vfill
       \@date
   \end{center}
\end{titlepage}
\addcontentsline{toc}{chapter}{封面}
}

\newcommand{\makecoverphd}{
\begin{titlepage}
   \cleardoublepage
   \thispagestyle{empty}
   \begin{center}
       \vspace*{1cm}\par
       {\Huge\bfseries \@title}\par
       \vspace{0.5cm}
       {\LARGE \@subtitle }\par
       \includegraphics[width=0.4\textwidth]{logo}\par
       \vspace{1.5cm}
       \vspace{1cm}
       {\LARGE \bfseries 博士学位论文}\par
       \vspace{0.8cm}
	   \large
	   \begin{tabular}[h]{rc}
       \textbf{姓~~~~~名：} & \@author\\
	   \textbf{学~~~~~号：} & \@xuehao\\
	   \textbf{指导老师：} & \@supervisor\\
	   \textbf{学~~~~~院：} & \@college
	   \end{tabular}
	   \vfill
       \@date
   \end{center}
\end{titlepage}
\addcontentsline{toc}{chapter}{封面}
}

{\renewcommand*{\maketitle}{\makecoverbachelor}
\ifdefstring{degree}{master}{\renewcommand*{\maketitle}{\makecovermaster}}
\ifdefstring{degree}{phd}{\renewcommand*{\maketitle}{\makecoverphd}}

