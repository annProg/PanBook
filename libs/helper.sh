#!/bin/bash

function getEnv() {
	env |grep -w $1 &>/dev/null|| eval $1=$2
}

function info() {
	echo -e "\033[43;34m[INFO] $1\033[0m"
}

function note() {
	echo -e "\033[32m[NOTE] $1\033[0m"
}

function warn() {
	echo -e "\033[33m[WARN] $1\033[0m"
}

function error() {
	echo -e "\033[31m[ERRO] $1\033[0m"
	exit 1
}

function printhelp() {
	echo -e "  eBook maker base pandoc\n"
	echo -e "\tUsage: panbook <functions> [OPTIONS]\n"
	echo -e "  Available functions:"
	echo -e "\tinit        initialize work environment"
	echo -e "\tpdf         make pdf ebook"
	echo -e "\thtml        make html ebook"
	echo -e "\tepub        make epub ebook"
	echo -e "\tbeamer      make beamer"
	echo -e "\thelp        print help info"
	echo -e "\tsaveimg     save image url to local"
	echo -e "\teps         convert gif to eps"
	echo -e "  Available OPTIONS:"
	echo -e "\t--tpl       specify template for pandoc"
	echo -e "\t--class     specify documentclass for latex"
	echo -e "\t--theme     specify beamer theme"
	echo -e "\t-V key=val  simple add to pandoc command. Same with pandoc -V option"
	echo -e "\t-d --debug  debug mode"
	echo -e "\t-h --help   function help(if exists)"
	exit 0
}
