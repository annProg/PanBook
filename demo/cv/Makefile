SERVER ?= api.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /PanBook

STYLE ?= classic
COLOR ?= blue
ALL_STYLE=classic banking casual oldstyle fancy
ALL_COLOR=blue orange green red purple grey black burgundy

all: moderncv-all-style-color


moderncv-all-style:
	for style in `echo $(ALL_STYLE)`;do \
		panbook cv -E style=$$style -E color=$(COLOR) -V onlinecv="" -V showdate=""; \
	done
moderncv-all-style-color:
	for style in `echo $(ALL_STYLE)`;do \
		for color in `echo $(ALL_COLOR)`;do \
			panbook cv -E style=$$style -E color=$$color; \
		done \
	done
	
moderncv:
	panbook cv -E style=$(STYLE) -E color=$(COLOR)
	
png:
	cd build;for pdf in `ls cv-cv-moderncv-*-blue.pdf`; do \
		pdftocairo -png $$pdf; \
		n=`echo $$pdf |sed 's/\.pdf//g'`; \
		convert -append `ls $$n-*.png` $$n.png; \
		rm -f $$n-*.png; \
	done

link:
	for item in `echo $(ALL_STYLE)`;do echo "- [moderncv-$$item](https://$(SERVER)/PanBook/cv-cv-moderncv-$$item-blue.pdf)";done
	
online:
	scp -P $(PORT) build/cv-cv-moderncv-*-blue.pdf $(USER)@$(SERVER):$(DIR)