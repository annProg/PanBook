# 注册模块及帮助信息
regmod thesis
_H[thesis]="make thesis"

function func_thesis() {
	initBody
	initBib
	initMetadataFile
	initMatter frontmatter
	initMatter backmatter
	initMakefile
	initVscodeTask

	getArrayVar _G style thesis
	getArrayVar _P "top-level-division" "chapter"
	init
	_P[metadata-file]=${_P[metadata-file]}

	_copystyle
	_patch
	
	getArrayVar _V documentclass thesis

	# 启用扩展
	execExtensions
	# 生成前言和后记
	pandoc ${_G[frontmatter]} -o frontmatter.tex ${_G[highlight]} --top-level-division=${_P[top-level-division]} ${_G[f0]} ${_G[f]}
	pandoc ${_G[backmatter]} -o backmatter.tex ${_G[highlight]} --top-level-division=${_P[top-level-division]} ${_G[f0]} ${_G[f]}
	_P[include-before-body]=frontmatter.tex
	_P[include-after-body]=backmatter.tex

	getPandocParam
	getXeLaTeXParam
	pandoc ${_G[pandoc-param]}

	TEX_OUTPUT=${_G[ofile]}.${_G[t]}

	floatListings $TEX_OUTPUT

	# gif格式图片编译报错，需要引用eps格式，需转换后使用
	sed -i -r "s#(\includegraphics\{.*?).(gif)(\})#\1.eps\3#g" $TEX_OUTPUT
	# 网络图片需要替换为本地文件
	sed -i -r "s#(\includegraphics\{)http(s)?://(.*)#\1${_G[imgdirrelative]}/\3#g" $TEX_OUTPUT


	latexmk -xelatex ${_G[xelatex]} -output-directory=${_G[build]} $TEX_OUTPUT #1&>/dev/null
	compileStatus ${_G[function]}
}

function func_thesis_help()
{
	echo "no help"
}