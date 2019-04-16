#!/bin/bash

# use this path to set custom addOptions, PANDOCVARS and highLight

note "use -E device=(pc|mobile|kindel) to produce different size of pdf"
note "use -E cover=(1-60|R|N) to select cover page background. R means random. N means don't add cover image"
note "use -E coverimg=path to use custom titlepage"
note "use -E privatetpl=(true|false) to use custom template define by this class"
note "use -E pagestyle=style to set pagestyle"

FIX="header-ctexbook.tex"
TITLEPAGE="titlepage-ctexbook.tex"

setPandocVar "classoption" "fancyhdr,bookmark"
getVar "pagestyle" "fancy"
division="--top-level-division=chapter"
getVar privatetpl "true"

# ctex模板随机选用封面背景
getVar cover "29"
if [ "$cover"x == "R"x ];then
	background="images/$(($RANDOM%60)).png"
else
	background="images/$cover.png"
fi

if [ "$privatetpl"x == "true"x ];then
	addOptions="--template=ctexbook.tpl -V background=$background -V device=$device"
	highLight=""
else
	addOptions="$addOptions -H $FIX -H $TITLEPAGE"
fi

parseMeta

cat > $FIX <<EOF
\usepackage{wallpaper}
\usepackage{geometry}
\usepackage{fancyhdr}
\pagestyle{$pagestyle}
% 设备类型
\newcommand{\devicemobile}{
	\geometry{
		paperwidth=9.0cm,
		paperheight=16cm,
		margin=0.5cm,
		left=0.1cm,
		right=0.1cm,
		top=0.1cm,
		bottom=0.2cm
	}
}

\newcommand{\devicekindle}{
	\geometry{
		paperwidth=9.0cm,
		paperheight=11.7cm,
		margin=0.5cm,
		left=0.1cm,
		right=0.1cm,
		top=0.1cm,
		bottom=0.2cm
	}
}

\newcommand{\devicepc}{
	\geometry{
		top=1in,
		%inner=1in,
		%outer=1in,
		bottom=1in,
		headheight=3ex,
		headsep=2ex
	}
}

\device$device
% 优化不同设备封面显示
\newcommand{\titlepc}{\Huge}
\newcommand{\subtitlepc}{\Large}
\newcommand{\titlemobile}{\Large}
\newcommand{\subtitlemobile}{\large}
\newcommand{\titlekindle}{\Large}
\newcommand{\subtitlekindle}{\large}
\newcommand{\vspacepc}{\vspace{.00\textheight}}
\newcommand{\vspacemobile}{\vspace{.05\textheight}}
\newcommand{\vspacekindle}{\vspace{.05\textheight}}
EOF

cat > $TITLEPAGE <<EOF
\renewcommand*{\maketitle}{%
\begin{titlepage}
  \setkeys{Gin}{width=10pt,height=100pt}
  \thispagestyle{empty}
  \noindent\fboxsep=0pt
EOF

if [ "$coverimg"x != ""x ];then
cat >> $TITLEPAGE <<EOF
  \ThisTileWallPaper{\paperwidth}{\paperheight}{$coverimg}
EOF
else
cat >> $TITLEPAGE <<EOF
  \ThisTileWallPaper{\paperwidth}{\paperheight}{$background}
	\vspace{.18\textheight}
	\begin{center}
		{\title$device\bfseries Test\par}
	\vspace{1cm}
		{\subtitle$device Test\par}
	\vspace{2.5cm}
		Ann He
	\vfill\centering{使用 PanBook 编译 \par \today\par}
		\vspace$device
	\end{center}
EOF
fi

cat >> $TITLEPAGE <<EOF
\end{titlepage}
}
\setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}
EOF
