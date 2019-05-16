#!/bin/bash

function getVar() {
	cmd="echo \$$1"
	val=`eval $cmd`
	[ "$val"x == ""x ] && eval $1=$2
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
	echo -e "\033[31m[ERRO] $1\033[0m"
	exit 1
}

# 参数为 array名称  array key
function printArray() {
	arr=$1
	shift
	_info "Array $arr:"
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
}

function _loadExt() {
	ext=`basename $2`
	source $1/${_G[extdir]}/$ext/$ext.sh
}

function loadExtensions() {
	for item in `ls $SCRIPTDIR/${_G[extdir]}/`;do
		_loadExt $SCRIPTDIR $item
	done
	
	for item in `ls $CWD/${_G[extdir]}/ 2>/dev/null`;do
		_loadExt $CWD $item
	done
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
	_mkdir $CWD/${_G[tpldir]}
	_mkdir $CWD/${_G[stylecv]}
	_mkdir $CWD/${_G[stylebeamer]}
	_mkdir $CWD/${_G[stylebook]}
	_mkdir $CWD/${_G[stylethesis]}
	_mkdir $CWD/${_G[fontdir]}
}

function trimHeader() {
	# 删除$HEADERS空行，注释行
	sed -i -r 's/%.*$//g' ${_G[header]}
	sed -i -r '/^[\s\t ]*$|^%/d' ${_G[header]}
}

function checkTemplate() {
	# 未指定template时不做判断
	[ "${_P[template]}"x == ""x ] && return
	[ ! -f $CWD/build/${_P[template]}.tpl ] && error "Template ${_P[template]} not found." && printGlobal && exit 1
}

function clean() {
	cd ${_G[build]}
	rand=`echo $RANDOM$RANDOM$RANDOM$RANDOM`
	release="/tmp/release-$rand"
	mkdir $release
	mv *.pdf *.epub *.html $release 2>/dev/null
	[ ${_G[debug]} == "true" ] && mv *.tex *.bib $release 2>/dev/null
	rm -fr *
	mv $release/* .
	rm -fr $release
}

function printhelp() {
	echo -e "  eBook maker base pandoc\n"
	echo -e "\tUsage: panbook <functions> [OPTIONS]\n"
	echo -e "  Available functions:"
	echo -e "\tbook        make ebook"
	echo -e "\tthesis      make thesis"
	echo -e "\tbeamer      make beamer"
	echo -e "\tcv          make cv"
	echo -e "\thelp        print help info"
	echo -e "\tsaveimg     save image url to local"
	echo -e "\teps         convert gif to eps"
	echo -e "  Available OPTIONS:"
	echo -e "\t--style     specify a style"
	echo -e "\t--crs       specify pandoc-crossref settings file(default pandoc-crossref-settings.yaml)"
	echo -e "\t--src       specify src dir name(default src)"
	echo -e "\t--imgdir    specify image dir name(default src/images)"
	echo -e "\t-V key=val  same with pandoc -V option"
	echo -e "\t-M key=val  same with pandoc -M option"
	echo -e "\t--key=val   use original pandoc long option like this"
	echo -e "\t--key       use original pandoc long boolean option like this"
	echo -e "\t-d --debug  debug mode"
	echo -e "\t-h --help   function help(if exists)"
	exit 0
}
