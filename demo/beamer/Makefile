THEME ?= R
CONVERT ?= /mingw64/bin/convert

run:
	THEME=$(THEME) panbook beamer
	
png:
	cd build && mkdir all-beamer && mkdir all-beamer-title && \
	for item in `ls *.pdf`;do \
		theme=`echo $$item | sed 's/.pdf//g'`;\
		pdftocairo -png $$item $$theme;\
		$(CONVERT) -append $$theme-*.png all-beamer/$$theme.png;\
		mv $$theme-1.png all-beamer-title/$${theme}0.png;\
		rm -f $$theme-*.png;\
	done