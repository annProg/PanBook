function cv() {
	getVar CV "moderncv"	
	cvList=(moderncv limecv)	

	init
	cd $BUILD
	
	
	# 支持随机选取theme
	setCV $cvList

	for t in ${SELECTED[@]};do
		note "CV Template: $t"
		addOptions="$origAddOptions"
		PANDOCVARS="$ORIGPANDOCVARS"
		# copy cv template
		CVTPLDIR=$SCRIPTDIR/templates/cvtpls/$t
		USERDEFINECV=$cwd/templates/cvtpls/$t
		if [ -d $CVTPLDIR -o -d $USERDEFINECV ];then
			cp -rfu $CVTPLDIR $BUILD 2>/dev/null
			cp -rfu $USERDEFINECV $BUILD 2>/dev/null
			# 需要删除.md文件
			rm -f $t/*.md
			rm -f $t/*.pdf
			cp -rfu $t/* .
		fi
		
		# 某些cv需要打补丁. 补丁放在cv文件夹下，命名规则 patch-$cvname.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		info "PANDOCVARS: $PANDOCVARS"
		info "addOptions: $addOptions"
		
		OUTPUT="$BUILD/$ofile-cv-$t.pdf"
		trimHeader
		
		CV_REFERENCE_PARAM="-F pandoc-citeproc $BIB --csl=$CSL --lua-filter $SCRIPTDIR/filters/add-header.lua --template=$CV.tpl"
		# output tex for debug
		[ "$DEBUG"x == "true"x ] && \
		pandoc $CV_REFERENCE_PARAM --listings $BODY -o $OUTPUT.tex --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA $addOptions
		pandoc $CV_REFERENCE_PARAM --listings $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA $addOptions
		compileStatus cv
	done
	
	clean
}
