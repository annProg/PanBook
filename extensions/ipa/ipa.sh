regext ipa
getArrayVar _G "ext-ipa" true
getArrayVar _G "ext-ipa-tex" "$SCRIPTDIR/${_G[extdir]}/ipa/ipa.tex"

function ext_ipa() {
	# 依赖add header功能
	if [ "${_G[ext-ipa]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-ipa-tex]}
		_F[ipa]="--lua-filter $SCRIPTDIR/${_G[extdir]}/ipa/ipa.lua"

		extStat ipa done
	else
		extStat ipa skip
	fi
}

function ext_ipa_help() {
	echo -e "\t-G ext-ipa:<true|false>                        enable ipa(default true)"
	echo -e "\t-G ext-ipa-tex:<custom ipa set file>         change ipa set file"
	exit 0
}