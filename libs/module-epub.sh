function epub()
{
	getEnv TPL "epub"
	getEnv CSS "epub"
	addCss=""
	[ "$CSS"x != ""x ] && addCss="--css=$BUILD/css/$CSS.css"
	
	init
	pdf2jpg		

	cd $BUILD
	merge="/tmp/epub-meta-"`echo $RANDOM$RANDOM$RANDOM$RANDOM`
	cat $METADATA > $merge
	echo -e "\n\n\n" >> $merge
	cat $FRONTMATTER >> $merge
	mv $merge $FRONTMATTER

	for theme in ${highlightStyle[@]}
	do
		info "Epub compile theme: $theme"
		source $SCRIPTDIR/config.default
		[ -f $cwd/config ] && source $cwd/config
		EPUB_OUTPUT="$BUILD/$ofile-$TPL-$theme.epub"
		info "Epub compile Options: $EPUB_OPTIONS"
		info "Epub Output: $EPUB_OUTPUT"
		pandoc $FRONTMATTER $BODY $BACKMATTER -o $EPUB_OUTPUT $EPUB_OPTIONS $TEMPLATE $addCss --metadata date="$DATETIME"
		compileStatus Epub
	done
	
	clean
}