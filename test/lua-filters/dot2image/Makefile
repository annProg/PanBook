all: pdf latex

pdf:
	pandoc test.md --lua-filter dot2image.lua --extract-media=dot-images -o test.pdf --pdf-engine=xelatex
latex:
	pandoc test.md --lua-filter dot2image.lua --extract-media=dot-images -o test.tex --pdf-engine=xelatex	
md:
	pandoc test.md --lua-filter dot2image.lua --extract-media=dot-images -o test-result.md
