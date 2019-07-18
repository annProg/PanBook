all: test

test:
	pandoc -F pandoc-crossref --lua-filter tabu.lua simple.md -t latex
grid:
	pandoc -F pandoc-crossref --lua-filter tabu.lua grid.md -t latex
pipe:
	pandoc -F pandoc-crossref --lua-filter tabu.lua pipe.md -t latex
multiline:
	pandoc -F pandoc-crossref --lua-filter tabu.lua multiline.md -t latex
nohead:
	pandoc -F pandoc-crossref --lua-filter tabu.lua nohead.md -t latex