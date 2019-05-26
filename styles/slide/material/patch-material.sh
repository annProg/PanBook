#!/bin/bash
note "use -V color:(Dark|Light) to change colortheme"
note "use -V primary:colorname"
note "use -V accent:colorname"
note "availableColor: Red|Pink|Purple|Deep Purple|Indigo|Blue|Light Blue|Cyan|Teal|Green|Light Green|Lime|Yellow|Amber|Orange|Deep Orange|Brown|Grey|Blue Grey"
getArrayVar _V color "Dark"
getArrayVar _V primary "Red"
getArrayVar _V accent "Green"
echo "\use${_V[color]}Theme" > material-theme.tex
echo "\usePrimary${_V[primary]}" >> material-theme.tex
echo "\useAccent${_V[accent]}" >> material-theme.tex


(cat material-theme.tex;echo) >> ${_G[header]}