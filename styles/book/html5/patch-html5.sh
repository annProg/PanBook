#!/bin/bash
_P[to]="html5+smart"
_G[t]="html"

getArrayVar _P template "html5.tpl"
unset _P[pdf-engine]
unset _P[listings]
pdf2jpg