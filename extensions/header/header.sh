regext header
# 此扩展所有module都需要
getArrayVar _G "ext-header" true

function ext_header() {
	if [ "${_G[ext-header]}"x == "true"x ];then
		_F[add-header]="-M build_id=${_G[build_id]} --lua-filter $SCRIPTDIR/${_G[extdir]}/header/add-header.lua"
	
		extStat header done
	else
		extStat header skip
	fi
}

function ext_header_help() {
	echo -e "\t-G ext-header:<true|false> enable add header(default true)"
	exit 0
}