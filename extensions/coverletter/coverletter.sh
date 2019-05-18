_G[ext-coverletter]="addcoverletter"
getArrayVal _G "ext-coverletter-on" true
getArrayVal _G "ext-coverletter-sty" "$SCRIPTDIR/${_G[extdir]}/coverletter/coverletter.sty"

function addcoverletter() {
	if [ "${_G[ext-coverletter-on]}"x == "true"x ];then
		cp ${_G[ext-coverletter-sty]} ${_G[build]}
		echo -e "\n\\usepackage{coverletter}\n" >> ${_G[header]}
	fi
}

function coverletterHelp() {
	echo -e "\t-G ext-coverletter-on:<true|false>                     enable coverletter(default true)"
	echo -e "\t-G ext-coverletter-sty:<custom coverletter sty file>   change coverletter sty file"
	exit 0
}