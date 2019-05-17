_G[ext-grade]="addgrade"
getArrayVal _G "ext-grade-on" true
getArrayVal _G "ext-grade-tex" "$SCRIPTDIR/${_G[extdir]}/grade/grade.tex"

function addgrade() {
	# 依赖add header功能
	if [ "${_G[ext-grade-on]}"x == "true"x -a "${_G[ext-header-on]}"x == "true"x ];then
		writeHeader ${_G[ext-grade-tex]}
	fi
}

function gradeHelp() {
	echo -e "\t-G ext-grade-on:<true|false>                     enable grade(default true)"
	echo -e "\t-G ext-grade-tex:<custom grade set file>         change grade set file"
	exit 0
}