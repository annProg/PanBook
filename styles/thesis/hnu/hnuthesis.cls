% hnuthesis 基于 https://github.com/LASER-Yi/HNU-Thesis-LaTeX-Template/blob/master/hnuthesis.cls
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{hnuthesis}
[2019/5/15 0.0.1-a Hunan University Thesis Template]
\RequirePackage{ifxetex}
\ifxetex\else
    \ClassError{hnuthesis}{You need to use XeLaTeX}{}
    \end{document}
\fi
\hyphenation{Hnu-Thesis}
\def\hunthesis{HnuThesis}
\def\version{0.0.1-a}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=hnu,
    prefix=hnu@,
    setkeys=\kvsetkeys}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}
{ctexbook}}
\PassOptionsToPackage{quiet}{xeCJK}
\LoadClass[UTF8, a4paper, openany, zihao=-4, scheme=plain]{ctexbook}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{environ}
\RequirePackage{CJKfntef}
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage[sort&compress]{natbib}
\RequirePackage{hyperref}
\hypersetup{
  linktoc            = all,
  bookmarksnumbered  = true,
  bookmarksopen      = true,
  bookmarksopenlevel = 1,
  breaklinks         = true,
  plainpages         = false,
  hidelinks,
}
\RequirePackage{bookmark}
\RequirePackage{geometry}
\geometry{
    a4paper,
    hcentering,
    ignoreall,
    nomarginpar
}
\geometry{
    left=30mm,
    right=20mm,
    top=30mm,
    bottom=25mm
}
\RequirePackage{fancyhdr}
\RequirePackage{notoccite}

\newcommand\hnu@fontset{\csname g__ctex_fontset_tl\endcsname}
\ifthenelse{\equal{\hnu@fontset}{fandol}}{
  \setmainfont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{texgyretermes}
  \setsansfont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{texgyreheros}
  \setmonofont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Scale          = MatchLowercase,
  ]{texgyrecursor}
}{
  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \ifthenelse{\equal{\hnu@fontset}{mac}}{
    \setmonofont[Scale=MatchLowercase]{Menlo}
  }{
    \setmonofont[Scale=MatchLowercase]{Courier New}
  }
}
\unimathsetup{
  math-style = ISO,
  bold-style = ISO,
  nabla      = upright,
  partial    = upright,
}
\IfFontExistsTF{XITSMath-Regular.otf}{
  \setmathfont[
    Extension    = .otf,
    BoldFont     = XITSMath-Bold,
    StylisticSet = 8,
  ]{XITSMath-Regular}
  \setmathfont[range={cal,bfcal},StylisticSet=1]{XITSMath-Regular.otf}
}{
  \setmathfont[
    Extension    = .otf,
    BoldFont     = *bold,
    StylisticSet = 8,
  ]{xits-math}
  \setmathfont[range={cal,bfcal},StylisticSet=1]{xits-math.otf}
}
\ifthenelse{\equal{\hnu@fontset}{windows}}{
  \xeCJKsetup{EmboldenFactor=2}
  \IfFileExists{C:/bootfont.bin}{
    \setCJKmainfont[AutoFakeBold,ItalicFont=KaiTi_GB2312]{SimSun}
    \setCJKfamilyfont{zhkai}[AutoFakeBold]{KaiTi_GB2312}
  }{
    \setCJKmainfont[AutoFakeBold,ItalicFont=KaiTi]{SimSun}
    \setCJKfamilyfont{zhkai}[AutoFakeBold]{KaiTi}
  }
  \setCJKsansfont[AutoFakeBold]{SimHei}
  \setCJKfamilyfont{zhsong}[AutoFakeBold]{SimSun}
  \setCJKfamilyfont{zhhei}[AutoFakeBold]{SimHei}
}{}
\ifthenelse{\equal{\hnu@fontset}{mac}}{
  \setCJKmainfont[
         UprightFont = * Light,
            BoldFont = * Bold,
          ItalicFont = Kaiti SC,
      BoldItalicFont = Kaiti SC Bold,
    ]{Songti SC}
  \setCJKsansfont[BoldFont=* Medium]{Heiti SC}
  \setCJKfamilyfont{zhsong}[
         UprightFont = * Light,
            BoldFont = * Bold,
    ]{Songti SC}
  \setCJKfamilyfont{zhhei}[BoldFont=* Medium]{Heiti SC}
  \setCJKfamilyfont{zhkai}[BoldFont=* Bold]{Kaiti SC}
  \xeCJKsetwidth{‘’“”}{1em}
}{}

\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip=12bp \@plus 2bp \@minus 2bp
  \abovedisplayshortskip=12bp \@plus 2bp \@minus 2bp
  \belowdisplayskip=\abovedisplayskip
  \belowdisplayshortskip=\abovedisplayshortskip}
\def\hnu@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
\hnu@def@fontsize{chuhao}{42bp}
\hnu@def@fontsize{xiaochu}{36bp}
\hnu@def@fontsize{yihao}{26bp}
\hnu@def@fontsize{xiaoyi}{24bp}
\hnu@def@fontsize{erhao}{22bp}
\hnu@def@fontsize{xiaoer}{18bp}
\hnu@def@fontsize{sanhao}{16bp}
\hnu@def@fontsize{xiaosan}{15bp}
\hnu@def@fontsize{sihao}{14bp}
\hnu@def@fontsize{banxiaosi}{13bp}
\hnu@def@fontsize{xiaosi}{12bp}
\hnu@def@fontsize{dawu}{11bp}
\hnu@def@fontsize{wuhao}{10.5bp}
\hnu@def@fontsize{xiaowu}{9bp}
\hnu@def@fontsize{liuhao}{7.5bp}
\hnu@def@fontsize{xiaoliu}{6.5bp}
\hnu@def@fontsize{qihao}{5.5bp}
\hnu@def@fontsize{bahao}{5bp}

\ctexset{
    chapter/name    = {},
    appendixname    = 附录,
    contentsname    = {目\hspace{\ccwd}录},
    listfigurename  = 插图索引,
    listtablename   = 表格索引,
    figurename      = 图,
    tablename       = 表,
    bibname         = 参考文献,
    indexname       = 索引,
}
\newcommand\hnu@denotation@name{主要符号对照表}
\newcommand\listequationname{公式索引}
\newcommand\equationname{公式}
\newcommand\hnu@assumption@name{假设}
\newcommand\hnu@definition@name{定义}
\newcommand\hnu@proposition@name{命题}
\newcommand\hnu@lemma@name{引理}
\newcommand\hnu@theorem@name{定理}
\newcommand\hnu@axiom@name{公理}
\newcommand\hnu@corollary@name{推论}
\newcommand\hnu@exercise@name{练习}
\newcommand\hnu@example@name{例}
\newcommand\hnu@remark@name{注释}
\newcommand\hnu@problem@name{问题}
\newcommand\hnu@conjecture@name{猜想}
\newcommand\hnu@proof@name{证明}
\newcommand\hnu@theorem@separator{：}
\newcommand\hnu@ack@name{致\hspace{\ccwd}谢}

\fancypagestyle{hnu@empty}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{hnu@headings}{
    \fancyhead{}
    \setlength{\headheight}{32pt}
    \renewcommand{\headrulewidth}{1pt}
    \lhead{\includegraphics[width=1cm]{figures/hnu_black.png}}
    \chead{\sanhao\heiti 湖南大学毕业设计（论文）}
    \rhead{\wuhao\songti 第 \thepage 页}
}

\renewcommand\frontmatter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \pagestyle{hnu@empty}
}
\renewcommand\mainmatter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagestyle{hnu@headings}
  \setcounter{page}{1}
\setcounter{figure}{1}
\setcounter{table}{1}
}

\renewcommand\backmatter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
}

\ctexset{
    chapter={
        afterindent=true,
        pagestyle={hnu@headings},
        beforeskip={1em},
        aftername=\hskip\ccwd,
        afterskip={1em},
        format={\sffamily\sanhao\heiti},
    },
    section={
        afterindent=true,
        beforeskip={1em},
        afterskip={1em},
        format={\xiaosi\heiti},
    },
    subsection={
        afterindent=true,
        beforeskip={1em},
        afterskip={1em},
        format={\xiaosi\heiti},
    },
    subsubsection={
        afterindent=true,
        beforeskip={1em},
        afterskip={1em},
        format={\xiaosi\heiti},
    },
    paragraph={
        afterindent=true,
    },
    subparagraph={
        afterindent=true,
    },
}

\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{3}

\newcommand{\cabstractname}{摘\hspace{\ccwd}要}
\newcommand{\eabstractname}{Abstract}
\let\CJK@todaysave=\today
\def\CJK@todaysmall@short{\the\year 年 \the\month 月}
\def\CJK@todaysmall{\the\year 年 \the\month 月 \the\day 日}
\def\CJK@todaybig@short{\zhdigits{\the\year}年\zhnumber{\the\month}月}
\def\CJK@todaybig{\zhdigits{\the\year}年\zhnumber{\the\month}月\zhnumber{\the\day}日}
\def\CJK@today{\CJK@todaysmall}
\renewcommand\today{\CJK@today}
\newcommand\CJKtoday[1][1]{%
\ifcase#1\def\CJK@today{\CJK@todaysave}
  \or\def\CJK@today{\CJK@todaysmall}
  \or\def\CJK@today{\CJK@todaybig}
\fi}

\def\hnusetup{\kvsetkeys{hnu}}

\def\hnu@parse@keywords#1{
  \define@key{hnu}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname hnu@#1\endcsname{}
  \expandafter\gdef\csname #1\endcsname##1{
    \@for\reserved@a:=##1\do{
      \expandafter\ifx\csname hnu@#1\endcsname\@empty\else
        \expandafter\g@addto@macro\csname hnu@#1\endcsname{%
          \ignorespaces\csname hnu@#1@separator\endcsname}
      \fi
      \expandafter\expandafter\expandafter\g@addto@macro%
        \expandafter\csname hnu@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\hnu@parse@keywords{ckeywords}
\hnu@parse@keywords{ekeywords}

\def\hnu@def@term#1{%
  \define@key{hnu}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname hnu@#1\endcsname{##1}}
  \csname #1\endcsname{}}
\hnu@def@term{ctitle}
\hnu@def@term{etitle}
\hnu@def@term{cauthor}
\hnu@def@term{cnumber}
\hnu@def@term{cdepartment}
\hnu@def@term{cclassname}
\hnu@def@term{csupervisor}
\hnu@def@term{cheadmaster}
\hnu@def@term{cdate}

\AtBeginDocument{
  \pagestyle{hnu@empty}
}

\renewcommand{\tableofcontents}{
  \clearpage
  \begin{center}
    \sanhao\heiti{\contentsname}
  \end{center} 
  \wuhao\@starttoc{toc}\normalsize
}

\newenvironment{cabstract}{
  \begin{center}
    \heiti\xiaosan\
  \end{center}
}{}
\newenvironment{eabstract}{}{}