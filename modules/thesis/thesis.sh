regmod thesis
_H[thesis]="make thesis"

function func_thesis()
{
	getVar TPL "latex"
	getVar DOCUMENTCLASS "elegantpaper"
	classList=(elegantpaper)
	pdf "thesis" "${classList[*]}"
}
