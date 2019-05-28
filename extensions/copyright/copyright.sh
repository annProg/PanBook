regext copyright
getArrayVar _G "ext-copyright" true
getArrayVar _G ext-copyright-tex "$SCRIPTDIR/${_G[extdir]}/copyright/add-copyright-page.tex"

function ext_copyright() {
	getArrayVar _V licence "ccncnd"
	if [ "${_G[ext-copyright]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader "${_G[ext-copyright-tex]}"
	fi
}

function ext_copyright_help() {
	echo -e "\t-G ext-copyright:<true|false>                        enable copyright(default true)"
	echo -e "\t-G ext-copyright-tex:<custom copyright sty file>     change copyright sty file"
	exit 0
}