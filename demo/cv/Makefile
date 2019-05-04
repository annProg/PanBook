STYLE ?= classic
COLOR ?= blue
ALL_STYLE=classic banking casual oldstyle
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
	