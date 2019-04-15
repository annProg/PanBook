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
		origAddOptions="--template=$TPL.tpl"
	else
		origAddOptions=""
	fi
}

function beamer() {
	getVar TPL "latex"
	getVar THEME "metropolis"
	getVar DOCUMENTCLASS "ctexbeamer"
	
	init
	cd $BUILD
	
	
	# 支持随机选取theme
	setBeamerTheme $THEME
	origHighLight="--listings -H listings-set.tex"

	for t in ${SELECTEDTHEME[@]};do
		addOptions="$origAddOptions"
		highLight="$origHighLight"
		PANDOCVARS="$ORIGPANDOCVARS"
		setPandocVar "classoption=aspectratio" "169" # setPandocVar需在PANDOCVARS被ORIGPANDOCVARS赋值之后执行
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
		
		PANDOCVARS="$PANDOCVARS -V theme=$t -V documentclass=$DOCUMENTCLASS"
		# 某些theme需要打补丁. 补丁放在theme文件夹下，命名规则 patch-$themename.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		info "PANDOCVARS: $PANDOCVARS"
		info "addOptions: $addOptions"
		info "highLight: $highLight"
		
		OUTPUT="$BUILD/$ofile-beamer-$t.pdf"
		# output tex for debug
		[ "$DEBUG"x == "true"x ] && \
		pandoc -t beamer $BODY -o $OUTPUT.tex --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA  $highLight $addOptions
		pandoc -t beamer $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA $highLight $addOptions
		compileStatus beamer
	done
	
	#clean
}
