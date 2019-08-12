SERVER ?= panbook.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /PanBook

THEME ?= metropolis
CONVERT ?= /mingw64/bin/convert
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:BoldFont=Source\ Han\ Serif\ SC\ Heavy,ItalicFont=FandolKai,SmallCapsFont=思源黑体

run:
	panbook slide --style=$(THEME) $(CJK)
all-theme:
	for id in `panbook slide -l`;do echo "Compile $$id ..";panbook slide --style=$$id $(CJK) || exit 1;done
	panbook slide --style=metropolis $(CJK)
png:
	cd build && mkdir all-beamer && mkdir all-beamer-title && \
	for item in `ls *.pdf`;do \
		theme=`echo $$item | sed 's/.pdf//g'`;\
		pdftocairo -png $$item $$theme;\
		$(CONVERT) -append $$theme-*.png all-beamer/$$theme.png;\
		mv $$theme-1.png all-beamer-title/$${theme}0.png;\
		rm -f $$theme-*.png;\
	done
link:
	for item in metropolis `panbook slide -l`;do echo "- [$$item](https://$(SERVER)/pub/beamer-slide-$$item.pdf)";done
online:
	scp -P $(PORT) build/beamer-*.pdf $(USER)@$(SERVER):$(DIR)
	
single:
	scp -P $(PORT) build/beamer-slide-$(THEME).pdf $(USER)@$(SERVER):$(DIR)