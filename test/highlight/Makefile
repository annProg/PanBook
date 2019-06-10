OPT = -V CJKmainfont=FondolSong --pdf-engine=xelatex
REF = -F pandocrossref-crossref
LST = --listings
MINTED = --lua-filter minted.lua

all: pandoc listings minted crossref-pandoc crossref-listings crossref-minted

pandoc:
	pandoc  $(OPT) 1.md -o pandoc.pdf
listings:
	pandoc  $(OPT) $(LST) 1.md -o listings.pdf
minted:
	pandoc  $(OPT) $(MINTED) 1.md -o minted.pdf
crossref-pandoc:
	pandoc  $(REF) $(OPT) 1.md -o crossref-pandoc.pdf
crossref-listings:
	pandoc  $(REF) $(OPT) $(LST) 1.md -o crossref-listings.pdf
crossref-minted:
	pandoc  $(REF) $(OPT) $(MINTED) 1.md -o crossref-minted.pdf