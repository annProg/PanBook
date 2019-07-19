regext zh_en
# 通用扩展
getArrayVar _G "ext-zh_en" true
getArrayVar _G "ext-zh_en-lang" "zh"
getArrayVar _G "ext-zh_en-tex" "$SCRIPTDIR/${_G[extdir]}/zh_en/zh_en.tex"

function ext_zh_en() {
	getArrayVar _G "ext-zh_en-texlang" "$SCRIPTDIR/${_G[extdir]}/zh_en/${_G[ext-zh_en-lang]}.tex"
	# 依赖add header功能
	if [ "${_G[ext-zh_en]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-zh_en-tex]}
		writeHeader ${_G[ext-zh_en-texlang]}
		_M[ext-zh-en]=${_G[ext-zh_en-lang]}
		_F[zh_en]="--lua-filter $SCRIPTDIR/${_G[extdir]}/zh_en/zh_en.lua"

		extStat zh_en done
	else
		extStat zh_en skip
	fi
}

function ext_zh_en_help() {
	echo -e "\t-G ext-zh_en:<true|false>                        enable zh_en(default true)"
	echo -e "\t-G ext-zh_en-tex:<custom zh_en set file>         change zh_en set file"
	echo -e "\t-G ext-zh_en-texlang:<custom language file>      change language file"
	echo -e "\t-G ext-zh_en-lang:<zh|en|both>                   select language(default zh)"
	exit 0
}