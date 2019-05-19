function cvMeta() {
	initBody cv.md
	initBib true
	initMakefile
	photoFile=${_G[imgdir]}/photo.png
	makeFile=$cwd/Makefile
	[ ! -f $photoFile ] && cp ${_G[exampledir]}/${_G[function]}/src/images/photo.png $photoFile	
	
	# cv不需要单独的metadata file
	unset _P[metadata-file]
	unset _G[crossref]
}

function func_cv() {
	getArrayVar _G style "moderncv"
	STYLECV=$SCRIPTDIR/${_G[stylecv]}
	USERSTYLECV=$CWD/${_G[stylecv]}
	cvList=(`ls $STYLECV` `ls $USERSTYLECV`)
	_G[cvlist]=${cvList[@]}
	[ "${_G[trace]}"x == "true"x ] && _G[interaction]=""

	cvMeta

	init
	cd ${_G[build]}

	# copy cv template
	if [ -d $STYLECV/${_G[style]} -o -d $USERSTYLECV/${_G[style]} ];then
		cp -rfu $STYLECV/${_G[style]} ${_G[build]} 2>/dev/null
		cp -rfu $USERSTYLECV/${_G[style]} ${_G[build]} 2>/dev/null
		# 需要删除.md文件
		rm -f ${_G[style]}/*.md
		rm -f ${_G[style]}/*.pdf
		cp -rfu ${_G[style]}/* .
	fi

	_G[ofile]=${_G[build]}/${_G[ofile]}-cv-${_G[style]}
	
	# 某些cv需要打补丁. 补丁放在cv文件夹下，命名规则 patch-$cvname.sh
	[ -f patch-${_G[style]}.sh ] && source patch-${_G[style]}.sh
	
	# 自动扫描风格目录下的lua filter
	[ -f ${_G[style]}.lua ] && _F[style-${_G[function]}-${_G[style]}]="--lua-filter ${_G[style]}.lua"
	# 如有tpl，自动加载
	[ -f ${_G[style]}.tpl ] && _P[template]="${_G[style]}.tpl"
	
	# 启用扩展
	${_G[ext-header]}
	${_G[ext-listings]}
	${_G[ext-column]}
	${_G[ext-grade]}

	getPandocParam
	getXeLaTeXParam
	pandoc ${_G[pandoc-param]}
	
	# 删除空行，空行会被认为是分段，处理很麻烦。干脆全删掉。一般简历中需要用分段的场景是求职信，
	#转求职信的时候用\par显式分段
	sed -i '/^$/d' ${_G[ofile]}.${_G[t]}
	
	xelatex ${_G[xelatex]} -output-directory=${_G[build]} ${_G[ofile]}.${_G[t]}
	compileStatus ${_G[function]}	
}
