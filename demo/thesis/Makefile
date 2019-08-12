SERVER ?= panbook.annhe.net
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:BoldFont=Source Han Serif SC Heavy,ItalicFont=FandolKai,SmallCapsFont=思源黑体

all: thesis

thesis:
	panbook thesis $(CJK)

link:
	for item in `panbook thesis -l`;do echo "- [$$item](https://$(SERVER)/pub/thesis-thesis-$$item.pdf)";done

clean:
	panbook clean