function setBeamerTheme() {
	themeList=(material HeavenlyClouds Xiaoshan Execushares classyslides Hest opensuse boxes CambridgeUS classic Dresden EastLansing lined Singapore cuerna   metropolis)	
	SELECTEDTHEME=($THEME)
	# random theme support
	if [ "$1"x == "R"x ];then
		len=`echo ${#themeList[@]}`
		index=$(($RANDOM%$len))	
		SELECTEDTHEME=(${themeList[$index]})
	fi
	
	if [ "$1"x == "A"x ];then
		SELECTEDTHEME=`echo ${themeList[@]}`
	fi
	
	info "SELECTEDTHEME: ${SELECTEDTHEME[@]}"
	
	if [ "$TPL"x != ""x ];then
		addOptions="--template=$TPL.tpl"
	else
		addOptions=""
	fi
}

function beamer() {
	getVar TPL "latex"
	getVar THEME "metropolis"
	setPandocVar "classoption=aspectratio" "169"
	setPandocVar "documentclass" "ctexbeamer"
	
	init
	cd $BUILD
	
	
	# 支持随机选取theme
	setBeamerTheme $THEME
	
	for t in ${SELECTEDTHEME[@]};do
		# copy beamertheme
		BEAMERTHEMEDIR=$SCRIPTDIR/templates/beamerthemes/$t
		USERDEFINETHMEME=$cwd/templates/beamerthemes/$t
		if [ -d $BEAMERTHEMEDIR -o -d $USERDEFINETHMEME ];then
			cp -rfu $BEAMERTHEMEDIR $BUILD 2>/dev/null
			cp -rfu $USERDEFINETHMEME $BUILD 2>/dev/null
			# 需要删除.md文件
			rm -f $t/*.md
			rm -f $t/*.pdf
			cp -rfu $t/* .
		fi
	
		# -V colortheme=$COLORTHEME -V fonttheme=$FONTTHEME -V outertheme=$OUTERTHEME -V innertheme=$INNTERTHEME
		PANDOCVARS="$PANDOCVARS -V theme=$t"
		info "PANDOCVARS: $PANDOCVARS"
		
		# 某些theme需要打补丁. 补丁放在theme文件夹下，命名规则 patch-$themename.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		OUTPUT="$BUILD/$ofile-beamer-$t.pdf"
		# output tex for debug
		[ "$DEBUG"x == "true"x ] && pandoc -t beamer $BODY -o $OUTPUT.tex --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA --listings -H listings-set.tex $addOptions
		pandoc -t beamer $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA --listings -H listings-set.tex $addOptions
		compileStatus beamer
	done
	
	#clean
}
