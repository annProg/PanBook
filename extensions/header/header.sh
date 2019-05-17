_G[ext-header]="addHeader"
getArrayVal _G "ext-header-on" true

function addHeader() {
	if [ "${_G[ext-header-on]}"x == "true"x ];then
		_F[add-header]="--lua-filter $SCRIPTDIR/${_G[extdir]}/header/add-header.lua"
	fi
}

function headerHelp() {
	echo -e "\t-G ext-header-on:<true|false> enable add header(default true)"
	exit 0
}