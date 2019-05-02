all: bib

bib: clean run-bib

run-bib:
	xelatex test.tex
	bibtex test
	xelatex test.tex
	xelatex test.tex
	
pandoc:
	pandoc -F pandoc-citeproc --bibliography=test.bib --csl=chinese-gb7714-2005-numeric.csl test-pandoc.md -o test.tex -s -V documentclass=ctexbook
	pandoc -F pandoc-citeproc --bibliography=test.bib --csl=chinese-gb7714-2005-numeric.csl test-pandoc.md -o test.pdf --pdf-engine=xelatex -V CJKmainfont="NSimSun" -V documentclass=ctexbook -V classoption=fancyhdr -V pagestyle=fancy --top-level-division=chapter
clean:
	rm -f *.log *.aux *.bbl *.blg