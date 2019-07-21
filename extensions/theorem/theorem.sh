regext theorem
getArrayVar _G "ext-theorem" `enableExt 11110`
getArrayVar _G "ext-theorem-style" "tcolorbox"
getArrayVar _V "lang" "zh"
getArrayVar _G "ext-theorem-color" $SCRIPTDIR/${_G[extdir]}/theorem/color.tex

# 是否使用扩展中的theorem定义（有些文档类定义了theorem环境，允许在style patch中关闭）
getArrayVar _G "ext-theorem-use-tex" true

function ext_theorem() {
	getArrayVar _G "ext-theorem-tex" "$SCRIPTDIR/${_G[extdir]}/theorem/${_G[ext-theorem-style]}-theorem.tex"
	getArrayVar _G "ext-theorem-texlang" "$SCRIPTDIR/${_G[extdir]}/theorem/${_V[lang]}.tex"
	# 依赖add header功能
	if [ "${_G[ext-theorem]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-theorem-texlang]}
		# 第一个参数为 tex 时才使用扩展种的theorem定义（有些文档类定义了theorem环境）
		if [ "${_G[ext-theorem-use-tex]}"x == "true"x ];then
			writeHeader ${_G[ext-theorem-color]}
			writeHeader ${_G[ext-theorem-tex]}
		fi
		# 由于theorem引用格式和citeproc一致，需要在citeproc之前执行，因此放入 _F0 数组
		_F0[theorem]="--lua-filter $SCRIPTDIR/${_G[extdir]}/theorem/theorem.lua"

		extStat theorem done
	else
		extStat theorem skip
	fi
}

function ext_theorem_help() {
	echo -e "\t-G ext-theorem:<true|false>                        enable theorem(default true)"
	echo -e "\t-G ext-theorem-tex:<custom theorem set file>       change theorem set file"
	echo -e "\t-G ext-theorem-texlang:<custom language file>      change language file"
	echo -e "\t-G ext-theorem-color:<custom color set file>       change color set file"
	echo -e "\t-G ext-theorem-style:<tcolorbox>                   select theorem style"
	echo -e "\t-V lang:<zh|en>                                    select language"
	exit 0
}