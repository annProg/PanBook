_G[ext_copyright]="$SCRIPTDIR/extensions/copyright"
_G[ext_copyright_on]="extCopyrightPage"
_G[ext_copyright_filter]="${_G[ext_copyright]}/fenced_divs_columns.lua"

function extCopyrightPage() {
	getVar copyright "true"
	getVar licence "ccncnd"
	getVar COPYPAGE "$SCRIPTDIR/templates/latex/add-copyright-page.tex"
	if [ "$copyright"x == "true"x ];then
		copyoption="-V copyright=true -V licence=$licence"	
	fi
}
