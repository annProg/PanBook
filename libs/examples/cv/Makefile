STYLE ?= classic
COLOR ?= burgundy
ALL_STYLE=classic banking casual oldstyle fancy
ALL_COLOR=blue orange green red purple grey black burgundy
all: moderncv-styles resume
moderncv:
	panbook cv -E style=$(STYLE) -E color=$(COLOR)
moderncv-styles:
	for style in `echo $(ALL_STYLE)`;do \
		panbook cv -E style=$$style -E color=$(COLOR) -V onlinecv="" -V showdate=""; \
	done
moderncv-all:
	for style in `echo $(ALL_STYLE)`;do \
		for color in `echo $(ALL_COLOR)`;do \
			panbook cv -E style=$$style -E color=$$color; \
		done \
	done
resume:
	panbook cv --cv=resume
all-tpl:
	panbook cv --cv=A		
