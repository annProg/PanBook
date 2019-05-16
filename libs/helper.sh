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
	ext=`basename $1`
	source $SCRIPTDIR/extensions/$ext/$ext.sh
}

function loadExtensions() {
	for item in `ls $SCRIPTDIR/extensions/`;do
		_loadExt $item
	done
	
	for item in `ls $CWD/extensions/ 2>/dev/null`;do
		_loadExt $item
	done
}

function fixDir() {
	if [ "$_G[src]"x != "src" ]; then
		_G[workdir]=$CWD/${_G[src]}
		_G[bib]=${_G[workdir]}/bibliography.bib
		_G[metafile]=${_G[workdir]}/metadata.yaml
		if [ "${_G[imgdir]}"x == "$CWD/src/images"x ]; then
			_G[imgdir]=${_G[workdir]}/images
		fi
	fi
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
