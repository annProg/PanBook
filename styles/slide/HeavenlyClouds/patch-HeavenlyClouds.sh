#!/bin/bash
uname -s |grep "_NT" &>/dev/null && os=windows || os=""

if [ "$os"x == "windows"x ];then
	(cat fix-heavenlyclouds.tex;echo) >> ${_G[header]}
else
	(cat fix-heavenlyclouds.tex |sed 's/LiSu/FandolHei/g';echo) >> ${_G[header]}
fi