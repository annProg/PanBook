regext copyright
getArrayVar _G "ext-copyright" true
_G[ext_copyright_filter]="$SCRIPTDIR/${_G[ext_copyright]}/fenced_divs_columns.lua"
getArrayVar _G ext_copyright_tex "$SCRIPTDIR/${_G[ext_copyright]}/add-copyright-page.tex"

function ext_copyright() {
	getArrayVar _V licence "ccncnd"
	if [ "${_G[ext-copyright]}"x == "true"x ];then
		_F[copyright]="--lua-filter ${_G[ext_copyright_filter]}"
	fi
}

function ext_copyright_help() {
	echo -e "\t-G ext-copyright:<true|false>                        enable copyright(default true)"
	echo -e "\t-G ext-copyright-tex:<custom copyright sty file>     change copyright sty file"
	exit 0
}