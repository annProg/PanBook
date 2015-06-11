#!/bin/bash
cd src
chapters=`ls *.md`
ofile="sina-rd-im-doc"

pdf=(
modip-update.pdf
modip.pdf
chksrv.pdf
account.pdf
)
function getPDF()
{
	#for theme in pygments kate monochrome espresso haddock tango zenburn
	for theme in pygments
	do
	
		pandoc $chapters -o $ofile.$theme.tex \
		--toc \
		--chapters \
		--smart \
		-V links-as-notes \
		--listings \
		--highlight-style=$theme \
		--template=templates/ctex.latex \
		--latex-engine=xelatex
		
		sed -i 's/\DefineVerbatimEnvironment{Highlighting}.*/\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\\\\{\\},fontsize=\\small,xleftmargin=3mm,frame=lines}/g' $ofile.$theme.tex
		
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/label=(.*)]/label=\1, caption=\1, float=htbp\]/" $ofile.$theme.tex
		sed -i "s/\.jpg/\.eps/g" $ofile.$theme.tex
		
		xelatex $ofile.$theme.tex #1&>/dev/null
		xelatex $ofile.$theme.tex #1&>/dev/null
		
		
#		pandoc $chapters -o $ofile.$theme.pdf \
#		--toc \
#		--chapters \
#		--smart \
#		-V links-as-notes \
#		--highlight-style=$theme \
#		--template=templates/ctex.latex \
#		--latex-engine=xelatex
	done
	mv $ofile.* ../
	
	for type in aux gz log out toc
	do
		rm -f ../*.$type
	done
}
function getHTML()
{
	for id in ${pdf[*]}
	do
		filename=`echo $id |sed 's/\.pdf//g'`
		sed -i "s/$id/$filename.jpg/g" *.md
	done
	
	for theme in pygments kate monochrome espresso haddock tango zenburn
	do
		pandoc --self-contained $chapters -o $ofile.$theme.html \
		--toc  \
		--smart \
		--highlight-style=$theme \
		--template=templates/pm-template.html5
		
		pandoc --self-contained $chapters -o $ofile.nolight.html \
		--toc  \
		--smart \
		--template=templates/pm-template.html5
	done
	mv $ofile.* ../
	
	
	
	for id in ${pdf[*]}
	do
		filename=`echo $id |sed 's/\.pdf//g'`
		sed -i "s/$filename.jpg/$id/g" *.md
	done
}

function Clean()
{
	cd ../
	for type in html pdf tex aux gz log out toc
	do
		rm -f *.$type
	done
}
if [ $# -eq 0 ];then
	getHTML
	getPDF
elif [ "$1"x = "pdf"x ];then
	getPDF
elif [ "$1"x = "html"x ];then
	getHTML
elif [ "$1"x = "c"x ];then
	Clean
fi


