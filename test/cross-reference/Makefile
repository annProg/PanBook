all: pdf epub

pdf:
	pandoc README.md -o README.pdf --pdf-engine=xelatex --listings -V CJKmainfont="思源宋体"
epub:
	pandoc README.md -o README.epub