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
	source <(parse_yaml $METADATA)
	source <(parse_yaml $METADATA |grep "_item=" |sed 's/_item//' |tr -d '"' |awk -F'=' '{print $1"=\""$2"`[ \"$"$1"\"x != \"\"x ] && echo \", $"$1"\"`\""}')
}

function setPandocVar() {
	echo "$PANDOCVARS" |grep -w "$1" &>/dev/null || PANDOCVARS="$PANDOCVARS -V $1=$2"
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


function compileStatus() {
	status=$?
	info "$1 Compile status: $status"
	if [ $status -ne 0 ];then
		error "$1 Compile status is not 0. Please Check. you may add -d or --trace to see more output"
	else
		note "$1 Compile SUCCESSFUL"
	fi
}

# 兼容不规范源码
function compatible()
{	
	# imgdir相对路径转绝对路径
	_G[imgdir]=`cd ${_G[imgdir]} && pwd`
	echo ${_G[imgdir]} |grep -w ${_G[workdir]} &>/dev/null && r=0 || r=1
	if [ $r -eq 0 ];then
		_G[imgdirrelative]=`echo ${_G[imgdir]}|sed "s#${_G[workdir]}#.#g"`
	else
		_G[imgdirrelative]=`echo ${_G[imgdir]}|sed "s#$CWD#..#g"`
	fi

	cd ${_G[build]}
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
				_G[body]=`echo ${_G[body]} |sed -r "s/($item | $item)//g"`
				[ $stype == "frontmatter" ] && _G[frontmatter]=$newName
				[ $stype == "backmatter" ] && _G[backmatter]=$newName
				[ $stype == "body" ] && _G[body]=$newName
			done
		done
	fi
}


function init()
{
	cd $WORKDIR

	# 模板, 支持用户自定义模板
	[ "$TPL"x != ""x ] && [ -d $SCRIPTDIR/templates/$TPL ] && cp -rfu $SCRIPTDIR/templates/$TPL/* $BUILD
	[ "$TPL"x != ""x ] && [ -d $cwd/templates/$TPL ] && cp -rfu $cwd/templates/$TPL/* $BUILD 2>/dev/null
	
	# 字体
	cp -rfu $SCRIPTDIR/fonts $BUILD
	[ -d $cwd/fonts ] && cp -rfu $cwd/fonts/* $BUILD/fonts/ 2>/dev/null
	
	# 此时还未复制书籍源码，build目录中的 template或者font中包含的 .md 文件应该被删除
	rm -f $BUILD/*.md
	
	# 文件名规范
	FRONTMATTER="frontmatter.md"
	BACKMATTER="backmatter.md"
	chapters=`ls *.md 2>/dev/null |grep -vE "$FRONTMATTER|$BACKMATTER"`
	BODY="$chapters"
	
	# 前言和后记部分
	[ ! -f $FRONTMATTER ] && touch $FRONTMATTER
	[ ! -f $BACKMATTER ] && touch $BACKMATTER
	[ ! -f $BIB ] && touch $BIB
	
	# 支持不生成默认metadata.yaml
	if [ "$1"x != "nometa"x ];then
		[ ! -f metadata.yaml ] && meta > metadata.yaml
	fi
	
	if [ "$BODY"x == ""x ];then
		error "No markdown source file"
	fi
	
	[ "$DEBUG"x = "true"x ] && highlightStyle=(tango)
	
	# 复制$SRC目录下资源文件到build目录
	cp -rf $WORKDIR/* $BUILD
	cd $BUILD
	
	# 清空$HEADERS 以后都是追加
	echo > $HEADERS
	
	info "Template is: $TPL"
	templateError
	
	# 兼容性处理
	compatible
}

function setStyle() {
	List=($@)	
	SELECTED=(${_G[style]})
	
	if [ "${_G[style]}"x == "R"x ];then
		len=`echo ${#List[@]}`
		index=$(($RANDOM%$len))	
		SELECTED=(${List[$index]})
	fi
		
	if [ "${_G[style]}"x == "A"x ];then
		SELECTED=`echo ${List[@]}`
	fi
	
	_G[selected-style]="${SELECTED[@]}"
}
