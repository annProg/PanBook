OPT = -V CJKmainfont=NSimSun --pdf-engine=xelatex
REF = -F pandoc-crossref
LST = --listings
MINTED = --lua-filter minted.lua -s

all: pandoc listings minted crossref-pandoc crossref-listings crossref-minted

pandoc:
	pandoc  $(OPT) 1.md -o pandoc.pdf
listings:
	pandoc  $(OPT) $(LST) 1.md -o listings.pdf
minted:
	pandoc  $(OPT) $(MINTED) 1.md -o minted.tex
	xelatex -shell-escape minted.tex
	rm -f minted.tex
crossref-pandoc:
	pandoc  $(REF) $(OPT) 1.md -o crossref-pandoc.pdf
crossref-listings:
	pandoc  $(REF) -Mlistings $(OPT) $(LST) 1.md -o crossref-listings.pdf
crossref-minted:
	pandoc  $(REF) $(OPT) $(MINTED) 1.md -o crossref-minted.tex
	xelatex -shell-escape crossref-minted.tex
	rm -f crossref-minted.tex