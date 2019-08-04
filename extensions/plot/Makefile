all: pdf epub

pdf:
	pandoc --lua-filter plot.lua -F pandoc-crossref demo.md -o demo.pdf --pdf-engine=xelatex -V CJKmainfont=FandolSong
epub:
	pandoc --lua-filter plot.lua -F pandoc-crossref demo.md -o demo.epub
tex:
	pandoc --lua-filter plot.lua -F pandoc-crossref demo.md -t latex
docx:
	pandoc --lua-filter plot.lua -F pandoc-crossref demo.md -o demo.docx