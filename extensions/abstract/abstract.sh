regext abstract
getArrayVar _G "ext-abstract" `enableExt 01100`
getArrayVar _G "ext-abstract-tex" "$SCRIPTDIR/${_G[extdir]}/abstract/abstract.tex"

function ext_abstract() {
	# 依赖add header功能
	if [ "${_G[ext-abstract]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-abstract-tex]}
		_F[abstract]="--lua-filter $SCRIPTDIR/${_G[extdir]}/abstract/abstract.lua"

		extStat abstract done
	else
		extStat abstract skip
	fi
}

function ext_abstract_help() {
	echo -e "\t-G ext-abstract:<true|false>                        enable abstract(default true)"
	echo -e "\t-G ext-abstract-tex:<custom abstract set file>         change abstract set file"
	exit 0
}