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
	echo -e "\tpanbook init        initialize work environment"
	echo -e "\tpanbook pdf         make pdf ebook"
	echo -e "\tpanbook html        make html ebook"
	echo -e "\tpanbook epub        make epub ebook"
	echo -e "\tpanbook beamer      make beamer"
	echo -e "\tpanbook help        print help info"
	echo -e "\tpanbook saveimg     save image url to local"
	echo -e "\tpanbook eps         convert gif to eps"
}
