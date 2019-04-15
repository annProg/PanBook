function html()
{	
	getVar TPL "html5"
	init
	pdf2jpg # html中使用jpg图片，因此需要为pdf格式的插图准备同名jpg
	
	cd $BUILD
	for theme in ${highlightStyle[@]}
	do
		source $SCRIPTDIR/config.default
		[ -f $cwd/config ] && source $cwd/config
	
		HTML_OUTPUT="$BUILD/$ofile-$TPL-$theme.html"
		pandoc --self-contained $FRONTMATTER $BODY $BACKMATTER -o $HTML_OUTPUT $HTML_OPTIONS --metadata-file=$METADATA $TEMPLATE
		compileStatus HTML
	done	
	
	clean
}

