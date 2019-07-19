regext longtable
# 通用扩展
getArrayVar _G "ext-longtable" true
getArrayVar _G "ext-longtable-sty" "$SCRIPTDIR/${_G[extdir]}/longtable/longtable.sty"

function ext_longtable() {
	if [ "${_G[ext-longtable]}"x == "true"x ];then
		cp ${_G[ext-longtable-sty]} ${_G[build]}

		extStat longtable done
	else
		extStat longtable skip
	fi
}

function ext_longtable_help() {
	echo -e "\t-G ext-longtable:<true|false>                      enable longtable(default true)"
	echo -e "\t-G ext-longtable-sty:<custom longtable sty file>   change longtable sty file"
	exit 0
}