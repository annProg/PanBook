_G[ext-listings]="addListings"
getArrayVal _G "ext-listings-on" true
getArrayVal _G "ext-listings-lstset" "${_G[extdir]}/listings/listings-set.tex"

function addListings() {
	# 依赖add header功能
	if [ "${_G[ext-listings-on]}"x == "true"x && "${_G[ext-header-on]}"x == "true"x ];then
		cat ${_G[ext-listings-lstset]} >> ${_G[header]}
		_P[listings]=true
	fi
}

function listingsHelp() {
	echo -e "\t-G ext-listings-on:<true|false>                     enable listings(default true)"
	echo -e "\t-G ext-listings-lstset:<custom listings set file>   change listings set file"
	exit 0
}