regext question
getArrayVar _G "ext-question" true
getArrayVar _G "ext-question-style" "bclogo"

function ext_question() {
	getArrayVar _G "ext-question-tex" "$SCRIPTDIR/${_G[extdir]}/question/${_G[ext-question-style]}-question.tex"
	# 依赖add header功能
	if [ "${_G[ext-question]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		# 第一个参数为 tex 时才使用扩展种的question定义（有些文档类定义了question环境）
		if [ "$1"x == "tex"x ];then
			writeHeader ${_G[ext-question-tex]}
		fi
		_F[question]="--lua-filter $SCRIPTDIR/${_G[extdir]}/question/question.lua"
	fi
}

function ext_question_help() {
	echo -e "\t-G ext-question:<true|false>                        enable question(default true)"
	echo -e "\t-G ext-question-tex:<custom question set file>          change question set file"
	echo -e "\t-G ext-question-style:<bclogo|tcolorbox>            select question style"
	exit 0
}