regext wrap

getArrayVar _G "ext-wrap" `enableExt 11101`
getArrayVar _G "ext-wrap-style" "tcolorbox"
getArrayVar _V "lang" "zh"
getArrayVar _G "ext-wrap-color" $SCRIPTDIR/${_G[extdir]}/wrap/color.tex
getArrayVar _G "ext-wrap-introduction" $SCRIPTDIR/${_G[extdir]}/wrap/introduction.tex
getArrayVar _G "ext-wrap-problemset" $SCRIPTDIR/${_G[extdir]}/wrap/problemset.tex

# 是否使用扩展中的wrap定义（有些文档类定义了wrap环境，允许在style patch中关闭）
getArrayVar _G "ext-wrap-use-tex" true

function ext_wrap() {
	getArrayVar _G "ext-wrap-tex" "$SCRIPTDIR/${_G[extdir]}/wrap/${_G[ext-wrap-style]}-wrap.tex"
	getArrayVar _G "ext-wrap-texlang" "$SCRIPTDIR/${_G[extdir]}/wrap/${_V[lang]}.tex"
	# 依赖add header功能
	if [ "${_G[ext-wrap]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-wrap-texlang]}
		# 第一个参数为 tex 时才使用扩展种的wrap定义（有些文档类定义了wrap环境）
		if [ "${_G[ext-wrap-use-tex]}"x == "true"x ];then
			writeHeader ${_G[ext-wrap-color]}
			writeHeader ${_G[ext-wrap-tex]}
		fi
		# 如果style本身支持introduction和problemset，可以unset _G[ext-wrap-introduction]
		writeHeader ${_G[ext-wrap-introduction]}
		writeHeader ${_G[ext-wrap-problemset]}

		# noanswer功能,elegantbook文档类可以通过classoption设置，其他文档类通过_G[ext-wrap-noanswer]=true来设置
		if [ "${_G[ext-wrap-noanswer]}"x == "true"x ];then
			writeHeader $SCRIPTDIR/${_G[extdir]}/wrap/noanswer.tex
		fi
		_F[wrap]="--lua-filter $SCRIPTDIR/${_G[extdir]}/wrap/wrap.lua"

		extStat wrap done
	else
		extStat wrap skip
	fi
}

function ext_wrap_help() {
	echo -e "\t-G ext-wrap:<true|false>                        enable wrap(default true)"
	echo -e "\t-G ext-wrap-tex:<custom wrap set file>          change wrap set file"
	echo -e "\t-G ext-wrap-texlang:<custom language file>      change language file"
	echo -e "\t-G ext-wrap-style:<bclogo|tcolorbox>            select wrap style"
	echo -e "\t-G ext-wrap-color:<custom color set file>       use custom color set file"
	echo -e "\t-G ext-wrap-introduction:<custom introduction>  use custom introduction"
	echo -e "\t-G ext-wrap-problemset:<custom problemset>      use custom problemset"
	echo -e "\t-G ext-wrap-noanswer:<true|false>               noanswer mode"
	echo -e "\t-V lang:<zh|en>                                 select language(default zh)"
	exit 0
}