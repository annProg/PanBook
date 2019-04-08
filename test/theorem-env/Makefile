all: ctex elegantbook epub

ctex:
	COVER=r panbook pdf

elegantbook:
	TPL=elegantbook panbook pdf
epub:
	panbook epub d

ctex: tex2 clean
ele: tex1 clean

tex2:
	xelatex 2.tex
	pdftocairo -png 2.pdf 2
	rm -f 2.pdf
	start 2-1.png
tex1:
	xelatex 1.tex
	pdftocairo -png 1.pdf 1
	rm -f 1.pdf
	start 1-1.png	
clean:
	rm -f *.log *.aux *.out