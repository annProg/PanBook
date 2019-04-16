# 设置一些变量
function pagestyle() {
	CLASSOPTION=""
	DIVISION="default"
	COMPLEXOPTION=""
	if [ "$PAGESTYLE"x == ""x ];then
		case $DOCUMENT in
		ctexbook) PAGESTYLE="fancy"; CLASSOPTION="-V classoption=fancyhdr"; DIVISION="chapter";;
		article) PAGESTYLE="headings"; DIVISION="default"; [ "$CJK"x == ""x ] && CJK="SimSun";;
		*) PAGESTYLE="plain";DIVISION="default"; [ "$CJK"x == ""x ] && CJK="SimSun";;
		esac
	fi
	
	if [ "$CJK"x != ""x ];then
		CJKOPT="-V CJKmainfont=$CJK"
	fi
	
	if [ "$TPL"x == "latex"x ];then
		COMPLEXOPTION="-V documentclass=$DOCUMENT $CLASSOPTION $CJKOPT -H listings-set.tex -V pagestyle=$PAGESTYLE -V geometry=top=1in -V geometry=inner=1in -V geometry=outer=1in -V geometry=bottom=1in -V geometry=headheight=3ex -V geometry=headsep=2ex"	
	fi
}

function pdf()
{
	getVar TPL "latex"
	getVar DOCUMENTCLASS "ctexbook"
	getVar device "pc"
	interaction="-interaction=batchmode"
	[ "$DEBUG"x == "true"x ] && interaction=""
	classList=(ctexbook book elegantbook ctexart article)
	
	init  # 首先初始化
			
	# 支持随机选取theme
	setClass $classList

	cd $BUILD	
	
	for t in ${SELECTED[@]};do
		note "pdfClass: $t"
		note "use -E copyright=(true|false) to control whether or not to compile copyright page"
		note "use -E licence=(ccnd|ccnc|ccncnd|ccncsa|ccncsand|pd"		
		addOptions="$origAddOptions"
		highLight="$origHighLight"
		PANDOCVARS="$ORIGPANDOCVARS"
		division="--top-level-division=default"
		
		# copy pdf class
		PDFCLASSDIR=$SCRIPTDIR/templates/pdfclasses/$t
		USERDEFINECLASS=$cwd/templates/pdfclasses/$t
		if [ -d $PDFCLASSDIR -o -d $USERDEFINECLASS ];then
			cp -rfu $PDFCLASSDIR $BUILD 2>/dev/null
			cp -rfu $USERDEFINECLASS $BUILD 2>/dev/null
			# 需要删除.md文件
			rm -f $t/*.md
			rm -f $t/*.pdf
			cp -rfu $t/* .
		fi
	
		PANDOCVARS="$PANDOCVARS -V documentclass=$t"
		
		# 打补丁. 补丁放在templates/pdfclasses/classname 文件夹下，命名规则 patch-$classname.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		# 版权页
		addOptions="$addOptions `copyrightPage`"
		
		info "PANDOCVARS: $PANDOCVARS"
		info "addOptions: $addOptions"
		info "highLight: $highLight"
		info "division: $division"
		
		# 生成前言和后记		
		pandoc -t latex $FRONTMATTER $division --listings -o frontmatter.tex
		pandoc -t latex $BACKMATTER $division --listings -o backmatter.tex
		
		source $SCRIPTDIR/config.default		
		[ -f $cwd/config ] && source $cwd/config

		TEX_OUTPUT="$ofile-$TPL-$t-$device.tex"
		PDF_OPTIONS="$PDF_OPTIONS -B frontmatter.tex -A backmatter.tex --metadata-file=$METADATA"
		pandoc $BODY -o $TEX_OUTPUT $PDF_OPTIONS $division $highLight $addOptions $PANDOCVARS
		
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/caption=(.*)?,\s*label=(.*)\]/caption=\1, label=\2, float=htbp\]/" $TEX_OUTPUT
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/\[label=(.*)?\]/\[label=\1, caption=\1, float=htbp\]/" $TEX_OUTPUT
		
		# gif格式图片编译报错，需要引用eps格式，需转换后使用
		sed -i -r "s#(\includegraphics\{.*?).(gif)(\})#\1.eps\3#g" $TEX_OUTPUT
		
		# 网络图片需要替换为本地文件
		sed -i -r "s#(\includegraphics\{)http(s)?://(.*)#\1$IMGDIRRELATIVE/\3#g" $TEX_OUTPUT
		
		xelatex $interaction -output-directory=$BUILD $TEX_OUTPUT #1&>/dev/null
		xelatex $interaction -output-directory=$BUILD $TEX_OUTPUT #1&>/dev/null
		compileStatus PDF
	done
	
	clean
}
