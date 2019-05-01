all: run

run:
	pandoc test.md --lua-filter dot2image.lua --extract-media=dot-images -o test.pdf --pdf-engine=xelatex