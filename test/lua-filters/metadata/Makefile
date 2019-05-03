all: run header

run:
	pandoc --lua-filter merge-meta.lua README.md -o README.tex -s
header:
	pandoc -F pandoc-crossref -M listings=true --listings --lua-filter add-header.lua README.md -o README.tex -s