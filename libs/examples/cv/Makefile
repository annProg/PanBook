STYLE ?= classic
COLOR ?= burgundy
ALL_STYLE=classic banking casual oldstyle fancy
ALL_COLOR=blue orange green red purple grey black burgundy
all: moderncv-styles resume tmr
moderncv:
	panbook cv -M style:$(STYLE) -M color:$(COLOR)
moderncv-styles:
	for style in `echo $(ALL_STYLE)`;do \
		panbook cv -M style:$$style -M color:$(COLOR) -V onlinecv: -V showdate:; \
	done
moderncv-all:
	for style in `echo $(ALL_STYLE)`;do \
		for color in `echo $(ALL_COLOR)`;do \
			panbook cv -M style:$$style -M color:$$color; \
		done \
	done
resume:
	panbook cv --style=resume
tmr:
	panbook cv --style=tmr	