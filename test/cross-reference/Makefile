all: pdf epub

pdf:
	pandoc -F pandoc-crossref README.md -o README.pdf --pdf-engine=xelatex --listings -V CJKmainfont="思源宋体" -M listingTitle="代码" -M listings=true
latex:
	pandoc -s -F pandoc-crossref README.md -o README.tex --pdf-engine=xelatex --listings -V CJKmainfont="思源宋体" -M listingTitle="代码" -M listings=true
epub:
	pandoc -F pandoc-crossref README.md -o README.epub -M listingTitle="代码"
html:
	pandoc -F pandoc-crossref README.md -o README.html	-M listingTitle="代码"