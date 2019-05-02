function beamer() {
	getVar TPL "latex"
	getVar THEME "metropolis"
	getVar DOCUMENTCLASS "ctexbeamer"
	
	themeList=(solarized material HeavenlyClouds Xiaoshan Execushares classyslides Hest opensuse boxes CambridgeUS classic Dresden EastLansing lined Singapore cuerna   metropolis)	

	init
	cd $BUILD
	
	
	# 支持随机选取theme
	setTheme $themeList

	for t in ${SELECTED[@]};do
		note "THEME: $t"
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
		pandoc $PANDOC_REFERENCE_PARAM -t beamer $BODY -o $OUTPUT.tex --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA  $highLight $addOptions
		pandoc $PANDOC_REFERENCE_PARAM -t beamer $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA $highLight $addOptions
		compileStatus beamer
	done
	
	clean
}
