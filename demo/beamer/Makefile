SERVER ?= api.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /PanBook

THEME ?= R
CONVERT ?= /mingw64/bin/convert

run:
	panbook beamer --theme=$(THEME)
	
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
	for item in `grep "themeList=" ../../libs/module-beamer.sh |awk -F'=' '{print $$2}' |tr -d '()'`;do echo "- [$$item](https://$(SERVER)/PanBook/beamer-beamer-$$item.pdf)";done
online:
	scp -P $(PORT) build/beamer-*.pdf $(USER)@$(SERVER):$(DIR)