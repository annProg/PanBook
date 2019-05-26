# 注册模块及帮助信息
regmod thesis
_H[thesis]="make thesis"

function func_thesis() {
	initBody
	initBib true
	initMetadataFile
	initMatter ${_G[frontmatter]}
	initMatter ${_G[backmatter]}
	initMakefile

	getArrayVar _G style elegantpaper
	getArrayVar _P "top-level-division" "chapter"
	init
	_P[metadata-file]=${_P[metadata-file]}

	_copystyle
	_patch

	# 生成前言和后记
	custom_filter=${_F[style-${_G[function]}-${_G[style]}]}
	
	getArrayVar _V documentclass elegantpaper

	# 启用扩展
	ext_header
	ext_listings
	ext_grade
	ext_column

	pandoc ${_G[frontmatter]} -o frontmatter.tex --listings --top-level-division=${_P[top-level-division]} $custom_filter
	pandoc ${_G[backmatter]} -o backmatter.tex --listings --top-level-division=${_P[top-level-division]} $custom_filter
	_P[include-before-body]=frontmatter.tex
	_P[include-after-body]=backmatter.tex

	getPandocParam
	getXeLaTeXParam
	pandoc ${_G[pandoc-param]}

	TEX_OUTPUT=${_G[ofile]}.${_G[t]}
	# 以下2行是干嘛的？
	sed -i -E "/begin\{lstlisting.*label.*\]/ s/caption=(.*)?,\s*label=(.*)\]/caption=\1, label=\2, float=htbp\]/" $TEX_OUTPUT
	sed -i -E "/begin\{lstlisting.*label.*\]/ s/\[label=(.*)?\]/\[label=\1, caption=\1, float=htbp\]/" $TEX_OUTPUT
	# gif格式图片编译报错，需要引用eps格式，需转换后使用
	sed -i -r "s#(\includegraphics\{.*?).(gif)(\})#\1.eps\3#g" $TEX_OUTPUT
	# 网络图片需要替换为本地文件
	sed -i -r "s#(\includegraphics\{)http(s)?://(.*)#\1${_G[imgdirrelative]}/\3#g" $TEX_OUTPUT

	xelatex ${_G[xelatex]} -output-directory=${_G[build]} $TEX_OUTPUT #1&>/dev/null
	xelatex ${_G[xelatex]} -output-directory=${_G[build]} $TEX_OUTPUT #1&>/dev/null
	compileStatus ${_G[function]}
}

function func_thesis_help()
{
	echo "no help"
}