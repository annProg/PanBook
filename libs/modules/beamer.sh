function func_beamer() {
	getVar TPL "latex"
	getVar THEME "metropolis"
	getVar DOCUMENTCLASS "ctexbeamer"
	SLIDETPLDIR="slide"
	
	themeList=(solarized material HeavenlyClouds Xiaoshan Execushares classyslides Hest opensuse boxes CambridgeUS classic Dresden EastLansing lined Singapore cuerna   metropolis)	
	
	# 支持随机选取theme
	setTheme "${themeList[*]}"

	for t in ${SELECTED[@]};do
		init
		cd $BUILD

		note "THEME: $t"
		addOptions="$origAddOptions"
		PANDOCVARS="$ORIGPANDOCVARS"
		setPandocVar "classoption=aspectratio" "169" # setPandocVar需在PANDOCVARS被ORIGPANDOCVARS赋值之后执行
		# copy beamertheme
		BEAMERTHEMEDIR=$SCRIPTDIR/templates/$SLIDETPLDIR/$t
		USERDEFINETHMEME=$cwd/templates/$SLIDETPLDIR/$t
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
		
		[ "$LSTSET"x != ""x ] && (cat $LSTSET;echo) >> $HEADERS
		info "PANDOCVARS: $PANDOCVARS"
		info "addOptions: $addOptions"
		info "LSTSET: $LSTSET"
		
		OUTPUT="$BUILD/$ofile-beamer-$t.pdf"
		trimHeader
		# output tex for debug
		[ "$DEBUG"x == "true"x ] && \
		pandoc $PANDOC_REFERENCE_PARAM --listings -t beamer $BODY -o $OUTPUT.tex --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA $addOptions
		pandoc $PANDOC_REFERENCE_PARAM --listings -t beamer $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA $addOptions
		compileStatus beamer
	done
	
	clean
}
