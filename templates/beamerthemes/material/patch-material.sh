#!/bin/bash

getVar COLORTHEME "Dark"
getVar PRIMARY "Red"
getVar ACCENT "Green"
echo "\use${COLORTHEME}Theme" > material-theme.tex
echo "\usePrimary$PRIMARY" >> material-theme.tex
echo "\useAccent$ACCENT" >> material-theme.tex
addOptions="-H material-theme.tex"