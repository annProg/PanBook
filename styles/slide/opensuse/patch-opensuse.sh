#!/bin/bash

# fix opensuse theme for newcommand

FIX="fix-opensuse.tex"
note "use -V authortitle=string to define your title"
note "use -V organization=string to define your organization"
note "use -V event=string to define event"
note "use -V location=string to define location"

getArrayVar _V authortitle "软件工程师"
getArrayVar _V organization "盘书-PanBook"
getArrayVar _V event "\LaTeX交流"
getArrayVar _V location "北京"

cat > $FIX <<EOF
\usepackage{tikz}
\usetikzlibrary{shapes.geometric}
\newcommand{\authortitle}{$authortitle}
\newcommand{\organization}{$organization}
\newcommand{\event}{$event}
\newcommand{\location}{$location}
EOF

(cat $FIX;echo) >> ${_G[header]}