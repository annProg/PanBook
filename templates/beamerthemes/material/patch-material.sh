#!/bin/bash
note "use -E colortheme=(Dark|Light) to change colortheme"
note "use -E primary=colorname"
note "use -E accent=colorname"
note "availableColor: Red|Pink|Purple|Deep Purple|Indigo|Blue|Light Blue|Cyan|Teal|Green|Light Green|Lime|Yellow|Amber|Orange|Deep Orange|Brown|Grey|Blue Grey"
getVar colortheme "Dark"
getVar primary "Red"
getVar accent "Green"
echo "\use${colortheme}Theme" > material-theme.tex
echo "\usePrimary$primary" >> material-theme.tex
echo "\useAccent$accent" >> material-theme.tex

info "colortheme: $colortheme"
info "primary: $primary"
info "accent: $accent"
addOptions="-H material-theme.tex"