function _copystyle() {
	cd ${_G[build]}
	# copy style
	func=${_G[function]}
	STYLEDIR=$SCRIPTDIR/${_G[style$func]}/${_G[style]}
	USERSTYLEDIR=$CWD/${_G[style$func]}/${_G[style]}

	if [ -d $STYLEDIR -o -d $USERSTYLEDIR ];then
		cp -rfu $STYLEDIR ${_G[build]} 2>/dev/null
		cp -rfu $USERSTYLEDIR ${_G[build]} 2>/dev/null
		# 需要删除.md文件
		rm -f ${_G[style]}/*.md
		rm -f ${_G[style]}/*.pdf
		cp -rfu ${_G[style]}/* .
	fi
}

function _patch() {
	cd ${_G[build]}
	# 某些cv需要打补丁. 补丁放在cv文件夹下，命名规则 patch-$cvname.sh
	[ -f patch-${_G[style]}.sh ] && source patch-${_G[style]}.sh
	
	# 自动扫描风格目录下的lua filter
	[ -f ${_G[style]}.lua ] && _F[style-${_G[function]}-${_G[style]}]="--lua-filter ${_G[style]}.lua"
	# 如有tpl，自动加载（需考虑用户通过--template指定tpl的情况）
	[ -f ${_G[style]}.tpl -a "${_P[template]}"x == ""x ] && _P[template]="${_G[style]}.tpl"
}

function _common() {
	echo "todo"
}