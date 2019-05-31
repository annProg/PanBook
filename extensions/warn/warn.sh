regext warn
getArrayVar _G "ext-warn" true
getArrayVar _G "ext-warn-style" "bclogo"

function ext_warn() {
	getArrayVar _G "ext-warn-tex" "$SCRIPTDIR/${_G[extdir]}/warn/${_G[ext-warn-style]}-warn.tex"
	# 依赖add header功能
	if [ "${_G[ext-warn]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		# 第一个参数为 tex 时才使用扩展种的warn定义（有些文档类定义了warn环境）
		if [ "$1"x == "tex"x ];then
			writeHeader ${_G[ext-warn-tex]}
		fi
		_F[warn]="--lua-filter $SCRIPTDIR/${_G[extdir]}/warn/warn.lua"
	fi
}

function ext_warn_help() {
	echo -e "\t-G ext-warn:<true|false>                        enable warn(default true)"
	echo -e "\t-G ext-warn-tex:<custom warn set file>          change warn set file"
	echo -e "\t-G ext-warn-style:<bclogo|tcolorbox>            select warn style"
	exit 0
}