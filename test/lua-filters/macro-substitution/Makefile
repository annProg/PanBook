all: test

test:
	pandoc -t gfm test.md --lua-filter=macro-substitution.lua -o result.md