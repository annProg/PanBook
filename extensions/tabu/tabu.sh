regext tabu
getArrayVar _G "ext-tabu" true
getArrayVar _G "ext-tabu-tex" "$SCRIPTDIR/${_G[extdir]}/tabu/tabu.tex"

function ext_tabu() {
	# 依赖add header功能
	if [ "${_G[ext-tabu]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-tabu-tex]}
		_F[tabu]="--lua-filter $SCRIPTDIR/${_G[extdir]}/tabu/tabu.lua"
	fi
}

function ext_tabu_help() {
	echo -e "\t-G ext-tabu:<true|false>                        enable tabu(default true)"
	echo -e "\t-G ext-tabu-tex:<custom tabu set file>         change tabu set file"
	exit 0
}