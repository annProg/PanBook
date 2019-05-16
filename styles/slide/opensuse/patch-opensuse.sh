#!/bin/bash

# fix opensuse theme for newcommand

FIX="fix-opensuse.tex"
note "use -E authortitle=string to define your title"
note "use -E organization=string to define your organization"
note "use -E event=string to define event"
note "use -E location=string to define location"

getVar authortitle "软件工程师"
getVar organization "盘书-PanBook"
getVar event "\LaTeX交流"
getVar location "北京"

cat > $FIX <<EOF
\usepackage{tikz}
\usetikzlibrary{shapes.geometric}
\newcommand{\authortitle}{$authortitle}
\newcommand{\organization}{$organization}
\newcommand{\event}{$event}
\newcommand{\location}{$location}
EOF

(cat $FIX;echo) >> $HEADERS