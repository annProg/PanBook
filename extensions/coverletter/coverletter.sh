regext coverletter
getArrayVar _G "ext-coverletter" `enableExt 00001`
getArrayVar _G "ext-coverletter-sty" "$SCRIPTDIR/${_G[extdir]}/coverletter/coverletter.sty"

function ext_coverletter() {
	if [ "${_G[ext-coverletter]}"x == "true"x ];then
		cp ${_G[ext-coverletter-sty]} ${_G[build]}
		echo -e "\n\\usepackage{coverletter}\n" >> ${_G[header]}

		extStat coverletter done
	else
		extStat coverletter skip
	fi
}

function ext_coverletter_help() {
	echo -e "\t-G ext-coverletter:<true|false>                        enable coverletter(default true)"
	echo -e "\t-G ext-coverletter-sty:<custom coverletter sty file>   change coverletter sty file"
	exit 0
}