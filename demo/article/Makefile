DEBUG ?= 
SERVER ?= panbook.annhe.net
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:BoldFont=Source\ Han\ Serif\ SC\ Heavy,ItalicFont=FandolKai,SmallCapsFont=思源黑体

all: build clean
build: ctexart elegantnote elegantpaper

ctexart:
	panbook art $(DEBUG) $(CJK)
elegantnote:
	panbook art --style=elegantnote $(DEBUG) $(CJK)
elegantpaper:
	panbook art --style=elegantpaper $(DEBUG) $(CJK)
link:
	for item in `panbook art -l`;do echo "- [$$item](https://$(SERVER)/pub/article-art-$$item.pdf)";done

clean:
	panbook clean