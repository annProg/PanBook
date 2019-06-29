function LineBlock(block)
	return {
		pandoc.RawBlock("latex", "\\begin{lineblock}"),
		block,
		pandoc.RawBlock("latex","\\end{lineblock}")
	}
end