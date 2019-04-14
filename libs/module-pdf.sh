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
	getEnv TPL "ctex"
	getEnv DOCUMENT "ctexbook"
	getEnv PAGESTYLE ""
	getEnv CJK ""
	init  # 首先初始化
	
	# 判断设备类型
	getEnv DEVICE "pc"
	
	# elegantbook 模板选项
	getEnv ELEGANT "cn"
	
	# ctex模板随机选用封面背景
	getEnv COVER "29"
	if [ "$COVER"x == "r"x ];then
		background="images/$(($RANDOM%60)).png"
	else
		background="images/$COVER.png"
	fi
		
	# 根据模板适配变量
	pagestyle	
	source $SCRIPTDIR/config.default		
	[ -f $cwd/config ] && source $cwd/config
	
	cd $BUILD
	# 生成前言和后记
	pandoc -t latex $FRONTMATTER --top-level-division=$DIVISION --listings -o frontmatter.tex
	pandoc -t latex $BACKMATTER --top-level-division=$DIVISION --listings -o backmatter.tex

	TEX_OUTPUT="$ofile-$TPL-$DEVICE.tex"
	pandoc $BODY -o $TEX_OUTPUT $PDF_OPTIONS -B frontmatter.tex -A backmatter.tex --metadata-file=$METADATA $TEMPLATE -V device=$DEVICE -V elegantoption=$ELEGANT -V date="\today" -V background=$background $COMPLEXOPTION
	
	#sed -i 's/\DefineVerbatimEnvironment{Highlighting}.*/\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\\\\{\\},fontsize=\\small,xleftmargin=3mm,frame=lines}/g' $TEX_OUTPUT
	sed -i -E "/begin\{lstlisting.*label.*\]/ s/caption=(.*)?,\s*label=(.*)\]/caption=\1, label=\2, float=htbp\]/" $TEX_OUTPUT
	sed -i -E "/begin\{lstlisting.*label.*\]/ s/\[label=(.*)?\]/\[label=\1, caption=\1, float=htbp\]/" $TEX_OUTPUT
	#sed -i -E "s/begin\{lstlisting\}$/begin\{lstlisting\}\[float=htbp\]/g" $TEX_OUTPUT
	#sed -i "s/\.jpg/\.eps/g" $TEX_OUTPUT
	
	# gif格式图片编译报错，需要引用eps格式，需转换后使用
	sed -i -r "s#(\includegraphics\{.*?).(gif)(\})#\1.eps\3#g" $TEX_OUTPUT
	
	# 网络图片需要替换为本地文件
	sed -i -r "s#(\includegraphics\{)http(s)?://(.*)#\1$IMGDIRRELATIVE/\3#g" $TEX_OUTPUT
	
	xelatex -output-directory=$BUILD $TEX_OUTPUT #1&>/dev/null
	xelatex -output-directory=$BUILD $TEX_OUTPUT #1&>/dev/null
	compileStatus PDF
	
	clean
}
