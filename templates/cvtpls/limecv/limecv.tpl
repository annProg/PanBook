\documentclass[a4paper]{limecv}
\usepackage[BoldFont,SlantFont]{xeCJK}
\usepackage{zhnumber}

% pandoc转换\begin \end时有问题，需要重定义命令
\newcommand{\hideFromPandoc}[1]{#1}
    \hideFromPandoc{
        \let\LimeCVCustomBegin\begin
        \let\LimeCVCustomEnd\end
    }

\hideFromPandoc

$if(font)$
\setCJKmainfont{$font$}
$else$
\setCJKmainfont{SimSun}
$endif$

\pgfkeys{/@cv/names/profile = 关于我}%
\pgfkeys{/@cv/names/contact = 联系我}%
\pgfkeys{/@cv/names/languages = 语言能力}%
\pgfkeys{/@cv/names/interests = 兴趣爱好}%
\pgfkeys{/@cv/names/professional = Professional}%
\pgfkeys{/@cv/names/personal = Personal}%
\pgfkeys{/@cv/names/projects = 主要经历}%
\pgfkeys{/@cv/names/education = 教育背景}%
\pgfkeys{/@cv/names/experience = 工作经验}%
\pgfkeys{/@cv/names/references = References}%
\pgfkeys{/@cv/names/skills = IT技能}%
\pgfkeys{/@cv/names/publications = 出版作品}%

% Defaults used in template design.
\usepackage[margin=\cvMargin,noheadfoot]{geometry}

$if(author)$
\newcommand\authorname{$author$}
$else$
\newcommand\authorname{姓名}
$endif$

$if(title)$
\newcommand\titlename{$title$}
$else$
\newcommand\titlename{职位}
$endif$

$if(photo)$
\newcommand\photo{photo}
$else$
\newcommand\photo{}
$endif$

\begin{document}

% Design of side bar.
\begin{cvSidebar}
\cvID{\authorname}{}{\photo}{\titlename}
$if(quote)$
\begin{cvProfile}
$quote$
\end{cvProfile}
$endif$ 
\begin{cvContact}
$if(email)$
\cvContactEmail{mailto:$email$}{$email$}
$endif$

$if(mobile)$
\cvContactPhone{$mobile$}
$endif$

$if(homepage)$
\cvContactWebsite{$homepage$}{$homepage$}
$endif$

$if(github)$
\cvContactGithub{https://github.com/$github$}{$github$}
$endif$
\end{cvContact}

$body$

\end{cvMainContent}
\end{document}