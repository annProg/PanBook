#!/bin/bash
cwd=`pwd`
SCRIPTDIR=`cd $(dirname $0);pwd`
ofile=$cwd"/"`echo $cwd |awk -F '/' '{print $NF}'`
DEBUG=false
BUILD="$cwd/build"
WORKDIR="$cwd/src"
IMGDIR="$WORKDIR/images"
highlightStyle=(pygments kate monochrome espresso haddock tango zenburn)

function init()
{
	[ ! -d $BUILD ] && mkdir $BUILD
	[ ! -d $WORKDIR ] && mkdir $WORKDIR
	[ ! -d $IMGDIR ] && mkdir $IMGDIR
	cd $WORKDIR
	chapters=`ls *.md`
	[ "$DEBUG"x = "true"x ] && highlightStyle=(pygments)
}

function pdf()
{
	for theme in ${highlightStyle[@]}
	do
		source $SCRIPTDIR/config.default
		[ -f $cwd/config ] && source $cwd/config
		pandoc $chapters -o $BUILD/$ofile.$theme.tex $PDF_OPTIONS
		
		sed -i 's/\DefineVerbatimEnvironment{Highlighting}.*/\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\\\\{\\},fontsize=\\small,xleftmargin=3mm,frame=lines}/g' $ofile.$theme.tex
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/label=(.*)]/label=\1, caption=\1, float=htbp\]/" $ofile.$theme.tex
		sed -i "s/\.jpg/\.eps/g" $ofile.$theme.tex
		
		xelatex $BUILD/$ofile.$theme.tex #1&>/dev/null
		xelatex $BUILD/$ofile.$theme.tex #1&>/dev/null
	done
}

function html()
{
	for id in ${pdf[*]}
	do
		filename=`echo $id |sed 's/\.pdf//g'`
		sed -i "s/$id/$filename.jpg/g" *.md
	done
	
	for theme in ${highlightStyle[@]}
	do
		pandoc --self-contained $chapters -o $BUILD/$ofile.$theme.html $HTML_OPTIONS
	done
	
	for id in ${pdf[*]}
	do
		filename=`echo $id |sed 's/\.pdf//g'`
		sed -i "s/$filename.jpg/$id/g" *.md
	done
}

function clean()
{
	cd ../
	for type in html pdf tex aux gz log out toc
	do
		rm -f *.$type
	done
}

# 初始化
init

case $# in
	0) html;pdf;;
	1) eval $1;;
	2) [ "$2"x = "d" ] && DEBUG=true;eval $1;;
	*) html;pdf;;
esac
