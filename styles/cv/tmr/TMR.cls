%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TMR Class File
% Author: Marina Rose "Mars" Geldard
% http://github.com/TheMartianLife/Resume

% Available for others' use under:
% 

% Last Updated: 04/05/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Class identification & inheritance
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TMR}[2018/05/03 v2 TheMartianResume Package]

% Paper dimensions
\LoadClass[11pt, a4paper]{article}
\RequirePackage[left=1in, top=0.7in, right=1in, bottom=1in]{geometry}

% Gain functionality from third party packages
\RequirePackage{fancyhdr}
\RequirePackage{parskip}
\RequirePackage{pdfpages}
\RequirePackage{fontawesome5}
\RequirePackage{import}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{environ}
\RequirePackage{xparse}
\RequirePackage[explicit]{titlesec}

% Set up document to start
\renewcommand{\headrulewidth}{0pt}


% Get details from author input
\newcommand{\fullname}[1]{\def\@fullname{#1}}
\newcommand{\documenttitle}[1]{\def\@documenttitle{#1}}
\newcommand{\address}[1]{\def\@address{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}
\newcommand{\email}[1]{\def\@email{#1}}

\newcommand{\homepage}[1]{\def\@homepage{#1}}
\newcommand{\github}[1]{\def\@github{#1}}
\newcommand{\linkedin}[1]{\def\@linkedin{#1}}
\newcommand{\twitter}[1]{\def\@twitter{#1}}
\newcommand{\flickr}[1]{\def\@flickr{#1}}
\newcommand{\instagram}[1]{\def\@instagram{#1}}
\newcommand{\wechat}[1]{\def\@wechat{#1}}

\newcommand{\greeting}[1]{\def\@greeting{#1}}
\newcommand{\farewell}[1]{\def\@farewell{#1}}
\newcommand{\recipient}[2]{\def\@recipientname{#1}\def\@recipientaddress{#2}}

\NewDocumentCommand{\name}{o m o}{%
	\def\@name{#2}
	\IfNoValueTF{#1}
	{\IfNoValueTF{#3}{\fullname{\@name}}{\fullname{\@name,~#3}}}
	{\IfNoValueTF{#3}{\fullname{#1~\@name}}{\fullname{#1~\@name,~#3}}}
}

% Define styles for text
\setlength{\parskip}{0.8em}
\newcommand{\pipe}{\ifhmode\hspace{1em}\fi}
\newcommand{\foottext}[1]{\textsc{\footnotesize#1}}
\renewcommand{\baselinestretch}{1.2}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE HIGH-LEVEL DOCUMENT ENVIRONMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Command to hide coverletter in PDF ouput
\newif\ifcoverletter
\coverlettertrue

\newcommand{\hidecoverletter}{
	\coverletterfalse
}

% Runs pre- & post-commands for coverletter doc
\NewEnviron{coverletter}{
	\ifcoverletter
		% Construct topmatter
		\tmrheader
		\hrulefill
		\tmrtitle
		\thispagestyle{empty}
		
		\BODY
		
		% Construct bottom matter
		\tmrclosing
	\fi
}


% Runs pre- & post-commands for resume doc
\newenvironment{resume}{
	\clearpage
	\setcounter{page}{1}
	\pagestyle{fancy}
	
	% Construct top & bottom matter
	\tmrheader
	\tmrfooter
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE LOWER-LEVEL TOP & BOTTOM MATTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Makes page header from details
\newcommand{\tmrheader}{
	\begin{center}
	
	% Author name
	{\Huge\textbf{\@name}\\}
	
	% Address & phone number
	\textit{\faicon{map-marker}
	\@address\quad\faicon{mobile} \@phone}\\
	
	% Social/online accounts
	{\small
		\mbox{\faEnvelope~\href{mailto:\@email}{\@email}}
		\ifdefined\@homepage\mbox{\pipe\faHome~\href{http://\@homepage}{\@homepage}}\fi
		\ifdefined\@github\mbox{\pipe\faGithubSquare~\href{https://github.com/\@github}{\@github}}\fi%
		\ifdefined\@linkedin\mbox{\pipe\faLinkedinSquare~\href{https://www.linkedin.com/in/\@linkedin}{\@linkedin}}\fi
		\ifdefined\@twitter\mbox{\pipe\faTwitterSquare~\href{https://twitter.com/\@twitter}{\@twitter}}\fi
		\ifdefined\@instagram\mbox{\pipe\faInstagram~\href{https://www.instagram.com/\@instagram}{\@twitter}}\fi
		\ifdefined\@flickr\mbox{\pipe\faFlickr~\href{https://www.flickr.com/photos/\@flickr}{\@flickr}}\fi
		\ifdefined\@wechat\mbox{\pipe\faWechat~\@wechat}\fi
	}	
	\end{center}
}


% Makes page footer
\newif\iffullfooter

\newcommand{\fullfooter}{
	\fullfootertrue
}

\newcommand{\tmrfooter}{
	
	% Empty header fields
	\fancyhead{}
	
	\iffullfooter
		% Set left field to today's date
		\lfoot{\foottext{\today}}
			
		% Set middle field to name, document type
		\cfoot{\foottext{\@fullname~\textbar~R\'esum\'e}}	
		
		% Set right field to page number
		\rfoot{\foottext{\thepage}}	
	\fi
}


% Makes recipient section from details & dates letter
\newcommand{\tmrtitle}{ 
	
    \textbf{\@recipientname}\hfill\textit{\today}\\
  	\@recipientaddress \\\\\\
	\@greeting,
}


% Signs off letter
\newcommand{\tmrclosing}{
	\vspace{10mm}\filbreak
	\@farewell, \\\\ \textbf{\@fullname} \\\\
	\textit{Attached: R\'esum\'e	}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE LOWER-LEVEL DOCUMENT COMPONENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove section numbers
\renewcommand{\@seccntformat}[1]{}
\renewcommand{\@seccntformat}[2]{}

% Style headings
\titleformat{\section}{\Large\bfseries}{}{0pt}{#1\hrulefill}
\titleformat{\subsection}{\filbreak\small\scshape}{}{0pt}{#1}

% Change spacing around headings
\titlespacing*{\section}{0pt}{4pt}{0pt}
\titlespacing*{\subsection}{0pt}{0pt}{0pt}

% 4-field double row entries
\newcommand{\entry}[4]{\filbreak\normalsize\textbf{#1}\hfill#3\\\textit{#2}\hfill\textit{#4}\small}

% Single row entries
\NewDocumentCommand{\row}{m o m m}{%
  \par\filbreak\parbox{0.06\textwidth}{\raggedright#1}%
  \parbox{0.71\textwidth}{~~\IfNoValueF{#2}{\textbf{\foottext#2}~}#3}%
  \parbox{0.23\textwidth}{~~\raggedleft\textit{#4}}\par%
}

% Fake bulletpoint
\newcommand{\point}[1]{$\bullet$~~\parbox[t]{0.98\textwidth}{\raggedright#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REDACT PRIVATE INFORMATION IF PUBLIC VERSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifpublicversion

\newcommand{\public}{
	\publicversiontrue
}

\newcommand{\private}[1]{
	\ifpublicversion[redacted]\else#1\fi
}

\newcommand{\reference}[1]{
	\ifpublicversion\else\includepdf[pages=-]{#1}\fi
}
