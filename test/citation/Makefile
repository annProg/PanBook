all: bib

bib: clean run-bib

run-bib:
	xelatex test.tex
	bibtex test
	xelatex test.tex
	xelatex test.tex
	
clean:
	rm -f *.log *.aux *.bbl *.blg