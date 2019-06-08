%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TMR Main File: resume.tex
% Author: Marina Rose "Mars" Geldard
% http://github.com/TheMartianLife/Resume

% Available for others' use under:
% The MIT License (https://opensource.org/licenses/MIT)

% Last Updated: 20/09/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
\documentclass{TMR}
\usepackage{zhnumber}
\makeatletter
\newcommand{\mytitle}[1]{\def\@mytitle{#1}}

\renewcommand{\tmrheader}{
	\begin{center}
	
	% Author name
	{\Huge\textbf{\@name} \ifdefined\@mytitle{~\textbar~\huge\textnormal{\@mytitle}}\fi\\}
	
	% Address & phone number
	\ifdefined\@address{
	\textit{\faIcon{map-marker}
	\@address\\}}\fi
	
	% Social/online accounts
	{\small
		\mbox{\faEnvelope~\href{mailto:\@email}{\@email}}
		\ifdefined\@phone\mbox{\pipe\faMobile~ \@phone}\fi
		\ifdefined\@homepage\mbox{\pipe\faHome~\href{http://\@homepage}{\@homepage}}\fi
		\ifdefined\@github\mbox{\pipe\faGithubSquare~\href{https://github.com/\@github}{\@github}}\fi%
		\ifdefined\@linkedin\mbox{\pipe\faLinkedin~\href{https://www.linkedin.com/in/\@linkedin}{\@linkedin}}\fi
		\ifdefined\@twitter\mbox{\pipe\faTwitterSquare~\href{https://twitter.com/\@twitter}{\@twitter}}\fi
		\ifdefined\@instagram\mbox{\pipe\faInstagram~\href{https://www.instagram.com/\@instagram}{\@twitter}}\fi
		\ifdefined\@flickr\mbox{\pipe\faFlickr~\href{https://www.flickr.com/photos/\@flickr}{\@flickr}}\fi
		\ifdefined\@wechat\mbox{\pipe\faWeixin~\@wechat}\fi
	}	
	\end{center}
}

\newcommand{\enclosure}[2][]{
	\def\@enclosurename{#1}
	\def\@enclosure{#2}
}
\renewcommand{\date}[1]{\def\@date{#1}}

% Makes recipient section from details & dates letter
\renewcommand{\tmrtitle}{ 
	
    \textbf{\@recipientname}\hfill\textit{\@date}\\
  	\@recipientaddress \\\\\\
	\@greeting
}

% Signs off letter
\renewcommand{\tmrclosing}{
	\vspace{10mm}\filbreak
	\@farewell \\\\ \textbf{\@name} \\\\
	\textit{\ifdefined\@enclosurename{\@enclosurename}\else{Attathed}\fi: \ifdefined\@enclosure{\@enclosure}\else{R\'esum\'e	}\fi }%
}

% 5-field double row entries
\renewcommand{\entry}[5]{\filbreak\normalsize\textbf{#1}\ \textit{#5}\hfill#3\\\textit{#2}\hfill\textit{#4}\small}

\renewcommand{\tmrfooter}{
	
	% Empty header fields
	\fancyhead{}
	
	\iffullfooter
		% Set left field to today's date
		\lfoot{\foottext{\zhtoday}}
			
		% Set middle field to name, document type
		\cfoot{\foottext{\@name~\textbar~\@mytitle}}	
		
		% Set right field to page number
		\rfoot{\foottext{\thepage}}	
	\fi
}

\makeatother

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
$if(listings)$
\usepackage{listings}
\newcommand{\passthrough}[1]{#1}
\lstset{defaultdialect=[5.3]Lua}
\lstset{defaultdialect=[x86masm]Assembler}
$endif$

\usepackage{xeCJK}
$if(CJKmainfont)$
\setCJKmainfont[$for(CJKoptions)$$CJKoptions$$sep$,$endfor$]{$CJKmainfont$}
$endif$

$for(header-includes)$
$header-includes$
$endfor$


% Author details
$if(name)$
\name[]{$name$}[]
$else$
\name[Dr]{Author Name}[JP.]% Pre- and post-nominals optional
$endif$

$if(title)$
\mytitle{$title$}
$endif$

$if(address)$
\address{$address$}
$endif$

$if(mobile)$
\phone{$mobile$} 
$endif$

$if(email)$
\email{$email$}
$endif$

$if(homepage)$
\homepage{$homepage$}
$endif$

$if(github)$
\github{$github$}
$endif$

$if(linkedin)$
\linkedin{$linkedin$}
$endif$

$if(twitter)$
\twitter{$twitter$}
$endif$

$if(wechat)$
\wechat{$wechat$}
$endif$

% Letter details
%\greeting{Your personal greeting}
%\farewell{Your customised farewell}
%\recipient
%	{Recipient Name}
%	{Recipient Street Address\\
%		And line 2\\
%		Suburb, State 0000}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% Letter details
%\recipient
%	{Recipient Name}
%	{Recipient Street Address\\
%		And line 2\\
%		Suburb, State 0000}
%\greeting{Your personal greeting}
%\farewell{Your customised farewell}
%
%% Toggle inclusion in output PDF
%%\hidecoverletter

% Toggle how many values in footer
\fullfooter

\begin{document}
%\begin{coverletter}
%coverletter here
%\end{coverletter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{resume}

$body$

%% Import any number of sections
%% This will dictate the order in which they display
%\import{sections/}{section-1.tex}
%
%\import{sections/}{section-2.tex}
%
%\import{sections/}{section-3.tex}
%
%\import{sections/}{section-4.tex}
%
%\import{sections/}{section-5.tex}
%
\end{resume}
\end{document}