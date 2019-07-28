all: pdf epub

pdf:
	pandoc --lua-filter plot.lua -F pandoc-crossref demo.md -o demo.pdf
epub:
	pandoc --lua-filter plot.lua -F pandoc-crossref demo.md -o demo.epub
tex:
	pandoc --lua-filter plot.lua -F pandoc-crossref demo.md -t latex