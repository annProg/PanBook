SERVER ?= api.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /PanBook

STYLE ?= classic
COLOR ?= blue
ALL_STYLE=classic banking casual oldstyle fancy
ALL_COLOR=blue orange green red purple grey black burgundy
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:ItalicFont=FandolKai -V sansfont:Source\ Serif\ Pro

all: moderncv-all-style resume tmr


moderncv-all-style:
	for style in `echo $(ALL_STYLE)`;do \
		panbook cv -M style:$$style -M color:$(COLOR) -V onlinecv:"" -V showdate:"" $(CJK) || exit 1; \
	done
moderncv-all-style-color:
	for style in `echo $(ALL_STYLE)`;do \
		for color in `echo $(ALL_COLOR)`;do \
			panbook cv -M style:$$style -M color:$$color $(CJK); \
		done \
	done
	
moderncv:
	panbook cv -M style:$(STYLE) -M color:$(COLOR) $(CJK)

resume:
	panbook cv --style=resume $(CJK)
tmr:
	panbook cv --style=tmr $(CJK)
png:
	cd build;for pdf in `ls cv-cv-*.pdf`; do \
		pdftocairo -png $$pdf; \
		n=`echo $$pdf |sed 's/\.pdf//g'`; \
		convert -append `ls $$n-*.png` $$n.png; \
		rm -f $$n-*.png; \
	done

link:
	for item in `echo $(ALL_STYLE)`;do echo "- [moderncv-$$item](https://$(SERVER)/PanBook/cv-cv-moderncv-$$item-blue.pdf)";done
	echo "- [resume](https://$(SERVER)/PanBook/cv-cv-resume.pdf)"
	echo "- [TMR](https://$(SERVER)/PanBook/cv-cv-tmr.pdf)"
	
online:
	scp -P $(PORT) build/cv-cv-moderncv-*-blue.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/cv-cv-resume.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/cv-cv-tmr.pdf $(USER)@$(SERVER):$(DIR)
	
clean:
	panbook clean	