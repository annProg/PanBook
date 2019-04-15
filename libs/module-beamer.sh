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
		customHeader="--template=$TPL.tpl"
	else
		customHeader=""
	fi
}

function beamer() {
	getEnv TPL "latex"
	getEnv CJK "微软雅黑"
	getEnv THEME "metropolis"
	getEnv COLORTHEME ""
	getEnv FONTTHEME ""
	getEnv OUTERTHEME ""
	getEnv INNTERTHEME ""
	getEnv RATIO "169"
	
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
		THEMEOPT="-V theme=$t -V classoption=aspectratio=$RATIO"
		info "$THEMEOPT"
		
		# 某些theme需要打补丁. 补丁放在theme文件夹下，命名规则 patch-$themename.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		OUTPUT="$BUILD/$ofile-beamer-$t.pdf"
		# output tex for debug
		[ "$DEBUG"x == "true"x ] && pandoc -t beamer $BODY -o $OUTPUT.tex --pdf-engine=xelatex $THEMEOPT -V CJKmainfont=$CJK --metadata-file=$METADATA -V date="\today" --listings -H listings-set.tex $customHeader
		pandoc -t beamer $BODY -o $OUTPUT --pdf-engine=xelatex $THEMEOPT -V CJKmainfont=$CJK --metadata-file=$METADATA -V date="\today" --listings -H listings-set.tex $customHeader
		compileStatus beamer
	done
	
	#clean
}
