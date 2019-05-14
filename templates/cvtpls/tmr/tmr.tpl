%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TMR Main File: resume.tex
% Author: Marina Rose "Mars" Geldard
% http://github.com/TheMartianLife/Resume

% Available for others' use under:
% The MIT License (https://opensource.org/licenses/MIT)

% Last Updated: 20/09/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
\documentclass{TMR}

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
$if(listings)$
\usepackage{listings}
\newcommand{\passthrough}[1]{#1}
\lstset{defaultdialect=[5.3]Lua}
\lstset{defaultdialect=[x86masm]Assembler}
$endif$
$if(CJKmainfont)$
\usepackage{xeCJK}
\setCJKmainfont[$for(CJKoptions)$$CJKoptions$$sep$,$endfor$]{$CJKmainfont$}
$endif$

% Author details
$if(name)$
\name[]{$name$}[]
$else$
\name[Dr]{Author Name}[JP.]% Pre- and post-nominals optional
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
%
%% Toggle how many values in footer
%\fullfooter

\begin{document}
%\begin{coverletter}
%coverletter here
%\end{coverletter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{resume}
Test
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