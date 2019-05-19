regext header
getArrayVar _G "ext-header" true

function ext_header() {
	if [ "${_G[ext-header]}"x == "true"x ];then
		_F[add-header]="--lua-filter $SCRIPTDIR/${_G[extdir]}/header/add-header.lua"
	fi
}

function ext_header_help() {
	echo -e "\t-G ext-header:<true|false> enable add header(default true)"
	exit 0
}