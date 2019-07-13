# 注册模块及帮助信息
regmod book
_H[book]="make ebook"

function func_book() {
	initBody
	initBib
	initMetadataFile
	initMatter frontmatter
	initMatter backmatter
	initMakefile
	initVscodeTask

	getArrayVar _G style ctexbook
	getArrayVar _P "top-level-division" "chapter"
	init
	_P[metadata-file]=${_P[metadata-file]}

	_copystyle
	_patch


	# 版权页(todo)
	getArrayVar _V copyright true
	getArrayVar _V licence ccnd
	getArrayVar _V documentclass ctexbook
	getArrayVar _V device pc
	_G[ofile]=${_G[ofile]}-${_V[device]}
	# 生成前言和后记
	custom_filter=${_F[style-${_G[function]}-${_G[style]}]}

	# 启用扩展
	ext_header
	ext_listings
	ext_grade
	ext_column
	ext_copyright
	ext_longtable
	ext_zh_en
	ext_lineblock

	getFF
	if [ ${_G[t]} == "tex" ];then
		pandoc ${_G[frontmatter]} -o frontmatter.tex ${_G[highlight]} --top-level-division=${_P[top-level-division]} $custom_filter ${_G[ff]}
		pandoc ${_G[backmatter]} -o backmatter.tex ${_G[highlight]} --top-level-division=${_P[top-level-division]} $custom_filter

		_P[include-before-body]=frontmatter.tex
		_P[include-after-body]=backmatter.tex
	fi

	partCompile
	getPandocParam
	getXeLaTeXParam
	pandoc ${_G[pandoc-param]}

	# 非tex时不用xelatex编译
	if [ ${_G[t]} == "tex" ];then
		TEX_OUTPUT=${_G[ofile]}.${_G[t]}
		# gif格式图片编译报错，需要引用eps格式，需转换后使用
		sed -i -r "s#(\includegraphics\{.*?).(gif)(\})#\1.eps\3#g" $TEX_OUTPUT
		# 网络图片需要替换为本地文件
		sed -i -r "s#(\includegraphics\{)http(s)?://(.*)#\1${_G[imgdirrelative]}/\3#g" $TEX_OUTPUT

		floatListings $TEX_OUTPUT

		latexmk -xelatex ${_G[xelatex]} -output-directory=${_G[build]} $TEX_OUTPUT #1&>/dev/null
	fi
	compileStatus ${_G[function]}
}

function func_book_help()
{
	note "use -V copyright=(true|false) to control whether or not to compile copyright page"
	note "use -V licence=(ccnd|ccnc|ccncnd|ccncsa|ccncsand|pd"
}