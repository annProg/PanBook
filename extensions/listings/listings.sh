regext listings
getArrayVar _G "ext-listings" true
getArrayVar _G "ext-listings-lstset" "$SCRIPTDIR/${_G[extdir]}/listings/listings-set.tex"

function listings() {
	for i in `echo ${!_P[@]}`;do
		[ $i == "listings" ] && echo true && return 0
	done
	echo false
}

function ext_listings() {
	# 依赖add header功能
	if [ `listings` == "true" -a "${_G[ext-listings]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-listings-lstset]}
		_P[listings]=""
		_M[listings]=true
	fi
}

function ext_listings_help() {
	echo -e "\t-G ext-listings:<true|false>                        enable listings(default true)"
	echo -e "\t-G ext-listings-lstset:<custom listings set file>   change listings set file"
	exit 0
}