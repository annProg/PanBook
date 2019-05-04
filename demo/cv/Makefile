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
		panbook cv -E style=$$style; \
	done
moderncv-all-style-color:
	for style in `echo $(ALL_STYLE)`;do \
		for color in `echo $(ALL_COLOR)`;do \
			panbook cv -E style=$$style -E color=$$color; \
		done \
	done
	
moderncv:
	panbook cv -E style=$(STYLE) -E color=$(COLOR)

link:
	for item in `echo $(ALL_STYLE)`;do echo "- [moderncv-$$item](https://$(SERVER)/PanBook/cv-cv-moderncv-$$item-blue.pdf)";done
	
online:
	scp -P $(PORT) build/cv-cv-moderncv-*-blue.pdf $(USER)@$(SERVER):$(DIR)