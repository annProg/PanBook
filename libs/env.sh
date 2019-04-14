#!/bin/bash

highlightStyle=(pygments kate monochrome espresso haddock tango zenburn breezedark)
DATE=`date +%Y/%m/%d`
DATETIME=`date +%Y/%m/%d\ %H:%M:%S`
DEBUG="false"
CMD_CONVERT="convert"
[ "`uname -o`"x == "Msys"x ] && CMD_CONVERT="/mingw64/bin/convert"
