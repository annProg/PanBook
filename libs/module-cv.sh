function cv() {
	getVar CV "moderncv"	
	cvList=(moderncv limecv)	
	interaction="-interaction=batchmode"
	[ "$TRACE"x == "true"x ] && interaction=""

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

		OUTPUT="$BUILD/$ofile-cv-$t.tex"
		
		# 某些cv需要打补丁. 补丁放在cv文件夹下，命名规则 patch-$cvname.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		info "PANDOCVARS: $PANDOCVARS"
		info "addOptions: $addOptions"
		
		trimHeader
		
		CV_REFERENCE_PARAM="-F pandoc-citeproc $BIB_PARAM --csl=$CSL --lua-filter $SCRIPTDIR/filters/add-header.lua --template=$t.tpl"
		[ -f $t.lua ] && CV_REFERENCE_PARAM="$CV_REFERENCE_PARAM --lua-filter $t.lua"
		info "CV_REFERENCE_PARAM: $CV_REFERENCE_PARAM"
		pandoc $CV_REFERENCE_PARAM --listings $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS --metadata-file=$METADATA $addOptions
		
		# 删除空行，空行会影响某些模板编译
		sed -i '/^$/d' $OUTPUT
		
		# citeproc \leavevmode 需要换行
		sed -i '/^\\leavevmode/i\\n' $OUTPUT
		xelatex $interaction -output-directory=$BUILD $OUTPUT
		compileStatus cv
	done
	
	clean
}
