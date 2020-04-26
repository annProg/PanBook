#!/bin/bash

function parseMeta() {
	# 仅支持key全为字母且值为string  赋值给 _MF 数组
	source <(grep -E "^[a-zA-Z]+: " ${_P[metadata-file]} | sed -e 's/\s*#.*$//g;s/:[^:\/\/]/\]="/g;s/$/"/g;s/ *=/=/g' |grep "=" |awk '{print "_MF["$0}')
}

# -M 参数指定的优先级更高
getMetaVar() {
	key=$1
	if [ "${_M[$key]}"x != ""x ]; then
		echo ${_M[$key]}
	elif [ "${_MF[$key]}"x != ""x ]; then
		echo ${_MF[$key]}
	else
		echo ""
	fi
}

function getVar() {
	cmd="echo \$$1"
	val=`eval $cmd`
	[ "$val"x == ""x ] && eval $1=$2
}

function getArrayVar() {
	[ $# -lt 3 ] && _error "getArrayVar error, param is $@"
	cmd="echo \${$1[$2]}"
	val=`eval $cmd`
	if [ "$val"x == ""x ];then
		setvalue="$1[$2]=$3"
		eval $setvalue
	fi
}

function note() {
	echo -e "\033[43;34m[NOTE] $1\033[0m"
}

function _info() {
	[ "${_G[debug]}"x == "true"x ] && echo -e "\033[32m[INFO] $1\033[0m"
}

function _warn() {
	[ "${_G[debug]}"x == "true"x ] && echo -e "\033[33m[WARN] $1\033[0m"
}

function _error() {
	printGlobal
	echo -e "\033[31m[ERRO] $1\033[0m"
	exit 1
}

# 参数为 array名称  array key
function printArray() {
	arr=$1
	shift
	_warn "Array $arr:"
	for key in $@;do
		val="value=\${$arr[$key]}"
		eval $val
		_info "$key:  $value"
	done
}

function printGlobal() {
	printArray _G ${!_G[@]}
	printArray _P ${!_P[@]}
	printArray _V ${!_V[@]}
	printArray _M ${!_M[@]}
	printArray _F ${!_F[@]}
	printArray _F0 ${!_F0[@]}
	printArray _MF ${!_MF[@]}
	# 总是返回true，防止Makefile报错
	true
}

# listings float
function floatListings() {
	[ "$1"x == ""x ] && return 0
	if [ "${_V[float-listings]}"x != ""x ];then
		# listings浮动体，避免代码块跨页
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/caption=(.*)?,\s*label=(.*)\]/caption=\1, label=\2, float=${_V[float-listings]}\]/" $1
		sed -i -E "/begin\{lstlisting.*label.*\]/ s/\[label=(.*)?\]/\[label=\1, caption=\1, float=${_V[float-listings]}\]/" $1
	fi
}

function _load() {
	item=`basename $3`
	source $1/${_G[$2]}/$item/$item.sh
}

function _loadRun() {
	loadtype=$1
	for item in `ls $SCRIPTDIR/${_G[$loadtype]}/`;do
		_load $SCRIPTDIR $loadtype $item
	done
	
	if [ "$CWD"x != "$SCRIPTDIR"x ];then
		for item in `ls $CWD/${_G[$loadtype]}/ 2>/dev/null`;do
			_load $CWD $loadtype $item
		done
	fi	
}

# loadModules需要支持用户自定义module，类似loadExtensions
function loadModules() {
	_loadRun moduledir
}

function loadExtensions() {
	_loadRun extdir
}

function loadStyle() {
	[ -d $SCRIPTDIR/${_G[style$1]}/$2 ] && _load $SCRIPTDIR style$1 $2
	[ -d $CWD/${_G[style$1]}/$2 ] && _load $CWD style$1 $2
}

function fixDir() {
	if [ "$_G[src]"x != "src" ]; then
		_G[workdir]=$CWD/${_G[src]}
		_P[bibliography]=${_G[workdir]}/bibliography.bib
		if [ "${_P[metadata-file]}"x == "$CWD/src/metadata.yaml"x ]; then
			_P[metadata-file]=${_G[workdir]}/metadata.yaml
		fi
		if [ "${_G[imgdir]}"x == "$CWD/src/images"x ]; then
			_G[imgdir]=${_G[workdir]}/images
		fi
	fi
}

function _gitignore() {
	[ ! -f $CWD/.gitignore ] && cp $SCRIPTDIR/.gitignore $CWD
}

function _mkdir() {
	[ ! -d $1 ] && mkdir -p $1
}

function mkDir() {
	_gitignore
	_mkdir ${_G[workdir]}
	_mkdir ${_G[build]}
	_mkdir ${_G[imgdir]}
	_mkdir $CWD/${_G[extdir]}
	_mkdir $CWD/${_G[moduledir]}
	_mkdir $CWD/${_G[tpldir]}
	_mkdir $CWD/${_G[stylecv]}
	_mkdir $CWD/${_G[styleslide]}
	_mkdir $CWD/${_G[stylebook]}
	_mkdir $CWD/${_G[stylethesis]}
	_mkdir $CWD/${_G[fontdir]}
}

function writeHeader() {
	# 考虑 $1 为空的情况（允许用户将参数清空来避免写入header）
	[ "$1"x == ""x ] && return 0
	[ ! -f $1 ] && _error "writeHeader error: $1 not found."
	echo "" >> ${_G[header]}
	cat $1 >> ${_G[header]}
}

function func_clean() {
	cd ${_G[build]}
	rand=`echo $RANDOM$RANDOM$RANDOM$RANDOM`
	release="/tmp/release-${_G[function]}-$rand"
	mkdir $release
	# 有文件不存在时会返回 1，导致Makefile有报错，这里用true忽略错误
	mv *.pdf *.epub *.html $release 2>/dev/null;true
	[ ${_G[debug]} == "true" ] && mv *.tex *.bib $release 2>/dev/null;true
	rm -fr *
	mv $release/* . 2>/dev/null
	rm -fr $release
}

function compileStatus() {
	status=$?
	_info "$1 Compile status: $status"
	if [ $status -ne 0 ];then
		_error "$1 Compile status is not 0. Please Check. you may add -d or --trace to see more output"
	else
		note "$1 Compile SUCCESSFUL"
	fi
}

function func_ext() {
	_help ext
}

function func_mod() {
	_help mod
}

function _call() {
	if [ "`type -t $1`"x == "function"x ];then
		$1
	else
		_error "Function: $1 not defined"
	fi
}

# 帮助函数名称规范: ext_column_help ，func_cv_help
function _help() {
	if [ "$1"x == "ext"x -o "$1"x == "mod"x ];then
		if [ $# == 1 ];then
			echo -e "\tUsage: panbook $1 <-h|--help|-l|--list> <$1_name>"
			exit 0
		else
			callHelp=${_G[function]}"_"$2"_help"
		fi
	else
		if [ $# == 2 ];then
			n="_$2"
			loadStyle ${_G[function]} $2
		else
			n=""
		fi
		callHelp=${_G[func-pre]}_${_G[function]}$n"_help"
	fi

	_call $callHelp 
}

# 列出函数名称规范: ext_list， func_cv_list
function _list() {
	if [ "$1"x == "ext"x -o "$1"x == "mod"x ];then
		callList=${_G[function]}_list
	else
		if [ $# == 1 ];then
			style_list $1
			exit 0
		else
			loadStyle ${_G[function]} $2
			callList=${_G[func-pre]}_${_G[function]}"_"$2"_list"
		fi
	fi

	_call $callList
}

function style_list() {
	[ "${_G[style$1]}"x == ""x ] && _error "no style for $1"
	ls $SCRIPTDIR/${_G[style$1]} |tr ' ' '\n'
	if [ "$CWD"x != "$SCRIPTDIR"x ];then
		ls $CWD/${_G[style$1]} 2>/dev/null |tr ' ' '\n'
	fi
}

function ext_list() {
	# 直接输出全局变量内容，要求扩展自己注册到 _G[extensions]
	echo ${_G[extensions]} |tr ' ' '\n'
}

function mod_list() {
	# 直接输出全局变量内容，要求扩展自己注册到 _G[modules]
	echo ${_G[modules]} |tr ' ' '\n'	
}

# 注册扩展
function regext() {
	_G[extensions]="${_G[extensions]} $1"
}

# 注册模块
function regmod() {
	_G[modules]="${_G[modules]} $1"
}

function _formatHelp() {
	helptype=$1
	shift
	for k in $@;do
		val="val=\${$helptype[$k]}"
		eval $val
		printf "\t%-12s%-30s\n" $k "$val"
	done
}
# 获取 functions帮助
function getH() {
	_formatHelp _H ${!_H[@]}
}

function getHF() {
	_formatHelp _HF ${!_HF[@]}
}

function printhelp() {
	# 定义辅助函数帮助
	declare -A _HF
	_HF[help]="print help info"
	_HF[saveimg]="save image url to local"
	_HF[eps]="convert gif to eps"
	_HF[clean]="clean build dir"
	_HF[ext]="extensions help"
	_HF[mod]="modules help"

	echo -e "  eBook maker base pandoc\n"
	echo -e "\tUsage: panbook <command> [OPTIONS]\n"
	echo -e "  Available module command:"
	getH
	echo -e "  Available command:"
	getHF
	echo -e "  Available OPTIONS(you can also use pandoc long option):"
	echo -e "\t--style     change style(list styles: panbook <module> -l)"
	echo -e "\t--crs       change pandoc-crossref settings(default crs/zh-CN.yaml)"
	echo -e "\t--src       change src directory name(default src)"
	echo -e "\t--imgdir    change image directory name(default src/images)"
	echo -e "\t--part      only compile specified markdown file"
	echo -e "\t--ci=val    init with ci config(support: drone)"
	echo -e "\t--memory    limit the maximum heap size(e.g. 1000m)"
	echo -e "\t-V key:val  same with pandoc -V option"
	echo -e "\t-M key:val  same with pandoc -M option"
	echo -e "\t-G key:val  change panbook global variable"
	echo -e "\t--key=val   use original pandoc long option like this"
	echo -e "\t--key       original pandoc boolean option(=false can unset option)"
	echo -e "\t-d --debug  debug mode"
	echo -e "\t-h --help   function help(if exists)"
	echo -e "\t-l --list   function list(if exists)"
	echo -e "\t--trace     trace mode"
	exit 0
}
