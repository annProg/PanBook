# 注册模块及帮助信息
regmod slide
_H[slide]="make slide"

function func_slide() {
	initBody cv.md
	initBib true
	initMakefile

	getArrayVar _G style metropolis
	getArrayVar _V documentclass ctexbeamer
	getArrayVar _V classoption "aspectratio=169"
	_V[theme]=${_G[style]}

	STYLESLIDE=$SCRIPTDIR/${_G[styleslide]}
	USERSTYLESLIDE=$CWD/${_G[styleslide]}

	init
	cd ${_G[build]}
	t=${_G[style]}
	note "style: $t"
	# copy beamertheme
	if [ -d $STYLESLIDE/$t -o -d $USERSTYLESLIDE/$t ];then
		cp -rfu $STYLESLIDE/$t ${_G[build]} 2>/dev/null
		cp -rfu $USERSTYLESLIDE/$t ${_G[build]} 2>/dev/null
		# 需要删除.md文件
		rm -f $t/*.md
		rm -f $t/*.pdf
		cp -rfu $t/* .
	fi

	_G[ofile]=${_G[build]}/${_G[ofile]}-${_G[function]}-${_G[style]}

	# 某些theme需要打补丁. 补丁放在theme文件夹下，命名规则 patch-$themename.sh
	[ -f patch-$t.sh ] && source patch-$t.sh

	# 自动扫描风格目录下的lua filter
	[ -f $t.lua ] && _F[style-${_G[function]}-$t]="--lua-filter $t.lua"
	# 如有tpl，自动加载
	[ -f $t.tpl ] && _P[template]="$t.tpl"

	# 启用扩展
	ext_header
	ext_listings
	ext_grade

	if [ "${_G[debug]}"x != "true"x ];then
		_G[t]=pdf
	else
		_P[standalone]=""
	fi

	_P[to]=beamer
	getPandocParam
	pandoc ${_G[pandoc-param]}
	compileStatus ${_G[function]}
}
