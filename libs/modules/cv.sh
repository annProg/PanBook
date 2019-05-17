function cvMeta() {
	initBody cv.md
	initBib
	initMakefile
	photoFile=${_G[imgdir]}/photo.png
	makeFile=$cwd/Makefile
	[ ! -f $photoFile ] && cp ${_G[exampledir]}/${_G[function]}/src/images/photo.png $photoFile	
}

function func_cv() {
	getArrayVal _G style "moderncv"
	STYLECV=$SCRIPTDIR/${_G[stylecv]}
	USERSTYLECV=$CWD/${_G[stylecv]}
	cvList=(`ls $STYLECV` `ls $USERSTYLECV`)
	_G[cvlist]=${cvList[@]}
	[ "${_G[trace]}"x == "true"x ] && _G[interaction]=""

	cvMeta
	
	# 支持随机选取style
	setStyle "${cvList[*]}"

	for t in `echo ${_G[selected-style]}`;do
		# 每个模板都需要重新init，否则HEADERS会重复添加内容
		init
		cd ${_G[build]}

		# copy cv template
		if [ -d $STYLECV/$t -o -d $USERSTYLECV/$t ];then
			cp -rfu $STYLECV/$t ${_G[build]} 2>/dev/null
			cp -rfu $USERSTYLECV/$t ${_G[build]} 2>/dev/null
			# 需要删除.md文件
			rm -f $t/*.md
			rm -f $t/*.pdf
			cp -rfu $t/* .
		fi

		_G[ofile]=${_G[build]}/${_G[ofile]}-cv-$t
		
		# 某些cv需要打补丁. 补丁放在cv文件夹下，命名规则 patch-$cvname.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		# 启用扩展
		${_G[ext-header]}
		${_G[ext-listings]}
		${_G[ext-column]}
				
		trimHeader
		
		[ -f $t.lua ] && _F[style-${_G[function]}-$t]="--lua-filter $t.lua"
		
		getPandocParam
		getXeLaTeXParam
		pandoc ${_G[pandoc-param]}
		
		# 删除空行，空行会被认为是分段，处理很麻烦。干脆全删掉。一般简历中需要用分段的场景是求职信，
		#转求职信的时候用\par显式分段
		sed -i '/^$/d' ${_G[ofile]}.${_G[t]}
		
		xelatex ${_G[xelatex]} -output-directory=${_G[build]} ${_G[ofile]}.${_G[t]}
		compileStatus ${_G[function]}
	done
	
	clean
}
