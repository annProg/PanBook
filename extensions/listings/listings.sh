regext listings
# 通用扩展
getArrayVar _G "ext-listings" true
getArrayVar _G "ext-listings-lstset" "$SCRIPTDIR/${_G[extdir]}/listings/listings-set.tex"
getArrayVar _G "ext-listings-style" "noframe"

function listings() {
	for i in `echo ${!_P[@]}`;do
		[ $i == "listings" ] && echo true && return 0
	done
	echo false
}

function setStyle() {
	if [ "${_G[ext-listings-set]}"x != ""x ];then
		echo ${_G[ext-listings-set]}
	else
		echo $SCRIPTDIR/${_G[extdir]}/listings/${_G[ext-listings-style]}.tex
	fi
}

function ext_listings() {
	# 依赖add header功能
	if [ `listings` == "true" -a "${_G[ext-listings]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-listings-lstset]}
		_P[listings]=""
		_M[listings]=true
		_G[highlight]="--listings"

		extStat listings done
	else
		stylePath=`setStyle`
		writeHeader $stylePath
		extStat listings skip
	fi
}

function ext_listings_help() {
	echo -e "\t-G ext-listings:<true|false>                        enable listings(default true)"
	echo -e "\t-G ext-listings-lstset:<custom listings set file>   change listings set file"
	echo -e "\t-G ext-listings-set:<custom set file>               change highlight set file"
	echo -e "\t-G ext-listings-style:<mdframe|noframe>             highlight style.(mdframe or noframe)"
	exit 0
}