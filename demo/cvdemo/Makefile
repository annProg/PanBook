STYLE ?= classic
COLOR ?= burgundy
ALL_STYLE=classic banking casual oldstyle fancy
ALL_COLOR=blue orange green red purple grey black burgundy
CJKMAIN=CJKmainfont:思源宋体
CJKOPT=CJKoptions:BoldFont=思源黑体,ItalicFont=KaiTi,SmallCapsFont=微软雅黑
CJK=-V $(CJKMAIN) -V $(CJKOPT)
all: moderncv-styles resume tmr
moderncv:
	panbook cv -M style:$(STYLE) -M color:$(COLOR) $(CJK)
moderncv-styles:
	for style in `echo $(ALL_STYLE)`;do \
		panbook cv -M style:$$style -M color:$(COLOR) -V onlinecv: -V showdate: $(CJK); \
	done
moderncv-all:
	for style in `echo $(ALL_STYLE)`;do \
		for color in `echo $(ALL_COLOR)`;do \
			panbook cv -M style:$$style -M color:$$color $(CJK); \
		done \
	done
resume:
	panbook cv --style=resume $(CJK)
	
tmr:
	panbook cv --style=tmr $(CJK)
	
png:
	cd build;for pdf in `ls cvdemo-cv-*.pdf`; do \
		pdftocairo -png $$pdf; \
		n=`echo $$pdf |sed 's/\.pdf//g'`; \
		convert -append `ls $$n-*.png` $$n.png; \
		rm -f $$n-*.png; \
	done	