#!/bin/bash
cwd=`pwd`
SCRIPTDIR=`cd $(dirname $0);pwd`
ofile=`echo $cwd |awk -F '/' '{print $NF}'`
DEBUG="false"
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
	chapters=`ls *.md 2>/dev/null`
	[ "$DEBUG"x = "true"x ] && highlightStyle=(pygments)
}

function pdf()
{
	for theme in ${highlightStyle[@]}
	do
		source $SCRIPTDIR/config.default		
		[ -f $cwd/config ] && source $cwd/config
		# 复制模板目录的资源文件到build目录
		TPLDIR=`echo $PDF_OPTIONS |tr ' ' '\n'|grep "template"|cut -f2 -d'=' |awk -F'/' '{$NF="";print}'|tr ' ' '/'`
		cp -rf $TPLDIR/* $BUILD
		# 复制src目录下资源文件到build目录
		cp -rf $WORKDIR/* $BUILD
		
		TEX_OUTPUT="$BUILD/$ofile.$theme.tex"
		pandoc $chapters -o $TEX_OUTPUT $PDF_OPTIONS
		
		#sed -i 's/\DefineVerbatimEnvironment{Highlighting}.*/\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\\\\{\\},fontsize=\\small,xleftmargin=3mm,frame=lines}/g' $TEX_OUTPUT
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/caption=(.*)?,\s*label=(.*)\]/caption=\1, label=\2, float=htbp\]/" $TEX_OUTPUT
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/\[label=(.*)?\]/\[label=\1, caption=\1, float=htbp\]/" $TEX_OUTPUT
		#sed -i -E "s/begin\{lstlisting\}$/begin\{lstlisting\}\[float=htbp\]/g" $TEX_OUTPUT
		#sed -i "s/\.jpg/\.eps/g" $TEX_OUTPUT
		
		cd $BUILD
		xelatex -output-directory=$BUILD $TEX_OUTPUT #1&>/dev/null
		xelatex -output-directory=$BUILD $TEX_OUTPUT #1&>/dev/null
	done
}

function pdf2jpg()
{
	for id in $chapters;do
		cp $id $id.tmp
		sed -i -r 's/(!\[.*?\]\(.*?)(\.pdf\))/\1.jpg)/g' $id.tmp
	done
}

function html()
{	
	pdf2jpg # html中使用jpg图片，因此需要为pdf格式的插图准备同名jpg
	tmp_chapters=`ls *.md.tmp`
	for theme in ${highlightStyle[@]}
	do
		source $SCRIPTDIR/config.default
		[ -f $cwd/config ] && source $cwd/config
	
		HTML_OUTPUT="$BUILD/$ofile.$theme.html"
		pandoc --self-contained $tmp_chapters -o $HTML_OUTPUT $HTML_OPTIONS
		#sed -i "s/pdf/jpg/g" $HTML_OUTPUT
	done
	
	for id in $tmp_chapters;do
		rm -f $id;
	done
}

function epub()
{
	pdf2jpg
	tmp_chapters=`ls *.md.tmp`
	
	source $SCRIPTDIR/config.default
	[ -f $cwd/config ] && source $cwd/config

	EPUB_OUTPUT="$BUILD/$ofile.epub"
	pandoc $EPUB_OPTIONS $tmp_chapters  -o $EPUB_OUTPUT
	
	for id in $tmp_chapters;do
		rm -f $id;
	done	
}
function clean()
{
	cd $BUILD
	rm -fr *
}

case $# in
	0) init;html;pdf;;
	1) init;eval `echo $1`;;
	2) [ "$2"x = "d"x ] && DEBUG="true";init;eval `echo $1`;;
	*) init;html;pdf;;
esac
