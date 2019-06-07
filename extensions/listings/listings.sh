regext listings
getArrayVar _G "ext-listings" true
getArrayVar _G "ext-listings-lstset" "$SCRIPTDIR/${_G[extdir]}/listings/listings-set.tex"

function ext_listings() {
	# 依赖add header功能
	if [ "${_G[ext-listings]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-listings-lstset]}
		_P[listings]=""
	fi
}

function ext_listings_help() {
	echo -e "\t-G ext-listings:<true|false>                        enable listings(default true)"
	echo -e "\t-G ext-listings-lstset:<custom listings set file>   change listings set file"
	exit 0
}