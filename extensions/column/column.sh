regext column
getArrayVar _G "ext-column" true

function ext_column() {
	if [ "${_G[ext-column]}"x == "true"x ];then
		_F[column]="--lua-filter $SCRIPTDIR/${_G[extdir]}/column/fenced_divs_columns.lua"
	fi
}

function ext_column_help() {
	echo -e "\t-G ext-column:<true|false>    enable column(default true)"
	exit 0
}