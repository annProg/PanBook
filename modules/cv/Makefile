STYLE ?= classic
COLOR ?= burgundy
ALL_STYLE=classic banking casual oldstyle fancy
ALL_COLOR=blue orange green red purple grey black burgundy
DEBUG ?=

all: moderncv-styles resume tmr clean
moderncv:
	panbook cv -M style:$(STYLE) -M color:$(COLOR) $(DEBUG)
moderncv-styles:
	for style in `echo $(ALL_STYLE)`;do \
		panbook cv -M style:$$style -M color:$(COLOR) -V onlinecv: -V showdate: $(DEBUG); \
	done
moderncv-all:
	for style in `echo $(ALL_STYLE)`;do \
		for color in `echo $(ALL_COLOR)`;do \
			panbook cv -M style:$$style -M color:$$color $(DEBUG); \
		done \
	done
resume:
	panbook cv --style=resume $(DEBUG)
tmr:
	panbook cv --style=tmr $(DEBUG)
	
clean:
	panbook clean