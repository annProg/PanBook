THEME ?= R
CONVERT ?= convert

run:
	THEME=$(THEME) panbook beamer
	
png:
	cd build && \
	for item in `ls *.pdf`;do \
		theme=`echo $$item | sed 's/.pdf//g'`;\
		pdftocairo -png $$item $$theme;\
		$(CONVERT) -append $$theme-*.png $$theme.png;\
		rm -f $$theme-*.png;\
	done