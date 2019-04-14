#!/bin/bash
function printhelp()
{
	echo "Help"
	exit 0
}
function hello()
{
	echo "Hello Shell"
}

if [ $# -ge 1 ];then
	func=$1
	shift
else
	printhelp
fi

V=""

for i in "$@"
do
	key=$1
	case $key in
	-h|--help)
		FUNCHELP=true
		shift;;
	--tpl=*)
		TPL=${key#*=}
		shift;;
	--theme=*)
		THEME=${key#*=}
		shift;;
	-d|--debug)
		DEBUG=true
		shift;;
	-V)
		V="$V $2"
		shift 2;;
	*);;
	esac
done

echo "func: $func"
echo "FUNCHELP: $FUNCHELP"
echo "TPL: $TPL"
echo "THEME: $THEME"
echo "DEBUG: $DEBUG"

pandocV=""
for item in `echo $V`;do
	pandocV="$pandocV -V $item"
done

echo "$pandocV"

$func

type -t $func