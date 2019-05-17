#!/bin/bash

# 保存网络图片至本地
function saveimg() 
{
	cd ${_G[imgdir]}
	for item in `ls $WORKDIR/*.md`;do
		for url in `grep -E "^\!\[.*?\]\(http(s)?://.*\)" $item |awk -F"(" '{print $2}' |tr -d ')'`;do
			wget -m -np $url
			localpath=`echo $url |sed -r 's#http(s)?://##g'`
			echo $localpath |grep -E "\.gif$" && r=0 || r=1
			if [ $r -eq 0 ];then
				new=`echo $localpath |sed -r "s/\.gif$//g"`
				${_G[convert]} $localpath $new.eps
				mv $new-0.eps $new.eps 2>/dev/null
				rm -f $new-*.eps
			fi
		done
	done
	cd $CWD
}

function toeps()
{
	cd ${_G[imgdir]}
	for item in `ls *.$1`;do
		new=`echo $item |sed -r "s/.$1$//g"`
		${_G[convert]} $item $new.eps
		mv $new-0.eps $new.eps 2>/dev/null
		rm -f $new-*.eps
	done
	cd $CWD
}

# 转换为eps格式
function eps()
{
	toeps gif
}

function pdf2jpg()
{
	cd ${_G[build]}
	for id in ${_G[body]} ${_G[frontmatter]} ${_G[backmatter]};do
		sed -i -r 's/(!\[.*?\]\(.*?)(\.pdf\))/\1.jpg)/g' $id
	done
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

function initMetadataFile() {
	if [ ! -f ${_P[metadata-file]} ];then
		if [ "$1"x == "true"x ];then
			cp ${_G[exampledir]}/${_G[function]}/src/metadata.yaml ${_P[metadata-file]}
		fi
	fi
}

# 初始化 frontmatter 和 backmatter
function initMatter() {
	$# -lt 1 && return 0
	if [ ! -f ${_G[workdir]}/${_G[$1]} ];then
		if [ "$2"x == "true"x ];then
			cp ${_G[exampledir]}/${_G[function]}/src/${_G[$1]} ${_G[workdir]}/${_G[$1]}
		fi
	fi
}

function initBib() {
	if [ ! -f ${_P[bibliography]} ];then
		if [ "$1"x == "true"x ];then
			cp ${_G[exampledir]}/${_G[function]}/src/bibliography.bib ${_P[bibliography]}
		fi
	fi	
}

function initBody() {
	cd ${_G[workdir]}
	_G[body]=`ls *.md 2>/dev/null |grep -vE "${_G[frontmatter]}|${_G[backmatter]}"`
	# 兼容性处理
	compatible
	
	bodyfile=$1
	[ "$bodyfile"x == ""x ] && bodyfile=${_G[defaultbody]}
	if [ "${_G[body]}"x == ""x ];then
		cp ${_G[exampledir]}/${_G[function]}/src/$bodyfile ${_G[workdir]}
		_G[body]=`ls *.md 2>/dev/null |grep -vE "${_G[frontmatter]}|${_G[backmatter]}"`
	fi
}

function initMakefile() {
	if [ ! -f $CWD/Makefile ];then
		cp ${_G[exampledir]}/${_G[function]}/Makefile $CWD
	fi
}

# 用户定义的模板、字体复制到 build 目录
function userDefined() {
	if [ "${_P[template]}"x != ""x ];then
		cp -rfu $SCRIPTDIR/${_G[tpldir]}/${_P[template]}/* ${_G[build']} 2>/dev/null
		cp -rfu $CWD/${_G[tpldir]}/${_P[template]}/* ${_G[build']} 2>/dev/null
		[ ! -f $CWD/build/${_P[template]}.tpl ] && _error "Template ${_P[template]} not found."
	fi
	
	cp -rfu $SCRIPTDIR/${_G[fontdir]}/* ${_G[build]}/${_G[fontdir]} 2>/dev/null
	cp -rfu $CWD/${_G[fontdir]}/* ${_G[build]}/${_G[fontdir]} 2>/dev/null

	# 此时还未复制书籍源码，build目录中的 template或者font中包含的 .md 文件应该被删除
	rm -f ${_G[build]}/*.md
}

function init()
{
	# 复制$SRC目录下资源文件到build目录
	cp -rf ${_G[workdir]}/* ${_G[build]}
	cd ${_G[build]}
	
	# 清空$HEADERS 以后都是追加
	echo > ${_G[header]}	
}

# 随机数，加随机数是处理repeat for multiple options的情况
function _random() {
	echo $(($RANDOM$RANDOM$RANDOM%1000000))
}

function setV() {
	vKey="`echo $1 |awk -F':' '{print $1}'`__`_random`"
	_V[$vKey]="`echo $1|awk -F':' '{print $2}'`"
}

function setM() {
	mKey="`echo $1 |awk -F':' '{print $1}'`__`_random`"
	_M[$mKey]="`echo $1|awk -F':' '{print $2}'`"
}

# 只允许重置 ext_ 开头的全局变量
function setG() {
	mKey="`echo $1 |awk -F':' '{print $1}'`"
	echo $mKey |grep "^ext_" &>/dev/null && r=0 || r=1
	[ $r -eq 0 ] && _G[$mKey]="`echo $1|awk -F':' '{print $2}'`"
}

function setP() {
	[ "$1"x == ""x ] && return
	pKey="`echo $1|sed 's/^--//g'|awk -F'=' '{print $1}'`__`_random`"
	pVal=`echo $1|awk -F'=' '{print $2}'`
	[ "$pVal"x == ""x ] && pVal=""
	_P[$pKey]=$pVal
}

function getV() {
	for k in ${!_V[@]};do
		_G[v]="${_G[v]} -V `echo $k |sed 's/__.*//g'`:${_V[$k]}"
	done
}

function getM() {
	for k in ${!_M[@]};do
		_G[m]="${_G[m]} -M `echo $k |sed 's/__.*//g'`:${_M[$k]}"
	done
}

function getP() {
	for k in ${!_P[@]};do
		newkey=`echo $k |sed 's/__.*//g'`
		if [ "$newkey" == "bibliography"x ];then
			_G[citeproc]="${_G[citeproc} --$newkey=${_P[$k]}"
		elif [ "${_P[$k]}"x == ""x ];then
			_G[p]="${_G[p]} --$newkey"
		else
			_G[p]="${_G[p]} --$newkey=${_P[$k]}"
		fi
	done	
}

function getF() {
	# lua filter
	for item in ${_F[@]};do
		_G[f]="${_G[f]} $item"
	done
}

function getPandocParam() {
	getV
	getM
	getP
	getF
	_G[crossref]="${_G[crossref]} -M 'crossrefYaml=${_G[crs]}'"
	_G[pandoc-param]="${_G[crossref]} ${_G[citeproc]} ${_P[bibliography]} ${_G[f]} ${_G[p]} ${_G[v]} ${_G[m]} ${_G[body]} -o ${_G[ofile]}.${_G[t]}"
}

function getXeLaTeXParam() {
	_G[xelatex]="${_G[interaction]}"
}