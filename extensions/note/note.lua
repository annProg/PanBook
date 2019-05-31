function Div(el)
	if el.attr.classes[1] == "note" then
		ret = pandoc.Div({})
		table.insert(ret.content, pandoc.RawInline("latex", "\\begin{note}"))
		for k,v in pairs(el.content) do
			table.insert(ret.content, v)
		end
		table.insert(ret.content, pandoc.RawInline("latex", "\\end{note}"))
		return ret
	end
end