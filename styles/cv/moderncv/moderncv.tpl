\documentclass[$if(fontsize)$$fontsize$$else$11pt$endif$,$if(size)$$size$$else$a4paper$endif$,$if(fontfamily)$$fontfamily$$else$sans$endif$]{moderncv} % Font sizes: 10, 11, or 12; paper sizes: a4paper, letterpaper, a5paper, legalpaper, executivepaper or landscape; font families: sans or roman
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

$if(style)$
\moderncvstyle{$style$} % CV theme - options include: 'casual' (default), 'classic', 'oldstyle' and 'banking'
$else$
\moderncvstyle{classic}
$endif$

$if(color)$
\moderncvcolor{$color$} % CV color - options include: 'blue' (default), 'orange', 'green', 'red', 'purple', 'grey' and 'black'
$else$
\moderncvcolor{blue}
$endif$

\usepackage{indentfirst}
\usepackage{fontspec}
\usepackage{xunicode}
\usepackage{zhnumber}
\usepackage{fancyhdr}
\pagestyle{fancy}

$if(listings)$
\usepackage{listings}
\newcommand{\passthrough}[1]{#1}
\lstset{defaultdialect=[5.3]Lua}
\lstset{defaultdialect=[x86masm]Assembler}
$endif$

$if(highlighting-macros)$
$highlighting-macros$
$endif$

$if(tables)$
\usepackage{longtable,booktabs}
$endif$

$if(onlinecv)$
\fancyfoot[L]{$if(vspace)$\vspace{$vspace$}$endif$\fontsize{8}{10} \selectfont $onlinecv$}
$endif$
$if(showdate)$                                                       
\fancyfoot[R]{$if(vspace)$\vspace{$vspace$}$endif$\fontsize{8}{10} \selectfont \zhtoday}
$endif$

$if(mainfont)$
  \setmainfont[$for(mainfontoptions)$$mainfontoptions$$sep$,$endfor$]{$mainfont$}
$endif$

$if(sansfont)$
  \setsansfont[$for(sansfontoptions)$$sansfontoptions$$sep$,$endfor$]{$sansfont$}
$endif$
$if(monofont)$
  \setmonofont[$for(monofontoptions)$$monofontoptions$$sep$,$endfor$]{$monofont$}
$endif$

\usepackage{xeCJK}
$if(CJKmainfont)$
\setCJKmainfont[$for(CJKoptions)$$CJKoptions$$sep$,$endfor$]{$CJKmainfont$}
$endif$

$if(geometry)$
\usepackage[$for(geometry)$$geometry$$sep$,$endfor$]{geometry} % Reduce document margins
$else$
\usepackage[top=2cm,bottom=2cm,left=2cm,right=2cm]{geometry} % Reduce document margins
$endif$

$if(datewidth)$
\setlength{\hintscolumnwidth}{$datewidth$}
$else$
\setlength{\hintscolumnwidth}{3cm} % Uncomment to change the width of the dates column
$endif$
%\setlength{\makecvtitlenamewidth}{10cm} % For the 'classic' style, uncomment to adjust the width of the space allocated to your name

%----------------------------------------------------------------------------------------
%   NAME AND CONTACT INFORMATION SECTION
%----------------------------------------------------------------------------------------
$if(name)$
\name{$name$}{}
$else$
\name{名}{姓}
$endif$
% All information in this block is optional, comment out any lines you don't need
$if(title)$
\title{$title$}
$endif$

$if(mobile)$
\phone[mobile]{$mobile$}
$endif$

$if(fixed)$
\phone[fixed]{$fixed$}
$endif$

$if(email)$
\email{$email$}
$endif$

$if(homepage)$
\homepage{$homepage$}
$endif$

$if(github)$
\social[github]{$github$}
$endif$

$if(linkedin)$
\social[linkedin]{$linkedin$}
$endif$

$if(twitter)$
\social[twitter]{$twitter$}
$endif$

$if(born)$
\born{$born$}
$endif$

\usepackage{fontawesome5}
\newcommand*\weibosocialsymbol{{\small\faWeibo~}}
\newcommand*\wechatsocialsymbol{{\small\faWeixin~}}
\newcommand*\qqsocialsymbol{{\small\faQq~}}
\newcommand*\skypesocialsymbol{{\small\faSkype~}}

% makes a http hyperlink
% usage: \httplink[optional text]{link}
% 考虑一般情况下link为空更常见，所以改为判断#2是否为nolink
% 要兼容homepage，改为多次判断
\renewcommand*{\httplink}[2][]{
	\ifthenelse{\equal{#1}{}}
	{\href{http://#2}{#2}}
	{
		\ifthenelse{\equal{#2}{nolink}}
		{#1}
		{\href{http://#2}{#1}}
	}
}

$if(weibo)$
\social[weibo][weibo.com/$weibo$]{$weibo$}
$endif$

$if(wechat)$
\social[wechat][nolink]{$wechat$}
$endif$

$if(qq)$
\social[qq][nolink]{$qq$}
$endif$

$if(skype)$
\social[skype][nolink]{$skype$}
$endif$

$if(address)$
\address{$address$}{}
$endif$

$if(extrainfo)$
\extrainfo{$extrainfo$}
$endif$

$if(photo)$
\photo[$if(photoheight)$$photoheight$pt$else$55pt$endif$][$if(photoframe)$$photoframe$pt$else$1pt$endif$]{$photo$} % The first bracket is the picture height, the second is the thickness of the frame around the picture (0pt for no frame)
$endif$

$if(quote)$
\quote{$quote$}
$endif$

%----------------------------------------------------------------------------------------
$for(header-includes)$
$header-includes$
$endfor$

$if(csl-refs)$
\newlength{\cslhangindent}
\setlength{\cslhangindent}{1.5em}
\newlength{\csllabelwidth}
\setlength{\csllabelwidth}{3em}
\newenvironment{CSLReferences}[2] % #1 hanging-ident, #2 entry spacing
 {% don't indent paragraphs
  \setlength{\parindent}{0pt}
  % turn on hanging indent if param 1 is 1
  \ifodd #1 \everypar{\setlength{\hangindent}{\cslhangindent}}\ignorespaces\fi
  % set entry spacing
  \ifnum #2 > 0
  \setlength{\parskip}{#2\baselineskip}
  \fi
 }%
 {}
\usepackage{calc}
\newcommand{\CSLBlock}[1]{#1\hfill\break}
\newcommand{\CSLLeftMargin}[1]{\parbox[t]{\csllabelwidth}{#1}}
\newcommand{\CSLRightInline}[1]{\parbox[t]{\linewidth - \csllabelwidth}{#1}\break}
\newcommand{\CSLIndent}[1]{\hspace{\cslhangindent}#1}
$endif$

\begin{document}

\makecvtitle % Print the CV title

$body$

\end{document}