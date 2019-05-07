function cv() {
	getVar CV "moderncv"	
	cvList=(moderncv limecv)	
	interaction="-interaction=batchmode"
	[ "$TRACE"x == "true"x ] && interaction=""

	init nometa
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
		
		[ "$LSTSET"x != ""x ] && (cat $LSTSET;echo) >> $HEADERS
		# 支持 fenced_divs语法的columns
		[ "$columns"x == "true"x ] && addOptions="$addOptions $COLUMNS_SUPPORT"
		
		trimHeader
		
		CV_REFERENCE_PARAM="-F pandoc-citeproc $BIB_PARAM --csl=$CSL --lua-filter $SCRIPTDIR/filters/add-header.lua --template=$t.tpl"
		[ -f $t.lua ] && CV_REFERENCE_PARAM="$CV_REFERENCE_PARAM --lua-filter $t.lua"
		info "CV_REFERENCE_PARAM: $CV_REFERENCE_PARAM"
		pandoc $CV_REFERENCE_PARAM --listings $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS $addOptions
		
		# 删除空行，空行会被认为是分段，处理很麻烦。干脆全删掉。一般简历中需要用分段的场景是求职信，
		#转求职信的时候用\par显式分段
		sed -i '/^$/d' $OUTPUT
		
		xelatex $interaction -output-directory=$BUILD $OUTPUT
		compileStatus cv
	done
	
	clean
}
