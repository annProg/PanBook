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
	for item in `ls *.$1 2>/dev/null`;do
		new=`echo $item |sed -r "s/.$1$//g"`
		${_G[convert]} $item $new.eps
		mv $new-0.eps $new.eps 2>/dev/null
		rm -f $new-*.eps
	done
	note "to Eps for $1 file:"
	ls -l *.eps 2>/dev/null
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
	
	# gif转换为eps格式
	cd ${_G[imgdirrelative]}
	ls *.gif &>/dev/null && toeps gif
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
		cp $SCRIPTDIR/${_G[moduledir]}/${_G[function]}/src/metadata.yaml ${_P[metadata-file]}
	fi
}

# 初始化 frontmatter 和 backmatter
function initMatter() {
	[ $# -lt 1 ] && return
	if [ ! -f ${_G[workdir]}/${_G[$1]} ];then
		cp $SCRIPTDIR/${_G[moduledir]}/${_G[function]}/src/${_G[$1]} ${_G[workdir]}/${_G[$1]}
	fi
}

function initBib() {
	if [ ! -f ${_P[bibliography]} ];then
		cp $SCRIPTDIR/${_G[moduledir]}/${_G[function]}/src/bibliography.bib ${_P[bibliography]}
	fi	
}

function getBody() {
	cd ${_G[workdir]}
	find ./ -name "*.md" 2>/dev/null |sort |grep -vE "${_G[frontmatter]}|${_G[backmatter]}"
}

function initBody() {
	cd ${_G[workdir]}
	_G[body]=`getBody`
	# 兼容性处理
	compatible
	
	bodyfile=$1
	[ "$bodyfile"x == ""x ] && bodyfile=${_G[defaultbody]}
	if [ "${_G[body]}"x == ""x ];then
		cp -ru $SCRIPTDIR/${_G[moduledir]}/${_G[function]}/src/$bodyfile ${_G[workdir]}
		_G[body]=`getBody`
	fi
}

function initMakefile() {
	if [ ! -f $CWD/Makefile ];then
		cp $SCRIPTDIR/${_G[moduledir]}/${_G[function]}/Makefile $CWD
	fi
}

function initVscodeTask() {
	[ ! -d $CWD/.vscode ] && mkdir $CWD/.vscode
	[ ! -f $CWD/.vscode/tasks.json ] && cp $SCRIPTDIR/.vscode/tasks.json $CWD/.vscode
}

# 用户定义的模板、字体复制到 build 目录
function userDefined() {
	if [ "${_P[template]}"x != ""x ];then
		cp -rfu $SCRIPTDIR/${_G[tpldir]}/${_P[template]}/* ${_G[build]} 2>/dev/null
		cp -rfu $CWD/${_G[tpldir]}/${_P[template]}/* ${_G[build]} 2>/dev/null
		_P[template]=${_P[template]}.tpl
		[ ! -f $CWD/build/${_P[template]} ] && _error "Template ${_P[template]} not found."
	fi
	
	cp -rfu $SCRIPTDIR/${_G[fontdir]} ${_G[build]}/${_G[fontdir]} 2>/dev/null
	cp -rfu $CWD/${_G[fontdir]}/* ${_G[build]}/${_G[fontdir]}/ 2>/dev/null

	# 此时还未复制书籍源码，build目录中的 template或者font中包含的 .md 文件应该被删除
	rm -f ${_G[build]}/*.md
}

function init()
{
	# userDefined函数会删除md文件，应先于cp执行
	userDefined
	# 复制$SRC目录下资源文件到build目录
	cp -rf ${_G[workdir]}/* ${_G[build]}
	
	# 保证子目录下章节换行
	for item in `ls -F ${_G[workdir]} |grep '/$'`;do
		# 保证换行
		sed -i '1i\\' ${_G[build]}/${item}*.md 2>/dev/null
	done
	
	cd ${_G[build]}

	# 清空$HEADERS 以后都是追加
	echo > ${_G[header]}
	[ "${_G[trace]}"x == "true"x -o "${_G[debug]}"x == "true"x ] && _G[interaction]="-interaction=nonstopmode -halt-on-error"
	cd ${_G[build]}
	_G[ofile]=${_G[build]}/${_G[ofile]}-${_G[function]}-${_G[style]}	
}

# 执行extension函数，由extension自行判断在moudles中是否启用
function execExtensions() {
	for id in `echo ${_G[extensions]} |tr ' ' '\n' |sort -u |tr '\n' ' '`;do
		ext_${id}
	done
}

function extStat() {
	_info "ext $1 ... [$2]"
}

# book,article,thesis,slide,cv 五位，取1表示开启，取0表示关闭，返回 true 或者 false
function enableExt() {
	declare -A moduleMap
	moduleMap=(
		[book]=0
		[art]=1
		[thesis]=2
		[slide]=3
		[cv]=4
	)

	param=$1
	func=${_G[function]}
	stat=${param:${moduleMap[$func]}:1}
	if [ $stat -eq 1 ];then
		echo "true"
	else
		echo "false"
	fi
}

function useCI() {
	ci=$1
	if [ "$ci"x == "--ci"x ];then
		_error "ci can not be empty. Please use --ci={val}"
	else
		_info "CI: $ci"
	fi
	cidir=$SCRIPTDIR/tools/ci
	case $ci in
	drone) [ ! -f $CWD/.drone.yml ] && cat $cidir/.drone.yml|sed "s/__WORKSPACE__/${_G[ofile]}/g" |sed "s/__MODULE__/${_G[function]}/g" > $CWD/.drone.yml;;
	*) note $ci;;
	esac
}

# 随机数，加随机数是处理repeat for multiple options的情况
function _random() {
	echo $(($RANDOM$RANDOM$RANDOM%1000000))
}

function _checkKey() {
	echo $1 |grep "__$" &>/dev/null && echo "$1`_random`" || echo $1
}

function setV() {
	vKey="`echo "$1" |awk -F':' '{print $1}'`"
	vKey=`_checkKey $vKey`
	_V[$vKey]="`echo "$1"|awk -F':' '{print $2}'`"
}

function setM() {
	mKey="`echo "$1" |awk -F':' '{print $1}'`"
	mKey=`_checkKey $mKey`
	_M[$mKey]="`echo "$1"|awk -F':' '{print $2}'`"
}

# 只允许重置 ext- 开头的全局变量
function setG() {
	gKey="`echo $1 |awk -F':' '{print $1}'`"
	echo $gKey |grep "^ext\-" &>/dev/null && r=0 || r=1
	[ $r -eq 0 ] && _G[$gKey]="`echo $1|awk -F':' '{print $2}'`"
}

function setP() {
	[ "$1"x == ""x ] && return
	pKey="`echo $1|sed 's/^--//g'|awk -F'=' '{print $1}'`"
	pKey=`_checkKey $pKey`
	pVal=`echo $1|awk -F'=' '{print $2}'`

	# 支持 取消 布尔型设置(例如 --toc)
	if [ "$pVal"x == "false"x ]; then
		unset _P[$pKey]
	else
		_P[$pKey]=$pVal
	fi
}

function getV() {
	for k in ${!_V[@]};do
		_G[v]="${_G[v]} -V `echo $k |sed 's/__.*//g'`:`echo ${_V[$k]} |sed 's/ /\\\ /g'`"
	done
}

function getM() {
	for k in ${!_M[@]};do
		_G[m]="${_G[m]} -M `echo $k |sed 's/__.*//g'`:`echo ${_M[$k]} |sed 's/ /\\\ /g'`"
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
	# _G[ff] 用于 frontmatter 和 backmatter
	for item in ${!_F[@]};do
		_G[f]="${_G[f]} ${_F[$item]}"
		[ "$item"x != "add-header"x ] && _G[ff]="${_G[ff]} ${_F[$item]}"
	done
	for item in ${_F0[@]};do
		_G[f0]="${_G[f0]} $item"
		_G[ff]="${_G[ff]} $item"
	done
}

function heapSize() {
	if [ "${_G[memory]}"x != ""x ];then
		_G[heapsize]="+RTS -M${_G[memory]} -RTS"
	else
		_G[heapsize]=""
	fi
}

function getPandocParam() {
	crossrefYaml=""
	if [ "${_G[crossref]}"x != ""x ];then
		crossrefYaml="-M crossrefYaml=${_G[crs]}"
	fi
	getV
	getM
	getP
	getF
	heapSize
	_G[pandoc-param]="pandoc ${_G[heapsize]} ${_G[f0]} ${_G[crossref]} $crossrefYaml ${_G[citeproc]} ${_G[f]} ${_G[p]} ${_G[v]} ${_G[m]} ${_G[body]} -o ${_G[ofile]}.${_G[t]}"
}

function getXeLaTeXParam() {
	_G[xelatex]="${_G[interaction]}"
}

# 局部编译
function partCompile() {
	[ ${_G[part]} == "false" ] && return 0
	unset _P[include-before-body]
	unset _P[include-after-body]
	getArrayVar _V CJKmainfont SimSun
	getArrayVar _V CJKoptions "BoldFont=微软雅黑,ItalicFont=KaiTi,SmallCapsFont=微软雅黑"
	_P[standalone]=""
	unset _P[template]
	unset _P[toc]
	unset _P[bibliography]
	_M[lot]=false
	_M[lof]=false
	_M[title]=false
	_G[body]=${_G[part]}
	_G[ofile]=${_G[build]}/part
}