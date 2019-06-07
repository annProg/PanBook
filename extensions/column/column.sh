regext column
getArrayVar _G "ext-column" true
getArrayVar _G ext-column-tex "$SCRIPTDIR/${_G[extdir]}/column/column.tex"

function ext_column() {
	if [ "${_G[ext-column]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader "${_G[ext-column-tex]}"
		_F[column]="--lua-filter $SCRIPTDIR/${_G[extdir]}/column/fenced_divs_columns.lua"
	fi
}

function ext_column_help() {
	echo -e "\t-G ext-column:<true|false>    enable column(default true)"
	exit 0
}