# 注册模块及帮助信息
regmod slide
_H[slide]="make slide"

function func_slide() {
	initBody cv.md
	initBib true
	initMakefile

	getArrayVar _G style metropolis
	getArrayVar _V documentclass ctexbeamer
	getArrayVar _V classoption "aspectratio=169"
	_V[theme]=${_G[style]}

	init
	_copystyle
	_patch

	# 启用扩展
	ext_header
	ext_listings
	ext_grade

	if [ "${_G[debug]}"x != "true"x ];then
		_G[t]=pdf
	else
		_P[standalone]=""
	fi

	_P[to]=beamer
	getPandocParam
	pandoc ${_G[pandoc-param]}
	compileStatus ${_G[function]}
}
