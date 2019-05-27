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

	getArrayVar _G style ctexbook
	getArrayVar _P "top-level-division" "chapter"
	init
	_P[metadata-file]=${_P[metadata-file]}

	_copystyle
	_patch


	# 版权页(todo)
	#copyrightPage
	#[ "$copyright"x == "true"x ] && (cat $COPYPAGE;echo) >> $HEADERS

	# 生成前言和后记
	custom_filter=${_F[style-${_G[function]}-${_G[style]}]}
	
	if [ ${_G[t]} == "tex" ];then
		getArrayVar _V documentclass ctexbook
		getArrayVar _V device pc

		# 启用扩展
		ext_header
		ext_listings
		ext_grade
		ext_column

		pandoc ${_G[frontmatter]} -o frontmatter.tex --listings --top-level-division=${_P[top-level-division]} $custom_filter
		pandoc ${_G[backmatter]} -o backmatter.tex --listings --top-level-division=${_P[top-level-division]} $custom_filter
		_G[ofile]=${_G[ofile]}-${_V[device]}
		_P[include-before-body]=frontmatter.tex
		_P[include-after-body]=backmatter.tex
	fi

	getPandocParam
	getXeLaTeXParam
	pandoc ${_G[pandoc-param]}

	# 非tex时不用xelatex编译
	if [ ${_G[t]} == "tex" ];then
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
	fi
	compileStatus ${_G[function]}
}

function func_book_help()
{
	note "use -V copyright=(true|false) to control whether or not to compile copyright page"
	note "use -V licence=(ccnd|ccnc|ccncnd|ccncsa|ccncsand|pd"
}