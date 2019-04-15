#!/bin/bash

getEnv COLORTHEME "Dark"
getEnv PRIMARY "Red"
getEnv ACCENT "Green"
echo "\use${COLORTHEME}Theme" > material-theme.tex
echo "\usePrimary$PRIMARY" >> material-theme.tex
echo "\useAccent$ACCENT" >> material-theme.tex
customHeader="-H material-theme.tex"