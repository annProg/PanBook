function cvMeta() {
	cvFile=$WORKDIR/cv.md
	photoFile=$IMGDIR/photo.png
	bibFile=$WORKDIR/bibliography.bib
	makeFile=$cwd/Makefile
	[ ! -f $photoFile ] && cp $SCRIPTDIR/medias/photo.png $photoFile
	[ ! -f $makeFile ] && cp $SCRIPTDIR/libs/scripts/cv.Makefile $makeFile
	[ ! -f $cvFile ] && cat > $cvFile <<EOF

EOF

	[ ! -f $bibFile ] && cat > $bibFile <<EOF
EOF
	
}

function func_cv() {
	note "use --style=<template|R|A> to change cv template. R means radom, A means all"
	getVar _G[style] "moderncv"
	cvList=(`ls ${_G[stylecv]}`)
	_G[cvlist]=${cvList[@]}
	[ "${_G[trace]}"x == "true"x ] && interaction="" || interaction="-interaction=batchmode"

	cvMeta
	
	# 支持随机选取style
	setStyle "${cvList[*]}"

	for t in `echo ${_G[selected-style]}`;do
		# 每个模板都需要重新init，否则HEADERS会重复添加内容
		init nometa
		cd ${_G[build]}

		note "${_G[function] Style: $t"
		addOptions="$origAddOptions"
		PANDOCVARS="$ORIGPANDOCVARS"
		# copy cv template
		CVTPLDIR=$SCRIPTDIR/templates/$CVTPLDIR/$t
		USERDEFINECV=$cwd/templates/$CVTPLDIR/$t
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
