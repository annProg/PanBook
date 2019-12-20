# 注册模块及帮助信息
regmod slide
_H[slide]="make slide"

function func_slide() {
	initBody slide.md
	initBib
	initMakefile
	initMetadataFile

	getArrayVar _G style metropolis
	getArrayVar _V documentclass ctexbeamer
	getArrayVar _V classoption "aspectratio=169"
	_V[theme]=${_G[style]}

	init
	_copystyle
	_patch

	# 启用扩展
	execExtensions

	if [ "${_G[debug]}"x != "true"x ];then
		_G[t]=pdf
	else
		_P[standalone]=""
	fi

	# 默认模板给xeCJK加了个选项，导致不能编译，见 https://github.com/jgm/pandoc/pull/5855
	[ "${_P[template]}"x == ""x ] && _P[template]="${_G[scriptdir]}/${_G[tpldir]}/latex/latex.tpl"

	_P[to]=beamer
	getPandocParam
	eval ${_G[pandoc-param]}
	compileStatus ${_G[function]}
}
