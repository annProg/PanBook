all: pdf epub

pdf:
	pandoc -F pandoc-crossref --lua-filter plot.lua demo.md -o demo.pdf
epub:
	pandoc -F pandoc-crossref --lua-filter plot.lua demo.md -o demo.epub
tex:
	pandoc -F pandoc-crossref --lua-filter plot.lua demo.md -t latex