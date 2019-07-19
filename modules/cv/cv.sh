# 注册模块及帮助信息
regmod cv
_H[cv]="make curriculum vitae"

function cvMeta() {
	initBody cv.md
	initBib
	initMakefile
	photoFile=${_G[imgdir]}/photo.png
	[ ! -f $photoFile ] && cp $SCRIPTDIR/${_G[moduledir]}/${_G[function]}/src/images/photo.png $photoFile	
	
	# cv不需要单独的metadata file
	unset _P[metadata-file]
	unset _G[crossref]
}

function func_cv() {
	getArrayVar _G style "moderncv"
	cvMeta
	init
	_copystyle
	_patch
	
	# 启用扩展
	execExtensions

	getPandocParam
	getXeLaTeXParam
	pandoc ${_G[pandoc-param]}
	
	# 删除空行，空行会被认为是分段，处理很麻烦。干脆全删掉。一般简历中需要用分段的场景是求职信，
	# 转求职信的时候用\par显式分段
	sed -i '/^$/d' ${_G[ofile]}.${_G[t]}
	
	latexmk -xelatex ${_G[xelatex]} -output-directory=${_G[build]} ${_G[ofile]}.${_G[t]}
	compileStatus ${_G[function]}	
}

function func_cv_help() {
	echo -e "  Usage:\n\tpanbook cv -h <style>"
	exit 0
}