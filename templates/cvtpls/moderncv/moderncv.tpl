\documentclass[$if(fontsize)$$fontsize$$else$11pt$endif$,$if(size)$$size$$else$a4paper$endif$,$if(fontfamily)$$fontfamily$$else$sans$endif$]{moderncv} % Font sizes: 10, 11, or 12; paper sizes: a4paper, letterpaper, a5paper, legalpaper, executivepaper or landscape; font families: sans or roman

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

\usepackage{fontspec}
\usepackage{xunicode}
\usepackage[BoldFont,SlantFont]{xeCJK}
\usepackage{zhnumber}
\usepackage{fancyhdr}
\pagestyle{fancy}


$if(onlinecv)$
\fancyfoot[L]{\fontsize{8}{10} \selectfont 更新地址：$onlinecv$}
$endif$                                                       
\fancyfoot[R]{\fontsize{8}{10} \selectfont 编译日期：\zhtoday}

$if(font)$
\setCJKmainfont{$font$}
$else$
\setCJKmainfont{SimSun}
$endif$


\usepackage[top=2cm,bottom=2cm,left=2cm,right=2cm]{geometry} % Reduce document margins
\setlength{\hintscolumnwidth}{3cm} % Uncomment to change the width of the dates column
%\setlength{\makecvtitlenamewidth}{10cm} % For the 'classic' style, uncomment to adjust the width of the space allocated to your name

%----------------------------------------------------------------------------------------
%   NAME AND CONTACT INFORMATION SECTION
%----------------------------------------------------------------------------------------
$if(author)$
\name{$author$}{}
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

$if(email)$
\email{$email$}
$endif$

$if(homepage)$
\homepage{$homepage$}
$endif$

$if(github)$
\social[github]{$github$}
$endif$

%\address{首都师范大学}{海淀区, 北京市 100048}
%\extrainfo{additional information}

$if(photo)$
\photo[55pt][0pt]{photo} % The first bracket is the picture height, the second is the thickness of the frame around the picture (0pt for no frame)
$endif$

$if(quote)$
\quote{$quote$}
$endif$

%----------------------------------------------------------------------------------------

\begin{document}

\makecvtitle % Print the CV title

$body$

\end{document}