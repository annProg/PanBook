regext note
getArrayVar _G "ext-note" true
getArrayVar _G "ext-note-tex" "$SCRIPTDIR/${_G[extdir]}/note/note.tex"

function ext_note() {
	# 依赖add header功能
	if [ "${_G[ext-note]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		# 第一个参数为 tex 时才使用扩展种的note定义（有些文档类定义了note环境）
		if [ "$1"x == "tex"x ];then
			writeHeader ${_G[ext-note-tex]}
		fi
		_F[note]="--lua-filter $SCRIPTDIR/${_G[extdir]}/note/note.lua"
	fi
}

function ext_note_help() {
	echo -e "\t-G ext-note:<true|false>                        enable note(default true)"
	echo -e "\t-G ext-note-tex:<custom note set file>         change note set file"
	exit 0
}