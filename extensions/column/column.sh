_G[ext-column]="addColumns"
getArrayVal _G "ext-column-on" true

function addColumns() {
	if [ "${_G[ext-column-on]}"x == "true"x ];then
		_F[column]="--lua-filter $SCRIPTDIR/${_G[extdir]}/column/fenced_divs_columns.lua"
	fi
}

function columnHelp() {
	echo -e "\t-G ext-column-on:<true|false>    enable column(default true)"
	exit 0
}