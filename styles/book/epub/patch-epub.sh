#!/bin/bash
_P[to]="epub3+smart"
_G[t]="epub"

getArrayVar _P template "epub.tpl"
getArrayVar _P css "css/epub.css"
unset _P[pdf-engine]
unset _P[listings]
pdf2jpg