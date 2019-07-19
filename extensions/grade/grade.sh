regext grade
getArrayVar _G "ext-grade" `enableExt 00001`
getArrayVar _G "ext-grade-tex" "$SCRIPTDIR/${_G[extdir]}/grade/grade.tex"

function ext_grade() {
	# 依赖add header功能
	if [ "${_G[ext-grade]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-grade-tex]}
		_F[grade]="--lua-filter $SCRIPTDIR/${_G[extdir]}/grade/grade.lua"

		extStat grade done
	else
		extStat grade skip
	fi
}

function ext_grade_help() {
	echo -e "\t-G ext-grade:<true|false>                        enable grade(default true)"
	echo -e "\t-G ext-grade-tex:<custom grade set file>         change grade set file"
	exit 0
}