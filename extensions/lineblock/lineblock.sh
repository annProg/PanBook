regext lineblock
# 通用扩展
getArrayVar _G "ext-lineblock" true
getArrayVar _G "ext-lineblock-tex" "$SCRIPTDIR/${_G[extdir]}/lineblock/lineblock.tex"

function ext_lineblock() {
	# 依赖add header功能
	if [ "${_G[ext-lineblock]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-lineblock-tex]}
		_F[lineblock]="--lua-filter $SCRIPTDIR/${_G[extdir]}/lineblock/lineblock.lua"

		extStat lineblock done
	else
		extStat lineblock skip
	fi
}

function ext_lineblock_help() {
	echo -e "\t-G ext-lineblock:<true|false>                        enable lineblock(default true)"
	echo -e "\t-G ext-lineblock-tex:<custom lineblock set file>     change lineblock set file"
	exit 0
}