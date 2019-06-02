regext wrap
getArrayVar _G "ext-wrap" true
getArrayVar _G "ext-wrap-style" "bclogo"
getArrayVar _V "lang" "zh"
getArrayVar _G "ext-wrap-color" $SCRIPTDIR/${_G[extdir]}/wrap/color.tex

function ext_wrap() {
	getArrayVar _G "ext-wrap-tex" "$SCRIPTDIR/${_G[extdir]}/wrap/${_G[ext-wrap-style]}-wrap.tex"
	getArrayVar _G "ext-wrap-texlang" "$SCRIPTDIR/${_G[extdir]}/wrap/${_V[lang]}.tex"
	# 依赖add header功能
	if [ "${_G[ext-wrap]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		# 第一个参数为 tex 时才使用扩展种的wrap定义（有些文档类定义了wrap环境）
		if [ "$1"x == "tex"x ];then
			writeHeader ${_G[ext-wrap-color]}
			writeHeader ${_G[ext-wrap-texlang]}
			writeHeader ${_G[ext-wrap-tex]}
		fi
		_F[wrap]="--lua-filter $SCRIPTDIR/${_G[extdir]}/wrap/wrap.lua"
	fi
}

function ext_wrap_help() {
	echo -e "\t-G ext-wrap:<true|false>                        enable wrap(default true)"
	echo -e "\t-G ext-wrap-tex:<custom wrap set file>          change wrap set file"
	echo -e "\t-G ext-wrap-texlang:<custom language file>      change language file"
	echo -e "\t-G ext-wrap-style:<bclogo|tcolorbox>            select wrap style"
	echo -e "\t-G ext-wrap-color:<custom color set file>       use custom color set file"
	echo -e "\t-V lang:<zh|en>                                 select language"
	exit 0
}