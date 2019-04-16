#!/bin/bash

function meta() {
	cat $SCRIPTDIR/src/metadata.yaml
}

function parse_yaml {
   # from: https://stackoverflow.com/questions/5014632/how-can-i-parse-a-yaml-file-from-a-linux-shell-script
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -r 's/\s+#.*$//g' $1 |sed 's/- /item: /g'|sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

function parseMeta() {
	# 仅支持key全为字母
	source <(parse_yaml $METADATA |sed 's/_item//' |tr -d '"' |awk -F'=' '{print $1"=\""$2"`[ \"$"$1"\"x != \"\"x ] && echo \", $"$1"\"`\""}')
}

function setPandocVar() {
	echo "$PANDOCVARS" |grep -w "$1" &>/dev/null || PANDOCVARS="$PANDOCVARS -V $1=$2"
}

function clean() {
	cd $BUILD
	rand=`echo $RANDOM$RANDOM$RANDOM$RANDOM`
	release="/tmp/release-$rand"
	mkdir $release
	mv *.pdf *.tex *.epub *.html $release 2>/dev/null
	rm -fr *
	mv $release/* .
	rm -fr $release
}

function cleanall()
{
	cd $BUILD
	rm -fr *
}

# 保存网络图片至本地
function saveimg() 
{
	cd $IMGDIR
	for item in `ls $WORKDIR/*.md`;do
		for url in `grep -E "^\!\[.*?\]\(http(s)?://.*\)" $item |awk -F"(" '{print $2}' |tr -d ')'`;do
			wget -m -np $url
			localpath=`echo $url |sed -r 's#http(s)?://##g'`
			echo $localpath |grep -E "\.gif$" && r=0 || r=1
			if [ $r -eq 0 ];then
				new=`echo $localpath |sed -r "s/\.gif$//g"`
				$CMD_CONVERT $localpath $new.eps
				mv $new-0.eps $new.eps 2>/dev/null
				rm -f $new-*.eps
			fi
		done
	done
	cd $cwd
}

function toeps()
{
	cd $IMGDIR
	for item in `ls *.$1`;do
		new=`echo $item |sed -r "s/.$1$//g"`
		$CMD_CONVERT $item $new.eps
		mv $new-0.eps $new.eps 2>/dev/null
		rm -f $new-*.eps
	done
	cd $cwd
}

# 转换为eps格式
function eps()
{
	toeps gif
}

function pdf2jpg()
{
	cd $BUILD
	for id in $BODY $FRONTMATTER $BACKMATTER;do
		sed -i -r 's/(!\[.*?\]\(.*?)(\.pdf\))/\1.jpg)/g' $id
	done
}

function templateError() {
	# TPL变量为空时不做判断
	[ "$TPL"x == ""x ] && return
	# 指定template不存在时用默认模板编译
	TEMPLATE="--template=$cwd/build/$TPL.tpl"
	[ ! -f $cwd/build/$TPL.tpl ] && error "Template $TPL not found." && exit 1 #TEMPLATE="-V CJKmainfont=$CJK -V documentclass=ctexbook"	
}

function compileStatus() {
	status=$?
	info "$1 Compile status: $status"
	if [ $status -ne 0 ];then
		error "$1 Compile status is not 0. Please Check. you may add -d to see more output"
	else
		note "$1 Compile SUCCESSFUL"
	fi
}

# 兼容不规范源码
function compatible()
{	
	# IMGDIR 相对路径
	IMGDIRFULL=`cd $IMGDIR && pwd`
	echo $IMGDIRFULL |grep -w $WORKDIR &>/dev/null && r=0 || r=1
	info "IMGDIR=$IMGDIRFULL"
	if [ $r -eq 0 ];then
		IMGDIRRELATIVE=`echo $IMGDIRFULL|sed "s#$WORKDIR#.#g"`
	else
		IMGDIRRELATIVE=`echo $IMGDIRFULL|sed "s#$cwd#..#g"`
	fi

	cd $BUILD
	COMPATIBLE="compatible.conf"
	PREFIX="PanBook-compatible-"
	if [ -f $COMPATIBLE ];then
		for stype in frontmatter backmatter body exclude;do
			newName=$PREFIX$stype.md
			echo > $newName
			for item in `grep -E "$stype$" $COMPATIBLE |awk '{print $1}'`;do
				if [ "$stype" == "exclude" ];then
					rm -f $item
				else
					cat $item >> $newName
					echo -e "\n\n" >> $newName
				fi
				
				# 被删除及写入frontmatter和backmatter的源码，需要从BODY中排除
				BODY=`echo $BODY |sed -r "s/($item | $item)//g"`
				[ $stype == "frontmatter" ] && FRONTMATTER=$newName
				[ $stype == "backmatter" ] && BACKMATTER=$newName
				[ $stype == "body" ] && BODY=$newName				
			done
		done
	fi
}

function init()
{
	[ ! -d $BUILD ] && mkdir $BUILD
	[ ! -d $WORKDIR ] && mkdir $WORKDIR
	[ ! -d $IMGDIR ] && mkdir $IMGDIR
	[ ! -d $cwd/templates ] && mkdir $cwd/templates
	[ ! -d $cwd/fonts ] && mkdir $cwd/fonts

	cd $WORKDIR

	# 模板, 支持用户自定义模板
	[ -d $SCRIPTDIR/templates/$TPL ] && cp -rfu $SCRIPTDIR/templates/$TPL/* $BUILD
	[ -d $cwd/templates/$TPL ] && cp -rfu $cwd/templates/$TPL/* $BUILD 2>/dev/null
	
	# 字体
	cp -rfu $SCRIPTDIR/fonts $BUILD
	[ -d $cwd/fonts ] && cp -rfu $cwd/fonts/* $BUILD/fonts/ 2>/dev/null
	
	# 此时还未复制书籍源码，build目录中的 template或者font中包含的 .md 文件应该被删除
	rm -f $BUILD/*.md
	
	# 文件名规范
	FRONTMATTER="frontmatter.md"
	BACKMATTER="backmatter.md"
	chapters=`ls *.md |grep -vE "$FRONTMATTER|$BACKMATTER" 2>/dev/null`
	BODY="$chapters"
	
	# 前言和后记部分
	[ ! -f $FRONTMATTER ] && touch $FRONTMATTER
	[ ! -f $BACKMATTER ] && touch $BACKMATTER
	[ ! -f metadata.yaml ] && meta > metadata.yaml
	[ "$DEBUG"x = "true"x ] && highlightStyle=(tango)
	
	# 复制$SRC目录下资源文件到build目录
	cp -rf $WORKDIR/* $BUILD
	cd $BUILD
	
	info "Template is: $TPL"
	templateError
	
	# 兼容性处理
	compatible
}

function setBase() {
	Type=$1
	Select=$2
	List=$3
	
	SELECTED=($Select)
	
	if [ "$Select"x == "R"x ];then
		len=`echo ${#List[@]}`
		index=$(($RANDOM%$len))	
		SELECTED=(${List[$index]})
	fi
		
	if [ "$Select"x == "A"x ];then
		SELECTED=`echo ${themeList[@]}`
	fi
	
	info "SELECTED $Type: $SELECTED"
	if [ "$TPL"x != ""x ];then
		origAddOptions="--template=$TPL.tpl"
	else
		origAddOptions=""
	fi
	
	origHighLight="--listings -H $SCRIPTDIR/templates/latex/listings-set.tex"
}
function setTheme() {
	setBase BeamerTheme $THEME $1	
}

function setClass() {
	setBase PdfClass $DOCUMENTCLASS $1
}

function copyrightPage() {	
	getVar copyright "true"
	getVar licence "ccncnd"
	
	if [ "$copyright"x == "true"x ];then
		echo "-H $SCRIPTDIR/templates/latex/add-copyright-page.tex -V copyright=true -V licence=$licence"	
	fi
}
