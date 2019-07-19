regext fontawesome5
getArrayVar _G "ext-fontawesome5" `enableExt 00001`

function ext_fontawesome5() {
	if [ "${_G[ext-fontawesome5]}"x == "true"x ];then
		# 修复moderncv conflict with fontawesome5
		cp $SCRIPTDIR/${_G[extdir]}/fontawesome5/moderncviconsawesome.sty ${_G[build]}

		extStat fontawesome5 done
	else
		extStat fontawesome5 skip
	fi
}

function ext_fontawesome5_help() {
	echo -e "\t-G ext-fontawesome5:<true|false>                      enable fontawesome5(default true)"
	exit 0
}